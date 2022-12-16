//
//  TopTabBarButtonView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct TopTabBarButton: View {
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
            TopTabBarButton(text: "Lorem ipsum", isSelected: .constant(false))
            Spacer()
                .frame(height: 100)
            TopTabBarButton(text: "Lorem ipsum", isSelected: .constant(true))
            Spacer()
                .frame(height: 100)
            HStack {
                TopTabBarButton(text: "Lorem ipsum", isSelected: .constant(true))
                TopTabBarButton(text: "Button", isSelected: .constant(false))
            }
        }
    }
}
