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
    var testdata:[WidgetPreviewItem] = [WidgetPreviewItem(),WidgetPreviewItem(),WidgetPreviewItem()]
    @State var pressed = false
    var body: some View {
        NavigationView{
            List{
                CategoryRow(categoryName: "类型1", items: testdata)
                    .listRowInsets(EdgeInsets()).onTapGesture {
                        UserDefaults(suiteName: "group.widgetdecorator")!.set(1,forKey: "color")
                        WidgetCenter.shared.reloadAllTimelines()
                        pressed = true;
                    }
                CategoryRow(categoryName: "类型2", items: testdata)
                    .listRowInsets(EdgeInsets()).onTapGesture {
                        UserDefaults(suiteName: "group.widgetdecorator")!.set(2,forKey: "color")
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                CategoryRow(categoryName: "类型3", items: testdata)
                    .listRowInsets(EdgeInsets()).onTapGesture {
                        UserDefaults(suiteName: "group.widgetdecorator")!.set(3,forKey: "color")
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                CategoryRow(categoryName: "类型4", items: testdata)
                    .listRowInsets(EdgeInsets()).onTapGesture {
                        UserDefaults(suiteName: "group.widgetdecorator")!.set(4,forKey: "color")
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
            .navigationBarTitle("Widget库")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//实际widget view
struct WidgetItem: View {
    var body: some View {
        VStack(alignment: .center){
            VStack(alignment: .center){
                Text("Title").font(.title)
                Text("content").font(.body)
            }.frame(width: 170, height: 170, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.blue))
            Text("widget name")
                .font(.caption)}
    }
}

//用于app内widget展示，具有触摸交互功能
struct WidgetPreviewItem: View {
    @State var pressed = false
    var body: some View {
        VStack{
            Button(action: {}){
                WidgetItem()
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1).animation(.easeInOut)
    }
}

struct CategoryRow: View {
    var categoryName: String
    var items: [WidgetPreviewItem]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(self.categoryName)
                .font(.headline).padding(.leading, 15).padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    WidgetPreviewItem()
                    WidgetPreviewItem()
                    WidgetPreviewItem()}
            }.frame(height: 200).padding(.leading, 10)
        }
    }
}
