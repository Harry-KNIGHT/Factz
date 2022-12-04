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
		Task {
			do {
				let fact = try await FactApi.fetchFact()

				let entry = SimpleEntry(date: .now, fact: fact)
				let timeline = Timeline(entries: [entry], policy: .after(.now.advanced(by: 15 * 60)))
				completion(timeline)

			} catch {
				print(error.localizedDescription)
			}
		}
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
				.multilineTextAlignment(.center)
				.padding(.horizontal)
				.accessibilityLabel(fact)
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
		.description("Daily historical fact about date on your widget.")
		.supportedFamilies([.systemMedium])
	}
}

struct Fact_Previews: PreviewProvider {
	static var previews: some View {
		FactEntryView(entry: SimpleEntry(date: Date()))
			.previewContext(WidgetPreviewContext(family: .systemSmall))
	}
}
