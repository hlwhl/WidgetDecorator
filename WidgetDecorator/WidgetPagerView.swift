//
//  WidgetPagerView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/8.
//

import SwiftUI
import SwiftUIPager

struct WidgetPagerView: View {
    @State var page: Int = 0
    var items = Array(0..<10)
    var body: some View {
        Pager(page: $page,
              data: items,
              id: \.self,
              content: { index in
                // create a page based on the data passed
                ZStack{
                    Rectangle()
                        .fill(Color.yellow)
                    Text("Page: \(index)")
                }.cornerRadius(20).shadow(radius: 5)
                
              }).rotation3D().itemAspectRatio(0.8)
    }
}

struct WidgetPagerView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPagerView()
    }
}
