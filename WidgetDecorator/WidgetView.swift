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
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center){
            VStack(alignment: .center){
                Text("Title").font(.title)
                Text("content").font(.body)
                if(clock){
                    Text("\(now)").onReceive(timer, perform: {input in self.now = input})
                }
            }
        }.frame(width: 170, height: 170, alignment: .center)
        .background(Image(uiImage: UIImage(data: uiImgData ?? Data()) ?? UIImage()).resizable().clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous)))
    }
    
    //save widget config
    func save(){
        
    }
}
