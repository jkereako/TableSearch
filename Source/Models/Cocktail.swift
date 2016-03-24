//
//  Cocktail.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

struct Cocktail {
  let spirit: String
  let name: String
}

func filterCocktailsBySpirit(cocktails cocktails: [Cocktail], spirit: String) -> [Cocktail] {
  return cocktails.filter({ (cocktail: Cocktail) -> Bool in
    // Check for an exact match
    cocktail.spirit.lowercaseString == spirit.lowercaseString
  })
}

func filterCocktailsByName(cocktails cocktails: [Cocktail], name: String) -> [Cocktail] {
  return cocktails.filter({ (cocktail: Cocktail) -> Bool in
    // Check for a substring
    cocktail.name.lowercaseString.containsString(name.lowercaseString)
  })
}
