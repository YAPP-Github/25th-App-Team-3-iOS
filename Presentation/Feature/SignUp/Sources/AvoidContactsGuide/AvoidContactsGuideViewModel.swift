//
//  AvoidContactsGuideViewModel.swift
//  SignUp
//
//  Created by eunseou on 1/17/25.
//

import SwiftUI
import Observation

@Observable
final class AvoidContactsGuideViewModel {
  enum Action {
    case tapBlockContactButton
    case tapBackButton
    case tapDenyButton
  }
  
  private var dismissAction: (() -> Void)?
  
  func handleAction(_ action: Action) {
    switch action {
    case .tapBackButton:
      dismissAction?()
    default :
      return
    }
  }
  
  func setDismissAction(_ dismiss: @escaping () -> Void) {
    self.dismissAction = dismiss
  }
}
