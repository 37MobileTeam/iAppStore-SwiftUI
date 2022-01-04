//
//  AppRankModel.swift
//  iAppStore
//
//  Created by HTC on 2021/12/18.
//

import Foundation

class AppRankModel: ObservableObject {
    
    @Published var rankTitle: String = "排行榜"
    @Published var rankUpdated: String = ""
    @Published var results: [AppRank] = []
    
    func fetchRankData(_ rankName: String, _ categoryName: String, _ regionName: String) {
        
        let rankId = TSMGConstants.rankingTypeListIds[rankName]!
        let categoryId = TSMGConstants.categoryTypeListIds[categoryName]!
        let regionId = TSMGConstants.regionTypeListIds[regionName] ?? "cn"
        var endpoint: APIService.Endpoint
        
        switch rankId {
        case "topFreeApplications":
            endpoint = APIService.Endpoint.topFreeApplications(cid: categoryId, country: regionId, limit: 200)
        case "topFreeiPadApplications":
            endpoint = APIService.Endpoint.topFreeiPadApplications(cid: categoryId, country: regionId, limit: 200)
        case "topPaidApplications":
            endpoint = APIService.Endpoint.topPaidApplications(cid: categoryId, country: regionId, limit: 200)
        case "topPaidiPadApplications":
            endpoint = APIService.Endpoint.topPaidiPadApplications(cid: categoryId, country: regionId, limit: 200)
        case "topGrossingApplications":
            endpoint = APIService.Endpoint.topGrossingApplications(cid: categoryId, country: regionId, limit: 200)
        case "topGrossingiPadApplications":
            endpoint = APIService.Endpoint.topGrossingiPadApplications(cid: categoryId, country: regionId, limit: 200)
        case "newApplications":
            endpoint = APIService.Endpoint.newApplications(cid: categoryId, country: regionId, limit: 200)
        case "newFreeApplications":
            endpoint = APIService.Endpoint.newFreeApplications(cid: categoryId, country: regionId, limit: 200)
        case "newPaidApplications":
            endpoint = APIService.Endpoint.newPaidApplications(cid: categoryId, country: regionId, limit: 200)
        default:
            endpoint = APIService.Endpoint.topFreeApplications(cid: categoryId, country: regionId, limit: 200)
        }
        
        APIService.shared.POST(endpoint: endpoint, params: nil) { (result: Result<AppRankM, APIService.APIError>) in
            switch result {
            case let .success(response):
                self.results = response.feed.entry
                self.rankTitle = response.feed.title.label.components(separatedBy: ["：", ":"]).last ?? "排行榜"
                self.handleUpdated(response.feed.updated.label)
            case .failure(_):
                break
            }
        }
    }
    
    private func handleUpdated(_ dateString: String) {
        // 2021-12-31T17:47:05-07:00 
        let index = dateString.lastIndex(of: "-")
        let dateStr = String(dateString[..<index!]) + "-0800"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateStr) as Date? {
            let dateformat = DateFormatter()
            dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.rankUpdated = dateformat.string(from: date)
        } else {
            self.rankUpdated = dateString
        }
    }
    
}
