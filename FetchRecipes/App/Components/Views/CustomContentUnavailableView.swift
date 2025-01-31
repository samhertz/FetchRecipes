//
//  CustomContentUnavailableView.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//

import SwiftUI

struct CustomContentUnavailableView: View {
  let title: String
  let systemImage: String
  let description: String
  let buttonText: String
  let buttonAction: () async -> Void

  var body: some View {
    if #available(iOS 17.0, *) {
      higherVersionView
    } else {
      lowerVersionView
    }
  }

  @available(iOS 17.0, *)
  private var higherVersionView: some View {
    ContentUnavailableView {
      Label(title, systemImage: systemImage)
    } description: {
      Text(description)
    } actions: {
      AsyncButton(title: buttonText, action: buttonAction)
        .frame(minWidth: 300)
        .buttonStyle(.blueButtonStyle)
    }
    .foregroundStyle(.textBlack)
  }

  private var lowerVersionView: some View {
    VStack(spacing: 8) {
      Image(systemName: systemImage)
        .font(.system(size: 48))
        .foregroundStyle(.secondary)

      Text(title)
        .font(.title2)
        .bold()
        .multilineTextAlignment(.center)

      Text(description)
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .padding(.bottom, 10)

      AsyncButton(title: buttonText, action: buttonAction)
        .frame(maxWidth: 300)
        .buttonStyle(.blueButtonStyle)
    }
    .frame(maxHeight: .infinity)
    .padding()
    .foregroundStyle(.textBlack)
  }
}

#Preview {
  func action() async {
    try? await Task.sleep(for: .seconds(2))
    print("Run action after 2 seconds")
  }

  return CustomContentUnavailableView(title: "Empty Recipe List", systemImage: "list.bullet.clipboard", description: "No recipes were received. Please try again.", buttonText: "Refresh", buttonAction: action)
}
