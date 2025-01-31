//
//  RecipeServiceTests.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/31/25.
//

import XCTest
@testable import FetchRecipes

final class RecipeServiceTests: XCTestCase {
  var service: RecipeService!
  var mockNetwork: RecipeNetworkServiceMock!
  var mockRepository: RecipeLocalRepositoryMock!

  override func setUp() {
    super.setUp()
    mockNetwork = RecipeNetworkServiceMock()
    mockRepository = RecipeLocalRepositoryMock()
    service = RecipeService(networkService: mockNetwork, localRepository: mockRepository)
  }

  override func tearDown() {
    service = nil
    mockNetwork = nil
    mockRepository = nil
    super.tearDown()
  }

  func testFetchRecipesSuccess() async throws {
    mockNetwork.expectedRecipes = RecipeModel.validMocks
    let recipes = try await service.fetchRecipes()
    XCTAssertEqual(recipes, RecipeModel.validMocks, "Service should return fetched recipes")
  }

  func testFetchRecipesEmptyList() async {
    mockNetwork.expectedRecipes = RecipeModel.emptyMocks
    do {
      _ = try await service.fetchRecipes()
      XCTFail("Expected to throw emptyList error")
    } catch ServiceError.emptyList {
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }

  func testFetchRecipesMalformedList() async {
    mockNetwork.expectedRecipes = RecipeModel.invalidMocks
    do {
      _ = try await service.fetchRecipes()
      XCTFail("Expected to throw emptyList error")
    } catch ServiceError.invalidRecipe {
    } catch {
      XCTFail("Unexpected error: \(error)")
    }
  }
}
