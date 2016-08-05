//
//  TableViewController.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

final class CocktailTableViewController: UITableViewController {
  private let viewModel = CocktailTableViewModel()
  private var cocktails = [Cocktail]()
  private var scope = Spirit.None
  private var searchTerm = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    definesPresentationContext = true

    cocktails = DataSource.cocktails

    viewModel.dataSource = cocktails
    tableView.dataSource = viewModel
  }

  override func viewWillAppear(animated: Bool) {
    clearsSelectionOnViewWillAppear = true

    super.viewWillAppear(animated)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let toVC = segue.destinationViewController as? CocktailController
      where segue.identifier == "showDetail", let cell = sender as? UITableViewCell else {
        assertionFailure(
          "Expected the destination to be a `ViewController` with a particular segue identifier."
        )
        return
    }

    let indexPath = tableView.indexPathForCell(cell)!
    let selected = viewModel.dataSource[indexPath.row]

    toVC.cocktail = selected
  }
}

extension CocktailTableViewController: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    // Check for a search term. This method is invoked when the user taps the search bar for the
    // first time __and__ when the user cancels the search.
    guard let searchTerm = searchBar.text else {
      assertionFailure("Expected a search text to have a value.")
      return
    }

    self.searchTerm = searchTerm

    var filteredCocktails = cocktails

    if scope != .None {
      filteredCocktails = filterCocktailsBySpirit(cocktails: cocktails, spirit: scope)
    }

    if searchTerm.characters.count > 0 {
      filteredCocktails = filterCocktailsByName(cocktails: filteredCocktails, name: searchTerm)
    }

    viewModel.dataSource = filteredCocktails

    tableView.reloadData()
  }

  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    guard let scope = searchBar.scopeButtonTitles?[selectedScope],
      let spirit = Spirit(rawValue: scope) else {

        assertionFailure("Expected a Spirit enum")

        return
    }

    self.scope = spirit

    var filteredCocktails = cocktails

    if spirit != .None {
      filteredCocktails = filterCocktailsBySpirit(cocktails: cocktails, spirit: spirit)
    }

    if searchTerm.characters.count > 0 {
      filteredCocktails = filterCocktailsByName(cocktails: filteredCocktails, name: searchTerm)
    }

    viewModel.dataSource = filteredCocktails

    tableView.reloadData()
  }

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()

    // Dismiss the search bar from the parent view
    NSNotificationCenter.defaultCenter().postNotificationName(
      dismissSearchBarNotification, object: nil
    )
  }

  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    // Reset the state
    searchBar.text = ""
    searchBar.selectedScopeButtonIndex = 0
    scope = .None
    searchTerm = ""
    viewModel.dataSource = cocktails

    searchBar.resignFirstResponder()

    // Dismiss the search bar from the parent view. Why are we making the call here instead of
    // inside `searchBarTextDidEndEditing`? Because `searchBarTextDidEndEditing` is invoked when
    // the table view transitions to the detail view which then dismisses the search bar. We don't
    // want that.
    NSNotificationCenter.defaultCenter().postNotificationName(
      dismissSearchBarNotification, object: nil
    )
  }

  func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
    return true
  }

  func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    tableView.reloadData()
  }
}
