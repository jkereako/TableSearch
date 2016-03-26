//
//  TableSearchUITests.swift
//  TableSearchUITests
//
//  Created by Jeff Kereakoglow on 3/23/16.
//  Copyright © 2016 Alexis Digital. All rights reserved.
//

import XCTest

class TableSearchUITests: XCTestCase {

  override func setUp() {
    super.setUp()

    continueAfterFailure = false
    XCUIApplication().launch()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func testExample() {
    
    let app = XCUIApplication()
    app.navigationBars["TableSearch.Container"].buttons["Search"].tap()
    app.buttons["Cancel"].tap()
    app.tables.containingType(.Cell, identifier:"cell").element.tap()
    
    let element = app.otherElements.containingType(.NavigationBar, identifier:"TableSearch.Container").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
    element.childrenMatchingType(.Image).element.tap()
    app.buttons["Brandy"].tap()
    element.childrenMatchingType(.SearchField).element.tap()

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }

}
