//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by eunseou on 12/30/24.
//

import SwiftUI

public enum NavigationType {
  case main
  case subBack
  case subClose
  case feature
  
  var hasLeftButton: Bool {
    switch self {
    case .subBack, .feature: true
    default: false
    }
  }
  
  var hasRightButton: Bool {
    switch self {
    case .main, .subClose, .feature: true
    default: false
    }
  }
  
  var textStyle: Fonts.Pretendard {
    switch self {
    case .main: .heading_S_M
    default: .heading_S_SB
    }
  }
}


// NavigationBar 뷰 정의
public struct NavigationBar: View {
  // Main
  public init(
    title: String,
    titleColor: Color = .grayscaleBlack,
    rightImage: ImageResource,
    rightButtonTap: (() -> Void)? = nil,
    backgroundColor: Color? = .clear
  ) {
    self.init(
      type: .main,
      title: title,
      titleColor: titleColor,
      rightButtonTap: rightButtonTap,
      rightImage: rightImage,
      backgroundColor: backgroundColor
    )
  }
  
  // SubBack
  public init(
    title: String,
    titleColor: Color = .grayscaleBlack,
    leftButtonTap: @escaping () -> Void,
    backgroundColor: Color? = .clear
  ) {
    self.init(
      type: .subBack,
      title: title,
      titleColor: titleColor,
      leftButtonTap: leftButtonTap,
      backgroundColor: backgroundColor
    )
  }
  
  // SubClose
  public init(
    title: String,
    titleColor: Color = .grayscaleBlack,
    rightButtonTap: @escaping () -> Void,
    backgroundColor: Color? = .clear
  ) {
    self.init(
      type: .subClose,
      title: title,
      titleColor: titleColor,
      rightButtonTap: rightButtonTap,
      backgroundColor: backgroundColor
    )
  }
  
  // Feature
  public init(
    title: String,
    titleColor: Color = .grayscaleBlack,
    leftButtonTap: @escaping () -> Void,
    rightButtonTap: (() -> Void)? = nil,
    label: String,
    backgroundColor: Color? = .clear
  ) {
    self.init(
      type: .feature,
      title: title,
      titleColor: titleColor,
      leftButtonTap: leftButtonTap,
      rightButtonTap: rightButtonTap,
      label: label,
      backgroundColor: backgroundColor
    )
  }
  
  // Common
  private init(
    type: NavigationType,
    title: String,
    titleColor: Color = .grayscaleBlack,
    leftButtonTap: (() -> Void)? = nil,
    rightButtonTap: (() -> Void)? = nil,
    rightImage: ImageResource? = nil,
    label: String? = nil,
    backgroundColor: Color? = .clear
  ) {
    self.type = type
    self.title = title
    self.titleColor = titleColor
    self.leftButtonTap = leftButtonTap
    self.rightButtonTap = rightButtonTap
    self.rightImage = rightImage
    self.label = label
    self.backgroundColor = backgroundColor
  }
  
  // MARK: - Body
  public var body: some View {
    ZStack {
      backgroundColor?.edgesIgnoringSafeArea(.top)
      HStack {
        if type.hasLeftButton {
          Button {
            leftButtonTap?()
          } label: {
            Image(.chevronLeft32)
              .renderingMode(.template)
              .foregroundColor(titleColor ?? .none)
          }
          .padding(.leading, 20)
        }
        
        Spacer()
        
        if type.hasRightButton {
          Button {
            rightButtonTap?()
          } label: {
            if let rightImage = rightImage {
              Image(rightImage)
                .renderingMode(.template)
                .foregroundColor(titleColor ?? .none)
            } else if let label = label {
              Text(label)
                .foregroundColor(.primaryDefault)
            } else {
              Image(.close32)
                .renderingMode(.template)
                .foregroundColor(titleColor ?? .none)
            }
          }
          .padding(.trailing, 20)
        }
      }
      
      Text(title)
        .foregroundColor(titleColor ?? .grayscaleBlack)
        .pretendard(type.textStyle)
        .frame(
          maxWidth: .infinity,
          alignment: type == .main ? .leading : .center
        )
        .padding(
          .leading,
          type == .main ? 20 : 0
        )
    }
    .frame(maxWidth: .infinity)
    .frame(height: 60)
  }
  
  private let type: NavigationType
  private let title: String
  private let titleColor: Color?
  private let rightImage: ImageResource?
  private let rightButtonTap: (() -> Void)?
  private let leftButtonTap: (() -> Void)?
  private let label: String?
  private let backgroundColor: Color?
}

#Preview {
  ZStack {
    Color.grayscaleBlack.edgesIgnoringSafeArea(.all)
    VStack {
      NavigationBar(
        title: "Feature Name",
        titleColor: .grayscaleWhite,
        rightImage: .null32,
        backgroundColor: .clear
      )
      NavigationBar(
        title: "Feature Name",
        rightButtonTap: {},
        backgroundColor: .white
      )
      NavigationBar(
        title: "Feature Name",
        leftButtonTap: {},
        backgroundColor: .white)
      NavigationBar(
        title: "Feature Name",
        leftButtonTap: {},
        label: "label",
        backgroundColor: .white
      )
    }
  }
}
