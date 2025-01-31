//
//  Logger+EXT.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import OSLog

extension Logger {
  enum Category: String {
    case network
    case imageCaching
    case recipeListViewModel

    func description() -> String {
      rawValue.capitalized
    }
  }

  private static var subsystem = "FetchRecipes"

  static func category(_ category: Category) -> Logger {
    Self(subsystem: subsystem, category: category.description())
  }
}
