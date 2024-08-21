//
//  Item.swift
//  poc-SwiftData_Counter_w_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
  private(set) var _timestamp: Date?

  init(
    timestamp: Date
  ) {
    self._timestamp = timestamp
  }

  var timestamp: Date {
    get {
      if let _timestamp {
        return _timestamp
      } else {
        return .now
      }
    }
    set {
      _timestamp = newValue
    }
  }
}
