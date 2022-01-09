//
//  ShareSheet.swift
//  iAppStore
//
//  Created by iHTCboy on 2022/1/9.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import UIKit
import SwiftUI


struct ShareSheet: UIViewControllerRepresentable {
    var items : [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}
