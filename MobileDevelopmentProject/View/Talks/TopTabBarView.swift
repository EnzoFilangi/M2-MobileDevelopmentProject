//
//  TopTabBarView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBarView: View {
    @State var tabIndex = 0
    
    var titles = ["Right now", "Up next"]
    
    var body: some View {
        VStack{
            TopTabBarButtonsContainerView(tabIndex: $tabIndex, titles: self.titles)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct TopTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBarView()
    }
}
