//
//  Strings.swift
//  iAppStore
//
//  Created by HTC on 2022/1/3.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import Foundation
import SwiftUI
import CryptoKit

extension String {
    
    /// 获取苹果缩略图尺寸
    /// 类似： https://is1-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/16/0a/18/160a1889-5d30-9ef1-09fd-cacd97f5f0bd/96e99d1b-6a47-4c78-a570-4b7682c5c9df_img5_5_0_zh-Hans.png/392x696bb.png
    /// - Returns: 缩略图 Size
    public func imageAppleSize() -> CGSize {
  
        if let url = URL(string: self) {
            let component = url.lastPathComponent
            let splits = component.components(separatedBy: CharacterSet.decimalDigits.inverted)
            if splits.count > 1, let fSize = splits.first, let lSize = splits.dropFirst().first {
                if let fdSize = Double(fSize),  let ldSize = Double(lSize) {
                    let size = CGSize(width: fdSize, height: ldSize)
                    return size
                }
            }
        }
        
        return CGSize.zero
    }
    
    /// 处理苹果图片尺寸
    /// 类似： https://is1-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/16/0a/18/160a1889-5d30-9ef1-09fd-cacd97f5f0bd/96e99d1b-6a47-4c78-a570-4b7682c5c9df_img5_5_0_zh-Hans.png/392x696bb.png
    /// - Parameter scale: 缩放比例
    /// - Returns: 缩放后的 url
    public func imageAppleScale(_ scale: Double = UIScreen.main.scale) -> String {
        if let url = URL(string: self) {
            let component = url.lastPathComponent
            let size = imageAppleSize()
            let newfSize = String(Int(size.width * scale))
            let newlSize = String(Int(size.height * scale))
            let newComponent = component
                .replacingOccurrences(of: String(Int(size.width)), with: newfSize)
                .replacingOccurrences(of: String(Int(size.height)), with: newlSize)
            let newUrl = url.deletingLastPathComponent().appendingPathComponent(newComponent).relativeString
            return newUrl
        }
        
        return self
    }
    
    
    /// 复制文本到剪贴板
    public func copyToClipboard() {
        guard self.count > 0 else {
            return
        }

        UIPasteboard.general.string = self
    }
    
}

extension String {
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }
            .joined()
    }
}
