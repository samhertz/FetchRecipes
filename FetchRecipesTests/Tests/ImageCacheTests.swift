//
//  ImageCacheTests.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//

import XCTest
@testable import FetchRecipes

final class ImageCacheTests: XCTestCase {
  var imageCache: ImageCache!
  let testURL = URL(string: "https://example.com/test.jpg")!
  
  override func setUp() {
    super.setUp()
    imageCache = ImageCache()
  }
  
  override func tearDown() {
    imageCache = nil
    super.tearDown()
  }
  
  func testLoadImageFromCache() async throws {
    let expectedImage = UIImage(systemName: "star")!
    imageCache.memoryCache.setObject(expectedImage, forKey: testURL.absoluteString as NSString)
    
    let cachedImage = try await imageCache.loadImage(from: testURL)
    XCTAssertEqual(cachedImage, expectedImage, "Image should be retrieved from cache")
  }
}
