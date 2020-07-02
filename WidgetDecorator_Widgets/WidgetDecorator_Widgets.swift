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

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, color: 1)
        completion(entry)
    }
    
    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        let entryDate = currentDate
        let entry = SimpleEntry(date: entryDate, configuration: configuration, color: UserDefaults.standard.integer(forKey: "color"))
        print(UserDefaults.standard.integer(forKey: "color"))
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        //        getTheLatestPhotos(amount: 1).enumerateObjects({ (a,b,c) in
        //            PHImageManager.default().requestImage(for: a, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, info) in
        //                entry.img = Image(uiImage: image ?? UIImage())
        //                entries.append(entry)
        //                let timeline = Timeline(entries: entries, policy: .never)
        //                completion(timeline)
        //            })
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
    public var color: Int
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct WidgetDecorator_WidgetsEntryView : View {
    var entry: Provider.Entry
    @State var color = UserDefaults(suiteName: "group.widgetdecorator")!.integer(forKey: "color")
    
    var body: some View {
        VStack{
            if(self.color == 1){
                Text("777")
            } else if(self.color == 2){
                Text("666")
            } else if(self.color == 3){
                Text("888")
            } else if(self.color == 4){
                Text("999")
            }
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
        .description("This is an example widget.")
    }
}

struct WidgetDecorator_Widgets_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
