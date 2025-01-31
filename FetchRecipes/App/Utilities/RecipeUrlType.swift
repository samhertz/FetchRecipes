//
//  RecipeUrlType.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//
import Foundation

enum RecipeUrlType {
  case all
  case malformed
  case empty

  var urlString: String {
    switch self {
    case .all:
      return Constants.allRecipes
    case .malformed:
      return Constants.malformedRecipes
    case .empty:
      return Constants.emptyRecipes
    }
  }
}
