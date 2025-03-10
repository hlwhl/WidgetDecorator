//
//  PHPickerView.swift
//  WidgetDecorator
//
//  Created by Linwei Hao on 2020/7/3.
//

import UIKit
import SwiftUI
import PhotosUI


struct PHPickerView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    
    let onImagePicked: (String) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
     
        // Create and configure the PHPicker
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        
        // Set the Coordinator as the PHPickerDelegate
        let controller = PHPickerViewController( configuration: configuration )
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController( _ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        @Environment(\.presentationMode)  private var presentationMode
        
        var parent: PHPickerView
        
        init( _ parent: PHPickerView ) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            picker.dismiss( animated: true )
            self.parent.onImagePicked(results.first?.assetIdentifier ?? "")
        }
    }
    
}
