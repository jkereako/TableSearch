//
//  TableViewModel.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

class CocktailTableViewModel: NSObject {
  var dataSource: [Cocktail] = []
  var selectedCocktail: Cocktail?
}

extension CocktailTableViewModel: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Why oh why does this return an optional?
    let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
    let cocktail = dataSource[indexPath.row]

    cell.textLabel?.text = cocktail.name
    cell.detailTextLabel?.text = cocktail.spirit.rawValue

    return cell
  }
}

extension CocktailTableViewModel: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedCocktail = dataSource[indexPath.row]
  }
}
