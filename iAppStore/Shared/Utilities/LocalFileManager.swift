//
//  LocalFileManager.swift
//  iAppStore
//
//  Created by peak on 2022/1/25.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    private init() {}
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName) \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
                  return nil
              }
        return UIImage(contentsOfFile: url.path)
    }
    
    // MARK: Private
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first, !folderName.isEmpty else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName), !imageName.isEmpty else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}

extension LocalFileManager {
    func saveModel<T: Encodable>(model: [T], modelName: String, folderName: String ) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let url = getURLForModel(modelName: modelName, folderName: folderName) else {
            return
        }
        
        do {
            let data = try JSONEncoder().encode(model)
            try data.write(to: url)
        } catch let error {
            print("Error save model. ModelName: \(modelName) \(error)")
        }
    }
    
    func getModel<T: Decodable>(modelName: String, folderName: String) -> [T] {
        guard let url = getURLForModel(modelName: modelName, folderName: folderName),
                FileManager.default.fileExists(atPath: url.path)
                else {
            return []
        }
       
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("Error get model, error: \(error)")
            return []
        }
    }
    
    private func getURLForModel(modelName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName), !modelName.isEmpty else {
            return nil
        }
        return folderURL.appendingPathComponent(modelName + ".model")
    }
}
