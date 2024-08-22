//
//  AppIntent.swift
//  poc-SwiftData_Counter_w_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import AppIntents

struct AddNewItemIntent: AppIntent {
  static var title: LocalizedStringResource = "Add new item intent"

  // My naive approach results in the following warning w/ Swift 5–
  // this will probably be an error w/ Swift 6
  // `Non-sendable type 'ModelContext' in implicitly asynchronous access to main actor-isolated property 'mainContext' cannot cross actor boundary`

//  func perform() async throws -> some IntentResult {
//    print("AddNewItemIntent button tapped")
//    let newItem = Item(timestamp: Date())
//    await DataModel.shared.modelContainer.mainContext.insert(newItem)
//    return .result()
//  }

  // That's why I asked for a solution for this on [StackOverflow](https://stackoverflow.com/questions/78895555/non-sendable-type-in-implicitly-asynchronous-access-warning-when-accessing-the)

  // First answer was to annotate the perform func with `@MainActor` and remove the `await`:

//  @MainActor
//  func perform() async throws -> some IntentResult {
//    print("AddNewItemIntent button tapped")
//    let newItem = Item(timestamp: Date())
//    DataModel.shared.modelContainer.mainContext.insert(newItem)
//    return .result()
//  }

  // While above approach does work, the 2nd answer was to also make changes to the `DataModel` (see `DataModel.swift`)
  // and to change perform to this:

  func perform() async throws -> some IntentResult {
    print("AddNewItemIntent button tapped")
    await DataModel.shared.run { model in
        let newItem = Item(timestamp: Date())
        model.modelContext.insert(newItem)
    }
    return .result()
  }
}
