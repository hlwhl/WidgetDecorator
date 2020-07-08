//
//  WidgetView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/2.
//

import SwiftUI
import Photos
import WidgetKit

//实际widget view
struct WidgetItemView: View{
    @State var now = Date()
    var widgetFamily = WidgetFamily.systemSmall
    var background : UIImage
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
            
        }.frame(width: getWidgetWidth(), height: getWidgetHeight(), alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    func getWidgetWidth() -> CGFloat{
        switch widgetFamily {
        case .systemSmall:
            return 160
        case .systemMedium:
            return 330
        case .systemLarge:
            return 330
        default:
            return 160
        }
    }
    
    func getWidgetHeight() -> CGFloat{
        switch widgetFamily {
        case .systemSmall:
            return 160
        case .systemMedium:
            return 160
        case .systemLarge:
            return 330
        default:
            return 160
        }
    }
}

struct WidgetItemView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetItemView(background: UIImage(), showClock: true)
            .previewLayout(.fixed(width: 160, height: 160))
    }
}
