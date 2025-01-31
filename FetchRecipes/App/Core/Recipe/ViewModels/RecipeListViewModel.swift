//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import SwiftUI
import OSLog

@MainActor
internal class RecipeListViewModel: ObservableObject {
  enum ViewState {
    case loaded(recipes: [RecipeModel])
    case loading
    case invalid
    case empty
  }

  private static let logger = Logger.category(.recipeListViewModel)
  @Published private(set) var viewState = ViewState.loading
  private let service: RecipeServiceProtocol

  init(service: RecipeServiceProtocol) {
    self.service = service
  }

  func getRecipes() async {
    viewState = .loading
    do {
      Self.logger.info("Fetching recipes")
      let recipes = try await service.fetchRecipes()
      Self.logger.info("Loaded with \(recipes.count) recipes")
      viewState = .loaded(recipes: recipes)
    } catch let error as ServiceError {
      switch error {
      case .invalidRecipe:
        Self.logger.warning("Invalid recipes returned")
        viewState = .invalid
      case .emptyList:
        Self.logger.warning("Empty list of recipes returned")
        viewState = .empty
      }
    } catch {
      Self.logger.warning("Unexpected error: \(error.localizedDescription)")
      viewState = .invalid
    }
  }
}
