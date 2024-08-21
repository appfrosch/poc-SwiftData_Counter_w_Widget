//
//  poc_SwiftData_Counter_w_Widget_Widget.swift
//  poc-SwiftData_Counter_w_Widget_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import WidgetKit
import SwiftUI
import SwiftData

struct LatestItemEntry: TimelineEntry {
    let date: Date
    var item: Item?
}

struct LatestItemProvider: TimelineProvider {
  func placeholder(in context: Context) -> LatestItemEntry {
    LatestItemEntry(date: .now, item: Item(timestamp: .now))
  }

  func getSnapshot(in context: Context, completion: @escaping (LatestItemEntry) -> Void) {
    completion(LatestItemEntry(date: .now, item: Item(timestamp: .now)))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<LatestItemEntry>) -> Void) {
    let fetchDescriptor = FetchDescriptor(sortBy: [SortDescriptor(\Item._timestamp, order: .reverse)])
    let modelContext = ModelContext(DataModel.shared.modelContainer)
    var latestItem: Item? = nil
    if let items = try? modelContext.fetch(fetchDescriptor) {
      if let item = items.first {
        latestItem = item
      }
    }
    let itemEntry = LatestItemEntry(date: .now, item: latestItem)
    let timeline = Timeline(entries: [itemEntry], policy: .never)
    completion(timeline)
  }
}

struct WidgetEntryView: View {
  @State var entry: LatestItemProvider.Entry

  var body: some View {
    HStack {
      if let item = entry.item {
        Text(item.timestamp.formatted())
      } else {
        Text("No items yet")
      }

      Button("Add item", systemImage: "plus", intent: AddNewItemIntent())
    }
  }
}

struct poc_SwiftData_Counter_w_Widget_Widget: Widget {
  let kind = "LatestItemExtension"

  var body: some WidgetConfiguration {
    StaticConfiguration(
      kind: kind,
      provider: LatestItemProvider()) { entry in
        WidgetEntryView(entry: entry)
          .containerBackground(.tertiary, for: .widget)
      }
      .supportedFamilies([.systemMedium])
      .configurationDisplayName("Latest Item Widget")
      .description("Shows the latest item.")
  }
}

#Preview(as: .systemSmall) {
  poc_SwiftData_Counter_w_Widget_Widget()
} timeline: {
  LatestItemEntry(date: .now, item: Item(timestamp: .now))
}
