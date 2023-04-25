//
//  RankSortView.swift
//  iAppStore
//
//  Created by HTC on 2021/12/21.
//  Copyright © 2021 37 Mobile Games. All rights reserved.
//

import SwiftUI


struct RankSortView: View {
    
    public enum RankSortType: Int {
        case noneType
        case rankType
        case categoryType
        case regionType
    }
    
    @Binding var rankName: String
    @Binding var categoryName: String
    @Binding var regionName: String
    
    @State private var sortViewIsExpanded: Bool = false
    @State private var currentSortType: RankSortType = .noneType
    
    var action: ((_ rankName: String, _ categoryName: String, _ regionName: String) -> Void)?

    var body: some View {
        HStack{
            DisclosureGroup(
                isExpanded: $sortViewIsExpanded,
                content: {
                    sortContents
                },
                label: {
                    sortLabels
                }
            )
            .buttonStyle(PlainButtonStyle())
            .accentColor(.clear)
        }
        .onDisappear() {
            sortViewIsExpanded = false
            currentSortType = .noneType
        }
    }
}

// MARK: Sort Content

extension RankSortView {
    
    var sortContents: some View {
        VStack{
            Divider()
            
            if currentSortType == .rankType {
                rankContent
            } else if currentSortType == .categoryType {
                categoryContent
            } else if currentSortType == .regionType {
                regionContent
            }
        }
        .background(Color.tsmg_systemBackground)
        .frame(maxHeight: 210)
    }
    
    var rankContent: some View {
        ScrollView {
            ForEach(0..<TSMGConstants.rankingTypeLists.count, id: \.self) { index in
                buildSortListRow(index: index)
            }
        }
    }
    
    var categoryContent: some View {
        ScrollView {
            ForEach(0..<TSMGConstants.categoryTypeLists.count, id: \.self) {index in
                buildSortListRow(index: index)
            }
        }
    }
    
    var regionContent: some View {
        ScrollView {
            ForEach(0..<TSMGConstants.regionTypeLists.count, id: \.self) {index in
                buildSortListRow(index: index)
            }
        }
    }
       
    func buildSortListRow(index: Int) -> some View {
        HStack {
            let (item, isSelected) = selectedItem(index: index)
            if isSelected {
                selectedItem(item: item)
            } else {
                unselectedItem(item: item)
            }
            Spacer()
            if isSelected {
                checkmarkImage
            }
        }
        .background(Color.tsmg_systemBackground)
        .onTapGesture {
            onTapSortItem(index: index)
        }
    }
    
    func selectedItem(index: Int) -> (String, Bool) {
        var itemArray: [String] = []
        if currentSortType == .rankType {
            itemArray = TSMGConstants.rankingTypeLists
        } else if currentSortType == .categoryType {
            itemArray = TSMGConstants.categoryTypeLists
        } else if currentSortType == .regionType {
            itemArray = TSMGConstants.regionTypeLists
        }
        if index >= itemArray.count {
            return ("", false)
        }
        
        if currentSortType == .rankType {
            return (itemArray[index], itemArray[index] == rankName)
        } else if currentSortType == .categoryType {
            return (itemArray[index], itemArray[index] == categoryName)
        } else if currentSortType == .regionType {
            return (itemArray[index], itemArray[index] == regionName)
        }
        return ("", false)
    }
    
    func onTapSortItem(index: Int) {
        withAnimation {
            if currentSortType == .rankType {
                rankName = TSMGConstants.rankingTypeLists[index]
            } else if currentSortType == .categoryType {
                categoryName = TSMGConstants.categoryTypeLists[index]
            } else if currentSortType == .regionType {
                regionName = TSMGConstants.regionTypeLists[index]
            }
            
            sortViewIsExpanded = false
            currentSortType = .noneType
            
            if nil != action {
                action!(rankName, categoryName, regionName)
            }
        }
    }
    
    func selectedItem(item: String) -> some View {
        Text(item)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .foregroundColor(.blue)
    }
    
    func unselectedItem(item: String) -> some View {
        Text(item)
            .padding(.horizontal)
            .padding(.vertical, 5)
    }
    
    var checkmarkImage: some View {
        Image(systemName: "checkmark")
            .padding(.horizontal)
            .padding(.vertical, 5)
            .foregroundColor(.blue)
    }
}

// MARK: Sort Label
extension RankSortView {
    
    var sortLabels: some View {
        HStack {
            Spacer()
            rankLabel
            Spacer()
            categoryLabel
            Spacer()
            regionLabel
            Spacer()
        }
    }
    
    var rankLabel: some View {
        createSortLabel(type: .rankType)
    }
    
    var categoryLabel: some View {
        createSortLabel(type: .categoryType)
    }
    
    var regionLabel: some View {
        createSortLabel(type: .regionType)
    }
    
    func createSortLabel(type: RankSortType) -> some View {
        HStack {
            switch type {
            case .noneType:
                Text("")
            case .rankType:
                Text(rankName)
            case .categoryType:
                Text(categoryName)
            case .regionType:
                Text(regionName)
            }
            
            if currentSortType == type {
                Image(systemName: "chevron.up")
            } else {
                Image(systemName: "chevron.down")
            }
        }
        .onTapGesture {
            if currentSortType == type {
                sortViewIsExpanded = false
                currentSortType = .noneType
            } else {
                sortViewIsExpanded = true
                currentSortType = type
            }
        }
    }
}

struct RankSortView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            RankSortView(
                rankName: .constant("热门免费榜"),
                categoryName: .constant("所有APP"),
                regionName: .constant("中国")
            )
                .preferredColorScheme(.dark)
            
            RankSortView(
                rankName: .constant("热门免费榜"),
                categoryName: .constant("所有APP"),
                regionName: .constant("中国")
            )
                .preferredColorScheme(.light)
                
        }
    }
}
