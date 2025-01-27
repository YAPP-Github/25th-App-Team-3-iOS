//
//  Modules.swift
//  ProjectDescriptionHelpers
//
//  Created by summercat on 12/18/24.
//

import ProjectDescription

public enum Modules {
  case data
  case domain
  case utility
  case presentation
}

// MARK: - Data

public extension Modules {
  enum Data: String {
    case LocalStorage // 임시
    
    var path: String {
      "Data/\(self.rawValue)"
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}

// MARK: - Domain

public extension Modules {
  enum Domain: String {
    case Entities
    
    var path: String {
      switch self {
      case .Entities: "Domain/\(self.rawValue)"
      default: "Domain/UseCase/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      switch self {
      case .Entities:  "\(self.rawValue)"
      default: "\(self.rawValue)UseCase"
      }
    }
  }
}

// MARK: - Utility

public extension Modules {
  enum Utility: String {
    case PCFoundationExtension
    
    var path: String {
      "Utility/\(self.rawValue)"
    }
    
    var targetName: String {
      "\(self.rawValue)"
    }
  }
}

// MARK: - Presentation

public extension Modules {
  enum Presentation: String {
    case DesignSystem
    case Router
    case AppCoordinator
    case Login
    case MatchingMain
    
    var path: String {
      switch self {
      case .DesignSystem, .Router, .AppCoordinator: "Presentation/\(self.rawValue)"
      default: "Presentation/Feature/\(self.rawValue)"
      }
    }
    
    var targetName: String {
      switch self {
      case .DesignSystem, .Router, .AppCoordinator: "\(self.rawValue)"
      default: "\(self.rawValue)"
      }
    }
  }
}
