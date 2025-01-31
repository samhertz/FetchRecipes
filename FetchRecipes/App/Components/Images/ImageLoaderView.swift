//
//  ImageLoaderView.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//


import SwiftUI

struct ImageLoaderView: View {
  @State private var image: UIImage? = nil
  @State private var showErrorImage: Bool = false

  private let urlString: String?
  private let imageCache: ImageCaching?

  init(urlString: String?, imageCache: ImageCaching?) {
    self.urlString = urlString
    self.imageCache = imageCache
  }

  var body: some View {
    Group {
      if let image = image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Rectangle()
          .fill(.secondary)
          .aspectRatio(1, contentMode: .fit)
          .shimmeringRedacted(isActive: !showErrorImage)
      }
    }
    .onAppear { loadImage() }
  }

  private func loadImage() {
    Task {
      guard let imageCache else { return }
      guard let urlString, let url = URL(string: urlString) else { throw URLError(.badURL) }
      do {
        let fetchedImage = try await imageCache.loadImage(from: url)
        self.image = fetchedImage
      } catch {
        self.showErrorImage = true
      }
    }
  }
}

#Preview {
    let imageCache = ImageCache()
  VStack {
    ImageLoaderView(urlString: Constants.randomSmallImage, imageCache: imageCache)
      .frame(height: 60)
      .cornerRadius(16)
    ImageLoaderView(urlString: Constants.randomLargeImage, imageCache: imageCache)
      .frame(height: 100)
      .cornerRadius(16)
    ImageLoaderView(urlString: nil, imageCache: imageCache)
      .frame(height: 60)
      .cornerRadius(16)
    ImageLoaderView(urlString: "Invalid URL", imageCache: imageCache)
      .frame(height: 100)
      .cornerRadius(16)
  }
}
