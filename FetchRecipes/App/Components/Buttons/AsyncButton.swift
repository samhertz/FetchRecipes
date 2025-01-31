//
//  AsyncButton.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//

import SwiftUI

struct AsyncButton: View {
  @State private var isLoading: Bool = false
  private let title: String
  private let action: () async -> Void

  init(title: String,
       action: @escaping () async -> Void) {
    self.title = title
    self.action = action
  }

  var body: some View {
    Button {
      Task {
        isLoading = true
        await action()
        isLoading = false
      }
    } label: {
      if isLoading {
        ProgressView()
          .tint(.white)
      } else {
        Text(title)
      }
    }
    .disabled(isLoading)
  }
}

#Preview {
  func action() async {
    try? await Task.sleep(for: .seconds(2))
    print("Run action after 2 seconds")
  }

  return AsyncButton(title: "Refresh", action: action)
}
