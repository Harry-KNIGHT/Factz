//
//  Fact.swift
//  Fact
//
//  Created by Elliot Knight on 04/12/2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
	var fact: String?
}

struct FactEntryView : View {
    var entry: Provider.Entry

    var body: some View {
		if let fact = entry.fact  {
			Text(fact)
		}
    }
}

struct Fact: Widget {
    let kind: String = "Fact"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FactEntryView(entry: entry)
        }
        .configurationDisplayName("Factz widget")
        .description("Daily fact about date on your widget.")
    }
}

struct Fact_Previews: PreviewProvider {
    static var previews: some View {
        FactEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
