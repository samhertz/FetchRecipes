//
//  FetchRecipesApp.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
  @StateObject private var recipeListViewModel = RecipeListViewModel(service: RecipeService(networkService: RecipeNetworkService(), localRepository: RecipeLocalRepository()))
  let imageCache = ImageCache()

  var body: some Scene {
    WindowGroup {
      RecipeListView(viewModel: recipeListViewModel, imageCache: imageCache)
    }
  }
}
