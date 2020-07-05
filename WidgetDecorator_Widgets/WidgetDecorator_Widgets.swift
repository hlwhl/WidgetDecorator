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

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        //let data = UserDefaults(suiteName: "group.widgetdecorator")?.data(forKey: "background")
        
        let data = UserDefaults(suiteName: "group.widgetdecorator")!.data(forKey: "selectedImgData")
        guard let source = CGImageSourceCreateWithData((data ?? Data()) as CFData, nil) else {
            return;
        }
        let count = CGImageSourceGetCount(source)
        for index in 0 ..< count {
            let entryDate = Calendar.current.date(byAdding: .second, value: index, to: currentDate)!
            if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
                let entry = SimpleEntry(date: entryDate, configuration: configuration, background:  UIImage(cgImage: image))
                entries.append(entry)
            }
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
        //        let id = UserDefaults(suiteName: "group.widgetdecorator")!.string(forKey: "selectedImgId") ?? ""
        //        var aid : [String] = [String]()
        //        aid.append(id)
        //        let asset = PHAsset.fetchAssets(withLocalIdentifiers: aid, options: nil).firstObject
        //        PHImageManager.default().requestImageDataAndOrientation(for: asset ?? PHAsset(), options: nil, resultHandler: {(data, b, c, d) in
        //
        //            let entry = SimpleEntry(date: entryDate, configuration: configuration, color: UserDefaults.standard.integer(forKey: "color"), background: Image(uiImage: UIImage(data: data ?? Data()) ?? UIImage()))
        //
        //            entries.append(entry)
        //            let timeline = Timeline(entries: entries, policy: .atEnd)
        //            completion(timeline)
        //        })
    }
    
    func getTheLatestPhotos(amount:Int) -> PHFetchResult<PHAsset>{
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.fetchLimit = amount
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return PHAsset.fetchAssets(with: allPhotosOptions)
    }
    
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
    public var background : UIImage = UIImage()
}

struct PlaceholderView : View {
    var body: some View {
        Text("Loading...")
    }
}

struct WidgetDecorator_WidgetsEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack{
                WidgetItem(now: entry.date, background: entry.background)
            }
        case .systemMedium:
            HStack(){
                WidgetItem(clock: false, background: entry.background, color: Color.blue)
                Text(Date(), style: .date)
            }
        case .systemLarge:
            VStack{
                WidgetItem(background: entry.background, isBig: true)
            }
        default:
            WidgetItem(clock: entry.configuration.showTime?.boolValue ?? false, background: entry.background)
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
