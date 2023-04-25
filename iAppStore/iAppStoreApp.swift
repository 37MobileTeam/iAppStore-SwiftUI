//
//  iAppStoreApp.swift
//  iAppStore
//
//  Created by HTC on 2021/12/15.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI

@main
struct iAppStoreApp: App {
    
    init() {
        setupApperance()
    }
    
    var body: some Scene {
        WindowGroup {
            TabbarView().accentColor(.tsmg_blue)
        }
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "tsmg_blue")!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "tsmg_blue")!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(named: "tsmg_blue")!,
        ], for: .normal)
        
        UIWindow.appearance().tintColor = UIColor(named: "tsmg_blue")
    }
}



// MARK: - iOS implementation
struct TabbarView: View {
    @State var selectedTab = Tab.rankLists
    
    enum Tab: Int {
        case rankLists, search, subscription, setting
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RankHome().tabItem{
                self.tabbarItem(text: "榜单", image: "arrow.up.arrow.down.square")
            }.tag(Tab.rankLists)
            SearchHome().tabItem{
                self.tabbarItem(text: "搜索", image: "magnifyingglass.circle.fill")
            }.tag(Tab.search)
            SubscriptionHome().tabItem{
                self.tabbarItem(text: "订阅", image: "checkmark.seal.fill")
            }.tag(Tab.subscription)
            SettingHome().tabItem{
                self.tabbarItem(text: "设置", image: "gearshape")
            }.tag(Tab.setting)
        }
    }
}
