//
//  ImageLoader.swift
//  iAppStore
//
//  Created by HTC on 2021/12/21.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import Foundation
import SwiftUI

// refer: https://stackoverflow.com/questions/60677622/how-to-display-image-from-a-url-in-swiftui

struct ImageLoaderView<Placeholder: View, ConfiguredImage: View>: View {
    var url: String?
    private let placeholder: () -> Placeholder
    private let image: (Image) -> ConfiguredImage

    @ObservedObject var imageLoader: ImageLoaderService
    @State var imageData: UIImage?

    init(
        url: String?,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder image: @escaping (Image) -> ConfiguredImage
    ) {
        
        self.url = url
        self.placeholder = placeholder
        self.image = image
        self.imageLoader = ImageLoaderService(url: URL(string: url ?? "http://apple.com")!)
    }

    @ViewBuilder private var imageContent: some View {
        if let data = imageData {
            image(Image(uiImage: data))
        } else {
            placeholder()
        }
    }

    var body: some View {
        imageContent
            .onReceive(imageLoader.$image) { imageData in
                self.imageData = imageData
            }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()

    convenience init(url: URL) {
        self.init()
        loadImage(for: url)
    }

    func loadImage(for url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
