//
//  CustomListCellView.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/27/25.
//


import SwiftUI

struct CustomListCellView: View {
  private let imageUrlString: String?
  private let title: String?
  private let subtitle: String?
  private let imageCache: ImageCaching?

  init(imageUrlString: String? = Constants.randomSmallImage,
       title: String? = nil,
       subtitle: String? = nil,
       imageCache: ImageCaching?) {
    self.imageUrlString = imageUrlString
    self.title = title
    self.subtitle = subtitle
    self.imageCache = imageCache
  }

  var body: some View {
    HStack(spacing: 8) {
      ImageLoaderView(urlString: imageUrlString, imageCache: imageCache)
        .frame(height: 60)
        .cornerRadius(16)

      VStack(alignment: .leading, spacing: 4) {
        if let title = title {
          Text(title)
            .font(.headline)
        }
        if let subtitle = subtitle {
          Text(subtitle)
            .font(.subheadline)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .padding(12)
    .padding(.vertical, 4)
    .background(Color(uiColor: .systemBackground))
  }
}

#Preview {
  VStack {
    let imageCache = ImageCache()
    CustomListCellView(imageUrlString: Constants.randomSmallImage, title: "Chicken Alfredo", subtitle: "Italian", imageCache: imageCache)
    CustomListCellView(imageUrlString: nil, title: "Pão de Queijo", subtitle: "Brazilian", imageCache: imageCache)
    CustomListCellView(imageUrlString: Constants.randomSmallImage, title: nil, subtitle: "American", imageCache: imageCache)
    CustomListCellView(imageUrlString: Constants.randomSmallImage, title: "Pizza", subtitle: nil, imageCache: imageCache)
    CustomListCellView(imageUrlString: nil, title: nil, subtitle: nil, imageCache: imageCache)
  }
}
