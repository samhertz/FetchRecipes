//
//  RecipeListRowViewBuilder.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import SwiftUI

struct RecipeListRowViewBuilder: View {
  private let recipe: RecipeModel
  private let imageCache: ImageCaching?

  init(recipe: RecipeModel, imageCache: ImageCaching?) {
    self.recipe = recipe
    self.imageCache = imageCache
  }

  var body: some View {
    CustomListCellView(imageUrlString: recipe.photoUrlSmall, title: recipe.name, subtitle: recipe.cuisine, imageCache: imageCache)
  }
}

#Preview {
  let imageCache = ImageCache()

  List {
    RecipeListRowViewBuilder(recipe: RecipeModel.validMock1, imageCache: imageCache)
    RecipeListRowViewBuilder(recipe: RecipeModel.validMock2, imageCache: imageCache)
    RecipeListRowViewBuilder(recipe: RecipeModel.invalidMock1, imageCache: imageCache)
    RecipeListRowViewBuilder(recipe: RecipeModel.invalidMock2, imageCache: imageCache)
    RecipeListRowViewBuilder(recipe: RecipeModel.invalidMock3, imageCache: imageCache)
  }
}
