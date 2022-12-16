//
//  ContentView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TalksView()
                .tabItem {
                    Label("Talks", systemImage: "calendar")
                }
                .toolbarBackground(Color.background, for: .tabBar)
            SpeakersView()
                .tabItem {
                    Label("Speakers", systemImage: "person")
                }
                .toolbarBackground(Color.background, for: .tabBar)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .toolbarBackground(Color.background, for: .tabBar)
        }.onAppear{
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            UITabBar.appearance().unselectedItemTintColor = UIColor(named: "Primary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
