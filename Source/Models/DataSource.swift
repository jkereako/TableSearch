//
//  DataSource.swift
//  TableSearch
//
//  Created by Jeffrey Kereakoglow on 3/24/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import Foundation

struct DataSource {
  static let cocktails = [
    Cocktail(spirit: .Brandy, name: "B&B", comment: nil),
    Cocktail(spirit: .Brandy, name: "Stinger", comment: nil),
    Cocktail(spirit: .Brandy, name: "Sidecar", comment: "Art deco drink."),
    Cocktail(spirit: .Gin, name: "Aviation", comment: "My absolute favorite cocktail"),
    Cocktail(spirit: .Gin, name: "Gimlet", comment: "Has got to be made with gin, not vodka and with Rose's preserved lime juice."),
    Cocktail(spirit: .Gin, name: "Martini", comment: "It's actually stirred, not shaken."),
    Cocktail(spirit: .Gin, name: "Daisy Mae", comment: "Someone once told me that it tastes like pizza sauce."),
    Cocktail(spirit: .Gin, name: "Negroni", comment: "Bitter"),
    Cocktail(spirit: .Whiskey, name: "Veaux Carré", comment: "Essential NOLA"),
    Cocktail(spirit: .Whiskey, name: "Manhattan", comment: "This ought to be your standard order."),
    Cocktail(spirit: .Whiskey, name: "Whiskey sour", comment: "Best when combined with raw egg white froth."),
    Cocktail(spirit: .Tequila, name: "Margarita", comment: nil),
    Cocktail(
      spirit: .Rum,
      name: "Daiquiri",
      comment: "Not the frozen garbage that's served in a 32oz. plastic cup."
    ),
    Cocktail(spirit: .Rum, name: "Mai Tai", comment: "It's not just a Chinese restaurant drink."),
    Cocktail(spirit: .Rum, name: "Mojito", comment: nil)
  ]
}