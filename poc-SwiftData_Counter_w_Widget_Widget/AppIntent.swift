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
    //https://stackoverflow.com/questions/78895555/non-sendable-type-in-implicitly-asynchronous-access-warning-when-accessing-the
    await DataModel.shared.modelContainer.mainContext.insert(newItem)
    return .result()
  }
}
