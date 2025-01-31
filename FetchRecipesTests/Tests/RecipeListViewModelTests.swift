//
//  RecipeListViewModelTests.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/31/25.
//

import XCTest
@testable import FetchRecipes

@MainActor
final class RecipeListViewModelTests: XCTestCase {
  var viewModel: RecipeListViewModel!
  var mockService: RecipeServiceMock!
  let testRecipes = RecipeModel.validMocks

  override func setUp() {
    super.setUp()
    mockService = RecipeServiceMock()
    viewModel = RecipeListViewModel(service: mockService)
  }

  override func tearDown() {
    viewModel = nil
    mockService = nil
    super.tearDown()
  }

  func testViewModelLoadsRecipes() async {
    mockService.expectedRecipes = testRecipes
    await viewModel.getRecipes()
    if case .loaded(let recipes) = viewModel.viewState {
      XCTAssertEqual(recipes, testRecipes, "ViewModel should load recipes correctly")
    } else {
      XCTFail("ViewModel did not transition to loaded state")
    }
  }
}
