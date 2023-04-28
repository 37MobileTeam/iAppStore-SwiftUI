//
//  SafariView.swift
//  iAppStore
//
//  Created by HTC on 2023/4/28.
//  Copyright © 2023 37 Mobile Games. All rights reserved.
//

import SwiftUI
import SafariServices

// MARK: -  SafariView
struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let sf = SFSafariViewController(url: url)
        sf.dismissButtonStyle = .close
        return sf
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}
