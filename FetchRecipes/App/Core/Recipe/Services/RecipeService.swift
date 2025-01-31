//
//  RecipeService.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

enum ServiceError: Error {
  case invalidRecipe
  case emptyList
}

internal protocol RecipeServiceProtocol {
  func fetchRecipes() async throws -> [RecipeModel]
}

internal class RecipeService: RecipeServiceProtocol {
  private let networkService: RecipeNetworkServiceProtocol
  private let localRepository: RecipeLocalRepositoryProtocol

  init(networkService: RecipeNetworkServiceProtocol, localRepository: RecipeLocalRepositoryProtocol) {
    self.networkService = networkService
    self.localRepository = localRepository
  }

  func fetchRecipes() async throws -> [RecipeModel] {
    let newRecipes = try await networkService.fetchRecipes()
    guard !newRecipes.isEmpty else { throw ServiceError.emptyList }
    if newRecipes.contains(where: { !$0.isValidRecipe }) {
      throw ServiceError.invalidRecipe
    }
    await localRepository.addNewRecipes(newRecipes)
    return await localRepository.getAllRecipes()
  }
}

internal class RecipeServiceMock: RecipeServiceProtocol {
  var expectedRecipes = [RecipeModel]()
  var fetchRecipesTriggered = false
  private var isMalformedData: Bool {
    expectedRecipes.contains(where: { !$0.isValidRecipe })
  }

  func fetchRecipes() async throws -> [RecipeModel] {
    fetchRecipesTriggered = true
    try? await Task.sleep(for: .seconds(0.5))
    if isMalformedData {
      throw ServiceError.invalidRecipe
    } else if expectedRecipes.isEmpty {
      throw ServiceError.emptyList
    } else {
      return expectedRecipes
    }
  }
}
