//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import SwiftUI

struct RecipeListView: View {
  @ObservedObject private var viewModel: RecipeListViewModel
  private let imageCache: ImageCaching

  init(viewModel: RecipeListViewModel, imageCache: ImageCaching) {
    self.viewModel = viewModel
    self.imageCache = imageCache
  }

  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.viewState {
        case .loaded(recipes: let recipes):
          loadedView(with: recipes)
        case .loading:
          loadingView
        case .empty:
          emptyView
        case .invalid:
          invalidView
        }
      }
      .task(onRefresh)
      .navigationTitle("Recipes")
      .refreshable(action: onRefresh)
    }
  }

  private var loadingView: some View {
    List(RecipeModel.validMocks) { recipe in
      RecipeListRowViewBuilder(recipe: recipe, imageCache: nil)
        .shimmeringRedacted()
    }
  }

  private var emptyView: some View {
    CustomContentUnavailableView(title: "Empty Recipe List", systemImage: "list.bullet.clipboard", description: "No recipes were received. Please try again.", buttonText: "Refresh", buttonAction: onRefresh)
  }

  private var invalidView: some View {
    CustomContentUnavailableView(title: "Oops", systemImage: "exclamationmark.warninglight", description: "There was an issue with getting data. Please try again.", buttonText: "Refresh", buttonAction: onRefresh)
  }

  private func loadedView(with recipes: [RecipeModel]) -> some View {
    List(recipes) { recipe in
      RecipeListRowViewBuilder(recipe: recipe, imageCache: imageCache)
    }
  }

  @Sendable private func onRefresh() async {
    await viewModel.getRecipes()
  }
}

#Preview("All Recipes") {
  let service = RecipeServiceMock()
  service.expectedRecipes = RecipeModel.validMocks
  let viewModel = RecipeListViewModel(service: service)
  return RecipeListView(viewModel: viewModel, imageCache: ImageCache())
}

#Preview("Malformed Recipes") {
  let service = RecipeServiceMock()
  service.expectedRecipes = RecipeModel.invalidMocks
  let viewModel = RecipeListViewModel(service: service)
  return RecipeListView(viewModel: viewModel, imageCache: ImageCache())
}

#Preview("Empty Recipes") {
  let service = RecipeServiceMock()
  service.expectedRecipes = RecipeModel.emptyMocks
  let viewModel = RecipeListViewModel(service: service)
  return RecipeListView(viewModel: viewModel, imageCache: ImageCache())
}
