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
    var testdata:[WidgetPreviewItem] = [WidgetPreviewItem(color: Color.red),WidgetPreviewItem(color: Color.green),WidgetPreviewItem(color: Color.blue)]
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
//            .navigationBarItems(trailing: Button(action: {}, label: { Text("添加") }))
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
    
    @State var pressed = false
    var color : Color
    var body: some View {
        VStack{
            Button(action: {}){
                WidgetItem(color: color)
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
