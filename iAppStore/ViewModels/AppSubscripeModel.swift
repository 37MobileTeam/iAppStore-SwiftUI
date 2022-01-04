//
//  AppSubscripeModel.swift
//  iAppStore
//
//  Created by HTC on 2022/1/1.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import Foundation


class AppSubscripeModel: ObservableObject {
    
    public static let shared = AppSubscripeModel()
    
    @Published var subscripes: [AppSubscripe] = []
    @Published var apps: [String: AppDetail] = [:]
    
    private var timer: Timer?
    private let interval: TimeInterval = 30
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
        // 加载历史记录
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    
    @objc private func handleTimer(_ timer: Timer?) {
        subscripes.enumerated().forEach { (index, app) in
            if !app.isFinished {
                checkStatus(app, index: index)
            }
        }
    }
    
    func checkStatus(_ app: AppSubscripe, index: Int) {
        
        let regionId = TSMGConstants.regionTypeListIds[app.regionName] ?? "cn"
        let endpoint: APIService.Endpoint = APIService.Endpoint.lookupApp(appid: app.appId, country: regionId)
        
        APIService.shared.POST(endpoint: endpoint, params: nil) { (result: Result<AppDetailM, APIService.APIError>) in
            switch result {
            case let .success(response):
                switch app.subscripeType {
                    case 0:
                        // 版本更新
                        if response.resultCount > 0 {
                            let model = response.results.first!
                            if app.currentVersion != model.version {
                                let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: true, model.version)
                                self.subscripes[index] = new
                                self.apps[app.appId] = model
                                return
                            }
                        }
                        
                        let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: false, nil)
                        self.subscripes[index] = new
                        break
                    case 1:
                        // 应用上架
                        if response.resultCount > 0 {
                            let model = response.results.first!
                            let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: true, model.version)
                            self.subscripes[index] = new
                            self.apps[app.appId] = model
                        } else {
                            let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: false, nil)
                            self.subscripes[index] = new
                        }
                        
                        break
                    case 2:
                        //应用下架
                        if response.resultCount == 0 {
                            // 已经下架
                            let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: true, nil)
                            self.subscripes[index] = new
                        } else {
                            let new = AppSubscripe.updateModel(app: app, checkTime: Date().timeIntervalSince1970, isFinished: false, nil)
                            self.subscripes[index] = new
                        }
                        break
                default:break
                }
            case .failure(_):
                break
            }
        }
    }
}
