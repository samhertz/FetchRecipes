//
//  RecipeModel.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

/* Example JSON:
{
  "recipes": [
    {
      "cuisine": "British",
      "name": "Bakewell Tart",
      "photo_url_large": "https://some.url/large.jpg",
      "photo_url_small": "https://some.url/small.jpg",
      "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
      "source_url": "https://some.url/index.html",
      "youtube_url": "https://www.youtube.com/watch?v=some.id"
    },
    ...
  ]
}
 */

import Foundation

internal struct RecipeContainer: Decodable {
  let recipes: [RecipeModel]
}

internal struct RecipeModel: Identifiable, Decodable, Equatable {
  let cuisine: String?
  let name: String?
  let photoUrlLarge: String?
  let photoUrlSmall: String?
  let sourceUrl: String?
  let uuid: String?
  let youtubeUrl: String?

  var id: String {
    return uuid ?? UUID().uuidString
  }

  var isValidRecipe: Bool {
    let requiredProperties: [String?] = [cuisine, name, uuid]
    return requiredProperties.allSatisfy { $0 != nil }
  }

  init(cuisine: String?,
       name: String?,
       photoUrlLarge: String?,
       photoUrlSmall: String?,
       sourceUrl: String?,
       uuid: String?,
       youtubeUrl: String?) {
    self.cuisine = cuisine
    self.name = name
    self.photoUrlLarge = photoUrlLarge
    self.photoUrlSmall = photoUrlSmall
    self.sourceUrl = sourceUrl
    self.uuid = uuid
    self.youtubeUrl = youtubeUrl
  }

  enum CodingKeys: String, CodingKey {
    case cuisine
    case name
    case photoUrlLarge = "photo_url_large"
    case photoUrlSmall = "photo_url_small"
    case sourceUrl = "source_url"
    case uuid
    case youtubeUrl = "youtube_url"
  }

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.cuisine = try container.decodeIfPresent(String.self, forKey: .cuisine)
    self.name = try container.decodeIfPresent(String.self, forKey: .name)
    self.photoUrlLarge = try container.decodeIfPresent(String.self, forKey: .photoUrlLarge)
    self.photoUrlSmall = try container.decodeIfPresent(String.self, forKey: .photoUrlSmall)
    self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
    self.uuid = try container.decodeIfPresent(String.self, forKey: .uuid)
    self.youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
  }
}

extension RecipeModel {
  static let validMock1 = RecipeModel(cuisine: "Cuisine 1", name: "Recipe Name 1", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/mock1", uuid: "Recipe-1-UUID", youtubeUrl: "https://youtube.mock.recipes.com/mock1")
  static let validMock2 = RecipeModel(cuisine: "Cuisine 2", name: "Recipe Name 2", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/mock2", uuid: "Recipe-2-UUID", youtubeUrl: "https://youtube.mock.recipes.com/mock2")
  static let validMock3 = RecipeModel(cuisine: "Cuisine 3", name: "Recipe Name 3", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/mock3", uuid: "Recipe-3-UUID", youtubeUrl: "https://youtube.mock.recipes.com/mock3")
  static let validMock4 = RecipeModel(cuisine: "Cuisine 4", name: "Recipe Name 4", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/mock4", uuid: "Recipe-4-UUID", youtubeUrl: "https://youtube.mock.recipes.com/mock4")
  static let validMocks: [RecipeModel] = [validMock1, validMock2, validMock3, validMock4]

  static let invalidMock1 = RecipeModel(cuisine: "Invalid Cuisine 1", name: "Invalid Recipe Name 1", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/invalid-mock1", uuid: nil, youtubeUrl: "https://youtube.invalid.mock.recipes.com/invalid-mock1")
  static let invalidMock2 = RecipeModel(cuisine: "Invalid Cuisine 2", name: nil, photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/invalid-mock2", uuid: nil, youtubeUrl: "https://youtube.invalid.mock.recipes.com/invalid-mock2")
  static let invalidMock3 = RecipeModel(cuisine: nil, name: "Invalid Recipe Name 3", photoUrlLarge: Constants.randomLargeImage, photoUrlSmall: Constants.randomSmallImage, sourceUrl: "https://source.mock.recipes.com/invalid-mock3", uuid: nil, youtubeUrl: "https://youtube.invalid.mock.recipes.com/invalid-mock3")
  static let invalidMocks: [RecipeModel] = validMocks + [invalidMock1]

  static let emptyMocks: [RecipeModel] = []
}
