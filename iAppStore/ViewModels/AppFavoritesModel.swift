//
//  AppFavoritesModel.swift
//  iAppStore
//
//  Created by iHTCboy on 2023/6/24.
//  Copyright © 2023 37 Mobile Games. All rights reserved.
//

import Foundation

class AppFavoritesModel: ObservableObject {
    
    public static let shared = AppFavoritesModel()
    
    func search(_ appId: String) -> AppFavorite? {
        let favorites = appFavorites()
        return favorites.first(where: { $0.appId == appId })
    }

    func add(_ app: AppFavorite) {
        var favorites = appFavorites()
        if let index = favorites.firstIndex(where: { $0.appId == app.appId }) {
            favorites[index] = app
        } else {
            favorites.append(app)
        }
        saveFavorites(favorites)
    }
    
    /// 删除
    /// - Parameter appId: app id
    /// - Returns: 1：删除成功，0：删除失败，-1：未找到删除元素
    @discardableResult
    func remove(appId: String) -> Int {
        var favorites = appFavorites()
        if let index = favorites.firstIndex(where: { $0.appId == appId }) {
            favorites.remove(at: index)
            saveFavorites(favorites)
            return 1
        }
        return -1
    }

    func appFavorites() -> [AppFavorite] {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "AppFavorites") {
            if let decodedData = try? JSONDecoder().decode([AppFavorite].self, from: data) {
                return decodedData
            }
        }
        return []
    }

    func saveFavorites(_ favorites: [AppFavorite]) {
        let userDefaults = UserDefaults.standard
        if let encodedData = try? JSONEncoder().encode(favorites) {
            userDefaults.set(encodedData, forKey: "AppFavorites")
        }
    }
}
