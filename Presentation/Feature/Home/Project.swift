//
// Project.swift
// Home
//
// Created by summercat on 2025/01/30.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.staticLibrary(
  name: Modules.Presentation.Home.rawValue,
  dependencies: [
    .presentation(target: .DesignSystem),
    .presentation(target: .Router),
    .presentation(target: .Profile),
    .presentation(target: .MatchingMain),
  ]
)
