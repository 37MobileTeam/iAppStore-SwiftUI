//
//  APIService.swift
//  iAppStore
//
//  Created by HTC on 2021/12/20.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import Foundation

public struct APIService {
    let baseURL = "https://itunes.apple.com/"
    
    public static let shared = APIService()
    let decoder = JSONDecoder()
    
    
    public enum APIError: Error {
        case noResponse
        case jsonDecodingError(error: Error)
        case networkError(error: Error)
    }
    
    
    public enum Endpoint {
        case topFreeApplications(cid: String, country: String, limit: Int),
             topFreeiPadApplications(cid: String, country: String, limit: Int),
             topPaidApplications(cid: String, country: String, limit: Int),
             topPaidiPadApplications(cid: String, country: String, limit: Int),
             topGrossingApplications(cid: String, country: String, limit: Int),
             topGrossingiPadApplications(cid: String, country: String, limit: Int),
             newApplications(cid: String, country: String, limit: Int),
             newFreeApplications(cid: String, country: String, limit: Int),
             newPaidApplications(cid: String, country: String, limit: Int),
             searchApp(word: String, country: String, limit: Int),
             lookupApp(appid: String, country: String)

        func url() -> String {
            let url = APIService.shared.baseURL
            switch self {
                //https://itunes.apple.com/rss/topfreeapplications/limit=20/genre=6014/json?cc=cn
            case .topFreeApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topfreeapplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .topFreeiPadApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topFreeiPadApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .topPaidApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topPaidApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .topPaidiPadApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topPaidiPadApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .topGrossingApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topGrossingApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .topGrossingiPadApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/topGrossingiPadApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .newApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/newApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .newFreeApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/newFreeApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .newPaidApplications(cid: let cid, country: let country, limit: let limit):
                return url + "rss/newPaidApplications/limit=\(limit)/genre=\(cid)/json?cc=\(country)"
            case .searchApp(word: let word, country: let country, limit: let limit):
                return url + "search?term=\(word)&country=\(country)&limit=\(limit)&entity=software"
            case .lookupApp(appid: let appid, country: let country):
                return url + "\(country)/lookup?id=\(appid)"
            }
        }
    }
    
    
    public func POST<T: Codable>(endpoint: Endpoint,
                         params: [String: String]?,
                         completionHandler: @escaping (Result<T, APIError>) -> Void) {
        let queryURL = endpoint.url()
        guard let url = URL(string: queryURL) else {
            debugPrint("error url: \(queryURL)")
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        debugPrint(components.url!)
        var request = URLRequest(url: components.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = "POST"
        request.setValue("iAppStore/1.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    #if DEBUG
                    print("JSON Decoding Error: \(error)")
                    #endif
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }
        }
        task.resume()
    }
    
    
    public func GET_JSON(endpoint: Endpoint,
                         params: [String: String]?,
                    completionHandler: @escaping (Result<Dictionary<String, Any>, APIError>) -> Void) {
        let queryURL = endpoint.url()
        var components = URLComponents(url: URL(string: queryURL)!, resolvingAgainstBaseURL: true)!
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error: error!)))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let object = json as! Dictionary<String, Any>
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    #if DEBUG
                    print("JSON Decoding Error: \(error)")
                    #endif
                    completionHandler(.failure(.jsonDecodingError(error: error)))
                }
            }

            
        }
        task.resume()
    }
    
}
