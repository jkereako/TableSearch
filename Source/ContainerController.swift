//
//  ContainerController.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/25/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

let dismissSearchBarNotification = NSBundle.mainBundle().bundleIdentifier! + ".dismissSearchBar"

class ContainerController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!

  let searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
    super.viewDidLoad()

    definesPresentationContext = true
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
}

extension ContainerController {
  func dismissSearchBar() {
    toggleSearchBar()
  }
  
  func toggleSearchBar() {
    searchBar.hidden = false
    // see: http://stackoverflow.com/questions/12622424/how-do-i-animate-constraint-changes#12664093

    view.layoutIfNeeded()

    UIView.animateWithDuration(
      0.25,
      animations: { [unowned self] in
        if self.searchBarTopConstraint.constant == 0 {
          self.searchBarTopConstraint.constant = -88.0
          self.containerTopConstraint.constant = -44.0
        }

        else {
          self.searchBarTopConstraint.constant = 0
          self.containerTopConstraint.constant = 44.0
        }

        self.view.layoutIfNeeded()
      }
    )
  }

  @IBAction func searchButtonAction(sender: UIBarButtonItem) {
    toggleSearchBar()
  }
}
