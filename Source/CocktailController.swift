//
//  ViewController.swift
//  TableSearch
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import UIKit

class CocktailController: UIViewController {
  var cocktail: Cocktail!

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var comment: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    name.text = cocktail.name
    comment.text = cocktail.comment ?? ""
  }
}

