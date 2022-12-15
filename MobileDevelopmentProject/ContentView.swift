//
//  ContentView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "Primary")
    }
    
    var body: some View {
        TabView {
            TalksView()
                .tabItem {
                    Label("Talks", systemImage: "calendar")
                }
            SpeakersView()
                .tabItem {
                    Label("Speakers", systemImage: "person")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }.onAppear{
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
