//
//  TableViewController.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  let searchController = UISearchController(searchResultsController: nil)

  private let viewModel = TableViewModel()
  private var cocktails: [Cocktail] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    cocktails = [
      Cocktail(spirit: .Gin, name: "Aviation"),
      Cocktail(spirit: .Gin, name: "Gimlet"),
      Cocktail(spirit: .Gin, name: "Martini"),
      Cocktail(spirit: .Whiskey, name: "Whiskey sour"),
      Cocktail(spirit: .Tequila, name: "Margarita"),
      Cocktail(spirit: .Rum, name: "Daiquiri")
    ]

    viewModel.dataSource = cocktails
    tableView.dataSource = viewModel

    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = true

    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = [
      Spirit.Brandy.rawValue, Spirit.Gin.rawValue, Spirit.Rum.rawValue,
      Spirit.Tequila.rawValue, Spirit.Whiskey.rawValue, Spirit.Vodka.rawValue
    ]

    tableView.tableHeaderView = searchController.searchBar
  }
}


extension TableViewController: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

    guard let scope = searchBar.scopeButtonTitles?[selectedScope],
      let spirit = Spirit(rawValue: scope) else {

        assertionFailure("Expected a Spirit enum")

        return
    }

    viewModel.dataSource = filterCocktailsBySpirit(
      cocktails: cocktails, spirit: spirit
    )

    tableView.reloadData()
  }

  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    // Reset the cocktails back to the full set
    viewModel.dataSource = cocktails

    tableView.reloadData()
  }
}

extension TableViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {

    viewModel.dataSource = filterCocktailsByName(
      cocktails: cocktails, name: searchController.searchBar.text ?? ""
    )
    
    tableView.reloadData()
  }
}
