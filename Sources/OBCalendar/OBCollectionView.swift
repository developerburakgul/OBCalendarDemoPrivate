//
//  OBCollectionView.swift
//
//
//  Created by Kerim Çağlar on 24.09.2024.
//

import SwiftUI

public struct OBCollectionView<Content: View, DataType>: View {
    
    let data: [DataType]
    let isLazy: Bool
    let axis: Axis.Set
    let gridItems: [GridItem]
    let gridSpacing: CGFloat
    let scrollEnabled: Bool
    
    @ViewBuilder let content: (
        _ item: DataType,
        _ index: Int,
        _ scrollProxy: ScrollViewProxy?
    ) -> Content
    
    public init(
        data: [DataType],
        isLazy: Bool = false,
        axis: Axis.Set = .vertical,
        gridItems: [GridItem] = [GridItem()],
        gridSpacing: CGFloat = 8,
        scrollEnabled: Bool = true,
        @ViewBuilder content: @escaping (
            _ item: DataType,
            _ index: Int,
            _ scrollProxy: ScrollViewProxy?
        ) -> Content
    ) {
        self.data = data
        self.isLazy = isLazy
        self.axis = axis
        self.gridItems = gridItems
        self.gridSpacing = gridSpacing
        self.scrollEnabled = scrollEnabled
        self.content = content
    }
    
    public var body: some View {
        
        if scrollEnabled {
            
        } else {
            
        }
    }
    
    private func makeDataContentView(scrollProxy: ScrollViewProxy?) -> some View {
        ForEach(data.indices, id: \.self) { index in
            
            content(data[index], index, scrollProxy)
        }
    }
}

#Preview {
    OBCollectionView(data: []) {
        item,
        index,
        scrollProxy in
    }
}
