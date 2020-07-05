//
//  WidgetView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/2.
//

import SwiftUI
import Photos

//实际widget view
struct WidgetItem: View{
    var clock = false
    @State var now = Date()
    //@State var uiImgData = UserDefaults(suiteName: "group.widgetdecorator")!.data(forKey: "background")
    var background : UIImage
    var isBig = false
    @State var imgno = 0
    @State var count = 0
    var color: Color = Color.blue
    
    var body: some View {
        ZStack{
            //Image(uiImage: UIImage(data: uiImgData ?? Data()) ?? UIImage()).resizable()
            Image(uiImage: background).resizable()
            if(clock){
                Text(now, style: .date)
            }
            Text(now.description)
//            if(getimg(no: now)){
//            }
        }.frame(width: isBig ? 330 : 160, height: isBig ? 330 : 160, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
