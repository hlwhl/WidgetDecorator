//
//  WidgetDecorator_Widgets.swift
//  WidgetDecorator_Widgets
//
//  Created by Linwei Hao on 2020/7/1.
//

import WidgetKit
import SwiftUI
import Intents
import Photos
import UIKit
import URLImage

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        
        let data = UserDefaults(suiteName: "group.widgetdecorator")!.data(forKey: "selectedImgData")
        guard let source = CGImageSourceCreateWithData((data ?? Data()) as CFData, nil) else {
            return;
        }
        let count = CGImageSourceGetCount(source)
        for index in 0 ..< count {
            
            //let entryDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
            let entryDate = currentDate.addingTimeInterval(0.5*Double(index))
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                let entry = SimpleEntry(date: entryDate, configuration: configuration, background:  UIImage(cgImage: image))
                entries.append(entry)
            }
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
    public var background : UIImage = UIImage()
}

struct PlaceholderView : View {
    var body: some View {
        VStack{
            Text("Loading...")
        }
    }
}

struct WidgetDecorator_WidgetsEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            WidgetItemView(widgetFamily: family, background: entry.background, showClock: entry.configuration.showTime?.boolValue ?? false)

        case .systemMedium:
            WidgetItemView(widgetFamily: family, background: entry.background, showClock: entry.configuration.showTime?.boolValue ?? false)

        case .systemLarge:
            WidgetItemView(widgetFamily: family, background: entry.background, showClock: entry.configuration.showTime?.boolValue ?? false)

        default:
            WidgetItemView(background: entry.background, showClock: entry.configuration.showTime?.boolValue ?? false)
        }
    }
}

@main
struct WidgetDecorator_Widgets: Widget {
    private let kind: String = "WidgetDecorator_Widgets"
    
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(), placeholder: PlaceholderView()) { entry in
            WidgetDecorator_WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("装饰你的桌面")
    }
}

struct WidgetDecorator_Widgets_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
