//
//  ShimmeringRedacted.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//


import SwiftUI

struct ShimmeringRedacted: ViewModifier {
  @State private var phase: CGFloat = 0
  @State private var isActive: Bool

  init(isActive: Bool) {
    self.isActive = isActive
  }

  func body(content: Content) -> some View {
    if isActive {
      content
        .redacted(reason: .placeholder)
        .overlay(
          shimmer
            .mask(content)
        )
        .onAppear {
          withAnimation(Animation.linear(duration: 1.5)
            .repeatForever(autoreverses: false)) {
              phase = 1
            }
        }
    } else {
      content
    }
  }

  private var shimmer: some View {
    LinearGradient(
      gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.4), Color.clear]),
      startPoint: .leading,
      endPoint: .trailing
    )
    .rotationEffect(.degrees(30))
    .offset(x: phase * 200 - 100)
    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: phase)
  }
}

extension View {
  func shimmeringRedacted(isActive: Bool = true) -> some View {
    self.modifier(ShimmeringRedacted(isActive: isActive))
  }
}
