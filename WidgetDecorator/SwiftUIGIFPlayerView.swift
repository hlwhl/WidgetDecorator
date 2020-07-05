//
//  SwiftUIGIFPlayerView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/3.
//

import SwiftUI

public struct SwiftUIGIFPlayerView: UIViewRepresentable {
    
    private var gifName: Data
    
    public init(gifName: Data) {
        self.gifName = gifName
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SwiftUIGIFPlayerView>) {
        
    }
    
    public func makeUIView(context: Context) -> UIView {
        return GIFPlayerView(data: gifName)
    }
    
}
