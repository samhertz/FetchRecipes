//
//  DynamicButtonStyle.swift
//  FetchRecipes
//
//  Created by Samuel Hertz on 1/28/25.
//

import SwiftUI

struct DynamicButtonStyle: ButtonStyle {
  let backgroundColor: Color
  let font: Font
  let fontColor: Color
  let buttonHeight: CGFloat
  let cornerRadius: CGFloat

  static let buttonHeight: CGFloat = 44
  static let cornerRadius: CGFloat = 10

  init(backgroundColor: Color = .buttonBlue,
       font: Font = .subheadline.weight(.semibold),
       fontColor: Color = .textWhite,
       buttonHeight: CGFloat = Self.buttonHeight,
       cornerRadius: CGFloat = Self.cornerRadius) {
    self.backgroundColor = backgroundColor
    self.font = font
    self.fontColor = fontColor
    self.buttonHeight = buttonHeight
    self.cornerRadius = cornerRadius
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(font)
      .foregroundStyle(fontColor)
      .frame(maxWidth: .infinity, minHeight: buttonHeight)
      .background(backgroundColor)
      .clipShape(.rect(cornerRadius: cornerRadius))
      .opacity(configuration.isPressed ? 0.8 : 1.0)
  }
}

extension ButtonStyle where Self == DynamicButtonStyle {
  // fully custom button style
  static func dynamicButtonStyle(
    backgroundColor: Color = .buttonBlue,
    font: Font = .subheadline.weight(.semibold),
    fontColor: Color = .textWhite,
    buttonHeight: CGFloat = Self.buttonHeight,
    cornerRadius: CGFloat = Self.cornerRadius) -> Self {
      Self(backgroundColor: backgroundColor,
           font: font,
           fontColor: fontColor,
           buttonHeight: buttonHeight,
           cornerRadius: cornerRadius)
    }

  // prebuilt implementations
  static var blueButtonStyle: Self { Self() }
}

#Preview {
  VStack {
    Button {
      print("Refresh list")
    } label: {
      Text("Refresh")
    }
    .buttonStyle(.blueButtonStyle)
  }
  .padding(.horizontal)
}
