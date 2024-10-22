//
//  ContentView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/1.
//

import SwiftUI
import Photos
import WidgetKit

struct ContentView: View {
    @State var showImagePicker: Bool = false
    @State var pressed = false
    @State var refresh = true
    @ObservedObject var data = SharedData()
    
    var body: some View {
        NavigationView{
//            List{
//                CategoryRow(categoryName: "类型1", items: [WidgetPreviewItem(data: data),WidgetPreviewItem(data: data),WidgetPreviewItem(data: data)])
//                    .listRowInsets(EdgeInsets()).onTapGesture {
//                        UserDefaults(suiteName: "group.widgetdecorator")!.set(1,forKey: "color")
//                        WidgetCenter.shared.reloadAllTimelines()
//                        pressed = true;
//                    }
//                CategoryRow(categoryName: "类型2", items: [WidgetPreviewItem(data: data),WidgetPreviewItem(data: data),WidgetPreviewItem(data: data)])
//                    .listRowInsets(EdgeInsets()).onTapGesture {
//                        UserDefaults(suiteName: "group.widgetdecorator")!.set(2,forKey: "color")
//                        WidgetCenter.shared.reloadAllTimelines()
//                    }
//                CategoryRow(categoryName: "类型3", items: [WidgetPreviewItem(data: data),WidgetPreviewItem(data: data),WidgetPreviewItem(data: data)])
//                    .listRowInsets(EdgeInsets()).onTapGesture {
//                        UserDefaults(suiteName: "group.widgetdecorator")!.set(3,forKey: "color")
//                        WidgetCenter.shared.reloadAllTimelines()
//                    }
//                CategoryRow(categoryName: "类型4", items: [WidgetPreviewItem(data: data),WidgetPreviewItem(data: data),WidgetPreviewItem(data: data)])
//                    .listRowInsets(EdgeInsets()).onTapGesture {
//                        UserDefaults(suiteName: "group.widgetdecorator")!.set(4,forKey: "color")
//                        WidgetCenter.shared.reloadAllTimelines()
//                    }
//            }
            WidgetPagerView()
            .sheet(isPresented: $showImagePicker) {
                PHPickerView() {assetId in
                    var aid : [String] = [String]()
                    aid.append(assetId)
                    let asset = PHAsset.fetchAssets(withLocalIdentifiers: aid, options: nil)
                    PHImageManager.default().requestImageDataAndOrientation(for: asset.firstObject ?? PHAsset(), options: nil, resultHandler: {(data, b, c, d) in
                        self.data.backimgdata = data ?? Data()
                        UserDefaults(suiteName: "group.widgetdecorator")!.set(data, forKey: "selectedImgData")
                    })
                    WidgetCenter.shared.reloadAllTimelines()}
            }
            .navigationBarTitle("Widget库")
            .navigationBarItems(trailing: Button(action: {}, label: { Text("添加").onTapGesture(perform: {
                self.showImagePicker.toggle()
            }) }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//用于app内widget展示，具有触摸交互功能
struct WidgetPreviewItem: View, Identifiable {
    let id = UUID()

    @ObservedObject var data : SharedData

    var body: some View {
        VStack{
            Button(action: {}){
                WidgetItemView(background: UIImage(data: data.backimgdata) ?? UIImage())
            }
            .buttonStyle(ScaleButtonStyle())
            Text("widget name")
                .font(.caption)
        }
    }
}

class SharedData : ObservableObject{
    @Published var backimgdata : Data = Data()
}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1).animation(.easeInOut)
    }
}

//横向滑动
struct CategoryRow: View {
    var categoryName: String
    var items: [WidgetPreviewItem]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(self.categoryName)
                .font(.headline).padding(.leading, 15).padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(items){widget in
                        widget
                    }
                }.frame(height: 200).padding(.leading, 10)
            }
        }
    }
}
