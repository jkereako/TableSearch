//
//  ContainerController.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/25/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

let dismissSearchBarNotification = NSBundle.mainBundle().bundleIdentifier! + ".dismissSearchBar"

final class ContainerController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!

  private var constraintConstants = (searchBar: CGFloat(-88.0), container: CGFloat(-44.0))
//  private let containerTopConstants = (-44.0, 44.0)

  override func viewDidLoad() {
    super.viewDidLoad()

    NSNotificationCenter.defaultCenter().addObserver(
      self, selector: #selector(dismissSearchBar), name: dismissSearchBarNotification, object: nil
    )
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "embedCocktailTable", let toVC = segue.destinationViewController as?
      CocktailTableViewController else {
        assertionFailure("Expected a `CocktailTableViewController`.")
        return
    }

    searchBar.delegate = toVC
  }

  override func updateViewConstraints() {
    searchBarTopConstraint.constant = constraintConstants.searchBar
    containerTopConstraint.constant = constraintConstants.container

    super.updateViewConstraints()
  }
}

extension ContainerController {
  func displaySearchBar() {

    constraintConstants.searchBar = 0
    constraintConstants.container = 44.0

    view.layoutIfNeeded()
    view.setNeedsUpdateConstraints()
    view.updateConstraintsIfNeeded()

    UIView.animateWithDuration(
      0.25,
      animations: { [unowned self] in
        self.view.layoutIfNeeded()
      }
    )
  }

  func dismissSearchBar() {

    constraintConstants.searchBar = -88.0
    constraintConstants.container = -44.0

    // Ensures that all pending layout operations have been completed
    view.layoutIfNeeded()
    view.setNeedsUpdateConstraints()
    view.updateConstraintsIfNeeded()

    UIView.animateWithDuration(
      0.25,
      animations: { [unowned self] in

        self.view.endEditing(false)
        self.view.layoutIfNeeded()
      }
    )
  }

  func toggleSearchBar() {
    if self.searchBarTopConstraint.constant == 0 {
      dismissSearchBar()
    }
    else {
      displaySearchBar()
    }
  }

  @IBAction func searchButtonAction(sender: UIBarButtonItem) {
    toggleSearchBar()
  }
}
