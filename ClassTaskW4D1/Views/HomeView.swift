//
//  HomeView.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//
import SwiftUI

struct HomeView: View {
        @StateObject var viewModel = NewsViewModel()
        @ObservedObject var settingsViewModel: SettingsViewModel
        
        var body: some View {
            NavigationStack {
                ZStack {
                    //i reached to the api request limit i cant see how this look like
//                    // Background Image
//                    Image(settingsViewModel.isDarkMode ? "background1" : "background")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: .infinity,height: .infinity)
//                        .edgesIgnoringSafeArea(.all)
                    
                    // List of Articles
                    List {
                        // Show all the articles
                        ForEach(viewModel.allArticles) { article in
                            VStack(alignment: .leading) {
                                // Display the images for each article
                                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                // Article title
                                Text(article.title)
                                    .font(.headline)
                                // Article description
                                Text(article.description ?? "No description")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .listRowBackground(Color.clear) // Make list rows transparent
                        }
                        
                        // Show a "Load More" button if there are more articles to load
                        if viewModel.allArticles.count < viewModel.totalArticles {
                            Button(action: {
                                // Call fetchNews to load the next set of articles
                                viewModel.fetchNews()
                            }) {
                                HStack {
                                    Spacer()
                                    if viewModel.isLoading {
                                        ProgressView() // Show a loading spinner if data is being fetched
                                    } else {
                                        Text("Load More") // Show the "Load More" button
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.purple)
                                            .cornerRadius(10)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical)
                            }
                            .listRowBackground(Color.clear) // Make the button row transparent
                        }
                    }
                    .scrollContentBackground(.hidden) // Hide the default List background
                    .navigationTitle("News")
                    .onAppear {
                        // Fetch the first page of data when the view appears
                        if viewModel.allArticles.isEmpty {
                            viewModel.fetchNews()
                        }
                    }
                    .alert(isPresented: $viewModel.showErrorAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .default(Text("OK"))
                    )}
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView("Loading...")
                        }
                    }
                }
                .preferredColorScheme(settingsViewModel.isDarkMode ? .dark : .light)
            }
        }
    }

