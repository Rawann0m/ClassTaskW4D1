//
//  NewsViewModel.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//
import Foundation
import Alamofire
import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var allArticles: [Article] = []
    @Published var currentPage: Int = 1
    @Published var totalArticles: Int = 0
    private let intercepter = APIInterceptor()
    //my key
    //"fe24dbf8ea434d89a5c230b1e88c8c89"
    
    // List of API URLs with pageNumber and pageSize
    let apiURLs = [
        "https://newsapi.org/v2/everything?q=apple&from=2025-03-22&to=2025-03-22&sortBy=popularity&pageSize=10",
        "https://newsapi.org/v2/everything?q=tesla&from=2025-03-23&sortBy=publishedAt&pageSize=10",
        "https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=10",
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&pageSize=10",
        "https://newsapi.org/v2/everything?domains=wsj.com&pageSize=10"
    ]
    
    // Fetch all news articles with pagination support
    func fetchNews() {
        if isLoading { return }
        
        print("Fetching news for page \(currentPage)...")
        
        isLoading = true // Show loading indicator
        var fetchedArticles: [Article] = [] // Temporary storage for articles
        let dispatchGroup = DispatchGroup() // Create a dispatch group
        
        let apiKey = APIKeyManager.shared.getAPIKey() // Fetch the API key from Keychain
        print("Using API key: \(apiKey)")
        
        // Loop through each API URL, adding pagination parameters
        for url in apiURLs {
            let paginatedURL = "\(url)&apiKey=\(apiKey)&page=\(currentPage)" // Add the page number to the URL
            dispatchGroup.enter() // Notify the group that a task has started
            
            // Use Alamofire to make a network request
            AF.request(paginatedURL, method: .get,interceptor: intercepter)
                .validate() // Ensure the response is valid
                .responseDecodable(of: NewsResponse.self) { response in
                    DispatchQueue.main.async {
                        switch response.result {
                        case .success(let data):
                            // If the request is successful, add articles to the list
                            if let articles = data.articles {
                                fetchedArticles.append(contentsOf: articles)
                                self.totalArticles = data.totalResults
                                print("Fetched \(articles.count) articles using Alamofire")
                            }
                        case .failure(let error):
                            // If the request fails, show an error message
                            self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                            self.showErrorAlert = true
                            print("Error fetching data: \(error.localizedDescription) from \(paginatedURL)")
                        }
                        dispatchGroup.leave()
                    }
                }
        }
        
        // Notify when all tasks are done
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            // Sort articles by date (most recent first)
            self.allArticles.append(contentsOf: self.sortArticlesByDate(fetchedArticles))
            self.currentPage += 1
            print("Finished fetching. Total articles: \(self.allArticles.count)")
        }
    }
    
    // Sort articles by date (most recent first)
    private func sortArticlesByDate(_ articles: [Article]) -> [Article] {
        return articles.sorted { $0.publishedAt > $1.publishedAt }
    }
}


