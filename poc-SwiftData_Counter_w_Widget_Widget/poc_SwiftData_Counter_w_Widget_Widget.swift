//
//  poc_SwiftData_Counter_w_Widget_Widget.swift
//  poc-SwiftData_Counter_w_Widget_Widget
//
//  Created by Andreas Seeger on 17.08.2024.
//

import WidgetKit
import SwiftUI

struct LatestItemEntry: TimelineEntry {
    let date: Date
    var item: Item
}

struct LatestItemProvider: TimelineProvider {
  func placeholder(in context: Context) -> LatestItemEntry {
    LatestItemEntry(date: .now, item: Item(timestamp: .now))
  }

  func getSnapshot(in context: Context, completion: @escaping (LatestItemEntry) -> Void) {
    completion(LatestItemEntry(date: .now, item: Item(timestamp: .now)))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<LatestItemEntry>) -> Void) {
    let timeline = Timeline(entries: [LatestItemEntry(date: .now, item: Item(timestamp: .now))], policy: .never)
    completion(timeline)
  }
}

struct WidgetEntryView: View {
  @State var entry: LatestItemProvider.Entry

  var body: some View {
    Text(entry.item.timestamp.formatted())
  }
}

struct poc_SwiftData_Counter_w_Widget_Widget: Widget {
  let kind = "LatestItemExtension"

  var body: some WidgetConfiguration {
    StaticConfiguration(
      kind: kind,
      provider: LatestItemProvider()) { entry in
        WidgetEntryView(entry: entry)
          .containerBackground(.secondary, for: .widget)
      }
      .supportedFamilies([.systemSmall])
      .configurationDisplayName("Latest Item Widget")
      .description("Shows the latest item.")
  }
}

#Preview(as: .systemSmall) {
  poc_SwiftData_Counter_w_Widget_Widget()
} timeline: {
  LatestItemEntry(date: .now, item: Item(timestamp: .now))
}
