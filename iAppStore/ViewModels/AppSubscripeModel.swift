//
//  AppSubscripeModel.swift
//  iAppStore
//
//  Created by HTC on 2022/1/1.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import Foundation


class AppSubscripeModel: ObservableObject {
        
    @Published private(set) var subscripes: [AppSubscripe] {
        didSet {
            saveSubscripes()
        }
    }
    
    private var timer: Timer?
    private let interval: TimeInterval = 30
    private let modelName = "AppSubscripeModel"
    private let folderName = "AppSubscripe"
    
    init() {
        // 加载历史记录
        subscripes = LocalFileManager.instance.getModel(modelName: modelName, folderName: folderName)
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(handleTimer(_:)), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: Public
    
    func removeAt(indexSet: IndexSet) {
        subscripes.remove(atOffsets: indexSet)
    }
    
    func addSubscripe(appId: String, regionName: String, subscripeType: Int, appDetail: AppDetail?) {
        let subscripe = AppSubscripe(
            appId: appId,
            regionName: regionName,
            subscripeType: subscripeType,
            currentVersion: appDetail?.version ?? "",
            newVersion: nil,
            startTimeStamp: Date().timeIntervalSince1970,
            endCheckTimeStamp: nil,
            isFinished: false,
            iconURL: appDetail?.artworkUrl100,
            trackName: appDetail?.trackName ?? ""
        )
        
        subscripes.append(subscripe)
    }
    
    func subscripeExist(appId: String) -> Bool {
        let subscripe = subscripes.first(where: { $0.appId == appId })
        return subscripe != nil
    }
    
    // MARK: Private
    
    @objc private func handleTimer(_ timer: Timer?) {
        subscripes.enumerated().forEach { (index, app) in
            if !app.isFinished {
                checkStatus(app, index: index)
            }
        }
    }
    
    private func checkStatus(_ app: AppSubscripe, index: Int) {
        
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
    
    private func saveSubscripes() {
        LocalFileManager.instance.saveModel(model: subscripes, modelName: modelName, folderName: folderName)
    }
    
}
