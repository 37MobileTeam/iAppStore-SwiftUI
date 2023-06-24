//
//  AppFavoritesView.swift
//  iAppStore
//
//  Created by iHTCboy on 2023/6/24.
//  Copyright © 2023 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct AppFavoritesView: View {
    
    @StateObject private var appModel = AppDetailModel()

    var body: some View {
        VStack {
            if appModel.results.count == 0 {
                EmptyStateView()
            } else {
                List {
                    ForEach(appModel.results, id: \.trackId) { item in
                        let index = appModel.results.firstIndex { $0.trackId == item.trackId }
                        let app = AppFavoritesModel.shared.search("\(item.trackId)")
                        NavigationLink(destination: AppDetailView(appId: String(item.trackId), regionName: (app?.regionName ?? "中国"), item: nil)) {
                            SearchCellView(index: index ?? 0, item: item).frame(height: 110)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("App 收藏夹")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            let favorites = AppFavoritesModel.shared.appFavorites()
            if appModel.results.count == 0, !favorites.isEmpty {
                favorites.forEach { app in
                    appModel.lookupAppId(app.appId, app.regionName)
                }
            }
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        Spacer()
        Image(systemName: "list.star")
            .font(Font.system(size: 60))
            .foregroundColor(Color.tsmg_tertiaryLabel)
        Spacer()
    }
}


struct AppFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AppFavoritesView()
        }
        .onAppear {
            AppFavoritesModel.shared.add(AppFavorite(appId: "1669437212", regionName: "中国"))
            AppFavoritesModel.shared.add(AppFavorite(appId: "989673964", regionName: "中国"))
            AppFavoritesModel.shared.add(AppFavorite(appId: "1142110895", regionName: "中国"))
        }
    }
}
