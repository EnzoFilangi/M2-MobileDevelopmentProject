//
//  ContentView.swift
//  MobileDevelopmentProject
//
//  Created by Enzo Filangi on 14/12/2022.
//

import SwiftUI

struct MainView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.main]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.main]
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
            // Force opaque background
            tabBarAppearance.configureWithOpaqueBackground()
            
            // Set the background color of the tab bar so it matches with the rest
            tabBarAppearance.backgroundColor = UIColor.background
            
            // Apply the new appearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
