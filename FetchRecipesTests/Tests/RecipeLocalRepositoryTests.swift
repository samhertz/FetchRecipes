//
//  RecipeLocalRepositoryTests.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//

import XCTest
@testable import FetchRecipes

final class RecipeLocalRepositoryTests: XCTestCase {
  var repository: RecipeLocalRepository!

  override func setUp() {
    super.setUp()
    repository = RecipeLocalRepository()
  }

  override func tearDown() {
    repository = nil
    super.tearDown()
  }

  func testAddNewRecipes() async {
    await repository.addNewRecipes(RecipeModel.validMocks)
    let storedRecipes = await repository.getAllRecipes()
    XCTAssertEqual(storedRecipes, RecipeModel.validMocks, "Recipes should be stored correctly")
  }
}
