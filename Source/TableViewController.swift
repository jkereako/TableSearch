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
  private var scope: Spirit = .None
  private var searchTerm = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    cocktails = [
      Cocktail(spirit: .Brandy, name: "B&B"),
      Cocktail(spirit: .Brandy, name: "Stinger"),
      Cocktail(spirit: .Brandy, name: "Sidecar"),
      Cocktail(spirit: .Gin, name: "Aviation"),
      Cocktail(spirit: .Gin, name: "Gimlet"),
      Cocktail(spirit: .Gin, name: "Martini"),
      Cocktail(spirit: .Gin, name: "Daisy Mae"),
      Cocktail(spirit: .Gin, name: "Negroni"),
      Cocktail(spirit: .Whiskey, name: "Veaux Carré"),
      Cocktail(spirit: .Whiskey, name: "Manhattan"),
      Cocktail(spirit: .Whiskey, name: "Whiskey sour"),
      Cocktail(spirit: .Tequila, name: "Margarita"),
      Cocktail(spirit: .Rum, name: "Daiquiri"),
      Cocktail(spirit: .Rum, name: "Mai Tai"),
      Cocktail(spirit: .Rum, name: "Mojito")
    ]

    viewModel.dataSource = cocktails
    tableView.dataSource = viewModel

    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false

    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = [
      Spirit.None.rawValue,
      Spirit.Brandy.rawValue, Spirit.Gin.rawValue, Spirit.Rum.rawValue,
      Spirit.Tequila.rawValue, Spirit.Whiskey.rawValue, Spirit.Vodka.rawValue
    ]

    // Initialize the scope selection to All
    searchController.searchBar.selectedScopeButtonIndex = 0

    tableView.tableHeaderView = searchController.searchBar
  }

  override func viewWillAppear(animated: Bool) {
    clearsSelectionOnViewWillAppear = true

    super.viewWillAppear(animated)
  }
}

extension TableViewController: UISearchBarDelegate {
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

  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    // Reset the state
    searchBar.selectedScopeButtonIndex = 0
    scope = .None
    searchTerm = ""
  }
}

extension TableViewController: UISearchResultsUpdating {
  func updateSearchResultsForSearchController(searchController: UISearchController) {

    // Check for a search term. This method is invoked when the user taps the search bar for the
    // first time __and__ when the user cancels the search.
    guard let searchTerm = searchController.searchBar.text else {
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
}
