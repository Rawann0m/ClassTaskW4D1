//
//  ContentView.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    var body: some View {
        TabView {
            
            // service HomeView
            HomeView(settingsViewModel: settingsViewModel)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            // SettingsView
            SettingsView(settingsViewModel: settingsViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .background(Color.clear) // Set the TabView background to clear
                .onAppear {
                    // Customize the TabView appearance
                    let appearance = UITabBarAppearance()
                    appearance.configureWithTransparentBackground() // Make the tab bar transparent
                    appearance.backgroundColor = .clear // Set the background color to clear
                    UITabBar.appearance().standardAppearance = appearance
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            }
        }

#Preview {
    ContentView()
}
