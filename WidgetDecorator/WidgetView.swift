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
    
    var body: some View {
        VStack(alignment: .center){
            VStack(alignment: .center){
                Text("Title").font(.title)
                Text("content").font(.body)
                if(clock){
                    Text(Date(), style: .time)
                }
            }.frame(width: 170, height: 170, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(color))
            Text("widget name")
                .font(.caption)}
    }
    
    //save widget config
    func save(){
        
    }
}
