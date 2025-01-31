//
//  RecipeLocalRepository.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

internal protocol RecipeLocalRepositoryProtocol {
  func addNewRecipes(_ newRecipes: [RecipeModel]) async
  func getAllRecipes() async -> [RecipeModel]
}

internal actor RecipeLocalRepository: RecipeLocalRepositoryProtocol {
  private var recipes: [RecipeModel]

  init(recipes: [RecipeModel] = []) {
    self.recipes = recipes
  }

  func addNewRecipes(_ newRecipes: [RecipeModel]) {
    recipes = newRecipes
  }

  func getAllRecipes() -> [RecipeModel] {
    recipes
  }
}

internal class RecipeLocalRepositoryMock: RecipeLocalRepositoryProtocol {
  var recipes = [RecipeModel]()
  var expectedRecipes = [RecipeModel]()
  var addNewRecipesTriggered = false
  var getAllRecipesTriggered = false

  func addNewRecipes(_ newRecipes: [RecipeModel]) async {
    recipes = newRecipes
    addNewRecipesTriggered = true
  }

  func getAllRecipes() async -> [RecipeModel] {
    getAllRecipesTriggered = true
    return recipes
  }
}
