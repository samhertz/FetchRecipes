//
//  ImageCache.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//

import Foundation
import OSLog
import UIKit

internal protocol ImageCaching {
  func loadImage(from url: URL) async throws -> UIImage
}

internal class ImageCache: ImageCaching {
  private static let logger = Logger.category(.imageCaching)
  let memoryCache = NSCache<NSString, UIImage>()

  enum CacheError: Error {
    case invalidImageData
    case networkError(reason: String)
  }

  func loadImage(from url: URL) async throws -> UIImage {
    let cacheKey = url.absoluteString as NSString

    // Check in-memory cache first
    if let cachedImage = memoryCache.object(forKey: cacheKey) {
      Self.logger.info("Image returned from cache \(url)")
      return cachedImage
    }

    // If not in memory, fetch from the network
    do {
      let (data, _) = try await URLSession.shared.data(from: url)

      guard let image = UIImage(data: data) else {
        throw CacheError.invalidImageData
      }

      // Cache the image in memory for future use
      memoryCache.setObject(image, forKey: cacheKey)

      Self.logger.info("Image returned from network \(url)")
      return image
    } catch {
      Self.logger.error("Network error fetching image: \(error.localizedDescription)")
      throw CacheError.networkError(reason: error.localizedDescription)
    }
  }
}

internal class ImageCacheMock: ImageCaching {
  var expectedImage: UIImage?
  var loadImageTriggered = false

  func loadImage(from url: URL) async throws -> UIImage {
    loadImageTriggered = true
    return expectedImage!
  }
}
