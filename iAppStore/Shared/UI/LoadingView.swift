//
//  LoadingView.swift
//  iAppStore
//
//  Created by peak on 2022/1/30.
//  Copyright © 2022 37 Mobile Games. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    private let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    
    @State private var loadingText: [String] = "Loading...".map { String($0) }
    @State private var counter: Int = 1
    @State private var showLoadingText = false
    
    var body: some View {
        VStack {
            if showLoadingText {
                ProgressView()
                animateText
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            showLoadingText.toggle()
        })
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                } else {
                    counter += 1
                }
            }
        }
    }
    
    
    var animateText: some View {
        HStack(spacing: 1) {
            ForEach(loadingText.indices) { index in
                Text(loadingText[index])
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.secondary)
                    .offset(y: counter == index ? -5 : 0)
            }
        }
        .offset(y: 12)
    }
    
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
