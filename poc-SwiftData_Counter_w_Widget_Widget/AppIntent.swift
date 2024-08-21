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
    print("AddNewItemIntent button tapped")
    let newItem = Item(timestamp: Date())
    await DataModel.shared.modelContainer.mainContext.insert(newItem)
    return .result()
  }
}
