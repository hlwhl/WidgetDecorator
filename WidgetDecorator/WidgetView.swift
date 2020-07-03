//
//  WidgetView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/2.
//

import SwiftUI

//实际widget view
struct WidgetItem: View{
    var color : Color
    var clock = false
    @State var now = Date()
    @State var uiImgData = UserDefaults(suiteName: "group.widgetdecorator")!.data(forKey: "background")
    var isBig = false
    
    var body: some View {
        ZStack{
            Image(uiImage: UIImage(data: uiImgData ?? Data()) ?? UIImage()).resizable()
            if(clock){
                Text(now, style: .date)
            }
        }.frame(width: isBig ? 330 : 160, height: isBig ? 330 : 160, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
