//
//  WidgetView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/2.
//

import SwiftUI
import Photos

//实际widget view
struct WidgetItemView: View{
    @State var now = Date()
    var background : UIImage
    var isLargeMode = false
    var showClock:Bool = false
    
    var body: some View {
        ZStack{
            Color.yellow
            Image(uiImage: background).resizable()
            if(showClock){
                VStack{
                    Text(now, style: .time)
                    Text(now, style: .date)
                }
            }
            
        }.frame(width: isLargeMode ? 330 : 160, height: isLargeMode ? 330 : 160, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct WidgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetItemView(background: UIImage(), showClock: true)
            .previewLayout(.fixed(width: 160, height: 160))
    }
}
