//
//  NetworkMonitor.swift
//  iAppStore
//
//  Created by peak on 2022/1/27.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import Foundation
import Network
import Combine
import SwiftUI

final class NetworkStateChecker: ObservableObject {
    static let shared = NetworkStateChecker()
    private(set) lazy var publisher = makePublisher()
    @Published private(set) var path: NWPath
    
    private let monitor: NWPathMonitor
    private lazy var subject = CurrentValueSubject<NWPath, Never>(monitor.currentPath)
    private var subscriber: AnyCancellable?
    private let queue = DispatchQueue(label: "Monitor")
    
    init() {
        monitor = NWPathMonitor()
        path = monitor.currentPath
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.path = path
                self.subject.send(path)
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
        subject.send(completion: .finished)
    }
    
    private func makePublisher() -> AnyPublisher<NWPath, Never> {
        return subject.eraseToAnyPublisher()
    }
}
