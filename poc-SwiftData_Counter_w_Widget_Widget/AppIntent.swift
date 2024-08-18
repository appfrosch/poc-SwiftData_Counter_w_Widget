//
//  AppIntent.swift
//  poc-SwiftData_Counter_w_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import AppIntents

struct AddNewItemIntent: AppIntent {
  static var title: LocalizedStringResource = "Add new item intent"

  func perform() async throws -> some IntentResult {
    return .result()
  }
}
