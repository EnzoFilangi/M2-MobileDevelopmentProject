//
//  TopTabBarButtonView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBarButtonView: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        VStack{
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .accent : .main)
                .padding(.bottom,-1)
            Divider()
                .frame(minHeight: 3)
                .overlay(Color.accent)
                .opacity(isSelected ? 1 : 0)
        }
    }
}

struct TopTabBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TopTabBarButtonView(text: "Lorem ipsum", isSelected: .constant(false))
            Spacer()
                .frame(height: 100)
            TopTabBarButtonView(text: "Lorem ipsum", isSelected: .constant(true))
            Spacer()
                .frame(height: 100)
            HStack {
                TopTabBarButtonView(text: "Lorem ipsum", isSelected: .constant(true))
                TopTabBarButtonView(text: "Button", isSelected: .constant(false))
            }
        }
    }
}
