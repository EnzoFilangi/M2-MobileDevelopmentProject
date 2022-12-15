//
//  TopTabBarContainerView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBarButtonsContainerView: View {
    @Binding var tabIndex: Int
    let titles : [String]
    
    init(tabIndex: Binding<Int>, titles: [String]) {
        self._tabIndex = tabIndex
        self.titles = titles
    }
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach (Array(titles.enumerated()), id: \.element) {index, element in
                TopTabBarButtonView(text: element, isSelected: .constant(tabIndex == index))
                    .onTapGesture { onButtonTapped(index: index) }
            }
        }
    }
    
    private func onButtonTapped(index: Int) {
        tabIndex = index
    }
}

struct TopTabBarButtonsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBarButtonsContainerView(tabIndex: .constant(0), titles: ["FirstView", "SecondView"])
    }
}
