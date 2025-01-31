//
//  RecipeNetworkService.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import Foundation

internal protocol RecipeNetworkServiceProtocol {
  func fetchRecipes() async throws -> [RecipeModel]
}

internal class RecipeNetworkService: BaseNetwork, RecipeNetworkServiceProtocol {
  func fetchRecipes() async throws -> [RecipeModel] {
    guard let url = URL(string: RecipeUrlType.all.urlString) else { throw NetworkError.invalidURL }

    let recipeContainer: RecipeContainer = try await request(from: url)

    return recipeContainer.recipes
  }
}

internal class RecipeNetworkServiceMock: RecipeNetworkServiceProtocol {
  var expectedRecipes = [RecipeModel]()

  func fetchRecipes() async throws -> [RecipeModel] {
    try? await Task.sleep(for: .seconds(0.5))
    return expectedRecipes
  }
}
