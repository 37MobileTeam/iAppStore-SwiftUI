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
                    VStack{
                        Divider()
                        if currentSortType == .rankType {
                            ScrollView {
                                ForEach(0..<TSMGConstants.rankingTypeLists.count){ index in
                                    HStack{
                                        let type = TSMGConstants.rankingTypeLists[index]
                                        if type == rankName {
                                            Text(type).padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        } else {
                                            Text(type).padding(.horizontal).padding(.vertical, 5)
                                        }
                                        Spacer()
                                        if type == rankName {
                                            Image(systemName: "checkmark").padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        }
                                    }
                                    .background(Color.tsmg_systemBackground)
                                    .onTapGesture {
                                        currentSortType = .noneType
                                        withAnimation{
                                            let type = TSMGConstants.rankingTypeLists[index]
                                            rankName = type
                                            sortViewIsExpanded = false
                                        }
                                        if nil != action {
                                            action!(rankName, categoryName, regionName)
                                        }
                                    }
                                    
                                }
                            }
                        } else if currentSortType == .categoryType {
                            ScrollView {
                                ForEach(0..<TSMGConstants.categoryTypeLists.count){index in
                                    HStack{
                                        let type = TSMGConstants.categoryTypeLists[index]
                                        if type == categoryName {
                                            Text(type).padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        } else {
                                            Text(type).padding(.horizontal).padding(.vertical, 5)
                                        }
                                        Spacer()
                                        if type == categoryName {
                                            Image(systemName: "checkmark").padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        }
                                    }
                                    .background(Color.tsmg_systemBackground)
                                    .onTapGesture {
                                        currentSortType = .noneType
                                        withAnimation{
                                            let type = TSMGConstants.categoryTypeLists[index]
                                            categoryName = type
                                            sortViewIsExpanded = false
                                        }
                                        if nil != action {
                                            action!(rankName, categoryName, regionName)
                                        }
                                    }
                                }
                            }
                        } else if currentSortType == .regionType {
                            ScrollView {
                                ForEach(0..<TSMGConstants.regionTypeLists.count){index in
                                    HStack{
                                        let type = TSMGConstants.regionTypeLists[index]
                                        if type == regionName {
                                            Text(type).padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        } else {
                                            Text(type).padding(.horizontal).padding(.vertical, 5)
                                        }
                                        Spacer()
                                        if type == regionName {
                                            Image(systemName: "checkmark").padding(.horizontal).padding(.vertical, 5).foregroundColor(.blue)
                                        }
                                    }
                                    .background(Color.tsmg_systemBackground)
                                    .onTapGesture {
                                        currentSortType = .noneType
                                        withAnimation{
                                            let type = TSMGConstants.regionTypeLists[index]
                                            regionName = type
                                            sortViewIsExpanded = false
                                        }
                                        if nil != action {
                                            action!(rankName, categoryName, regionName)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .background(Color.tsmg_systemBackground)
                    .frame(maxHeight: 210)
                },
                label: { HStack{
                    Spacer()
                    HStack{
                        Text(rankName)
                        if currentSortType == .rankType {
                            Image(systemName: "chevron.up")
                        } else {
                            Image(systemName: "chevron.down")
                        }
                    }.onTapGesture {
                        if currentSortType == .rankType {
                            sortViewIsExpanded = false
                            currentSortType = .noneType
                        } else {
                            sortViewIsExpanded = true
                            currentSortType = .rankType
                        }
                    }
                    Spacer()
                    HStack{
                        Text(categoryName)
                        if currentSortType == .categoryType {
                            Image(systemName: "chevron.up")
                        } else {
                            Image(systemName: "chevron.down")
                        }
                    }.onTapGesture {
                        if currentSortType == .categoryType {
                            sortViewIsExpanded = false
                            currentSortType = .noneType
                        } else {
                            sortViewIsExpanded = true
                            currentSortType = .categoryType
                        }
                    }
                    Spacer()
                    HStack{
                        Text(regionName)
                        if currentSortType == .regionType {
                            Image(systemName: "chevron.up")
                        } else {
                            Image(systemName: "chevron.down")
                        }
                    }.onTapGesture {
                        if currentSortType == .regionType {
                            sortViewIsExpanded = false
                            currentSortType = .noneType
                        } else {
                            sortViewIsExpanded = true
                            currentSortType = .regionType
                        }
                    }
                    Spacer()
                } }
            ).buttonStyle(PlainButtonStyle()).accentColor(.clear)
        }.onDisappear() {
            sortViewIsExpanded = false
            currentSortType = .noneType
        }
    }
}


extension RankSortView {
    
    func selected(_ action: @escaping (_ rankName: String, _ categoryName: String, _ regionName: String) -> Void ) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

//struct RankSortView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RankSortView(rankName: $rankName, categoryName: $categoryName, regionName: $regionName)
//    }
//}
