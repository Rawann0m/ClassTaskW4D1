# News App with API Interceptors, Pagination, and Secure API Key Storage
## Project Description
This iOS project demonstrates the implementation of a news app that fetches news articles from free news APIs. The project focuses on three key tasks:

API Interceptors: Implementing Alamofire's RequestInterceptor to add an authorization token dynamically to every API request.

API Pagination: Implementing pagination to fetch news articles dynamically and display them in a SwiftUI List with the option to load more data.

Secure API Key Storage: Storing the API key securely using Apple's Keychain Services to avoid hardcoding sensitive data in the source code.

## Tasks Breakdown
Task 1: Implement API Interceptors

Created a APIInterceptor class using Alamofire's RequestInterceptor.

Modified all API requests to dynamically include an authorization token.

Task 2: Implement API Pagination

Fetches paginated news articles from various free news APIs.

Updates a SwiftUI List dynamically to display fetched articles.

Added a "Load More" button that fetches additional pages when clicked.

Task 3: Secure API Key Storage

Stored the API key securely using Apple's Keychain Services to ensure it is not hardcoded.

Ensured that the API key is accessed securely in API requests.

## Features
API Interceptors: Ensures API requests are properly authorized by dynamically adding a token.

Pagination: Fetches a limited number of articles per page and loads more as needed.

Keychain Integration: Securely stores the API key to prevent hardcoding in source code.

## Setup and Installation
Prerequisites
Xcode: This project is built using Xcode and Swift.

Alamofire: The project uses Alamofire for network requests. It should be installed using CocoaPods, Carthage, or Swift Package Manager.

Installation Steps
Clone the repository

Open the Xcode project

Open ClassTaskW4D1.xcworkspace to work with the project.

Run the app in the iOS simulator or on a physical device.

## Key Components
1. APIInterceptor:
A class that implements Alamofire's RequestInterceptor to dynamically add the API authorization token to each network request.

2. API Pagination:
Fetches news articles from multiple free news APIs. The app supports pagination, allowing users to load more news articles using a "Load More" button.

3. Secure Storage (Keychain):
The API key is securely stored in the iOS Keychain using Apple's Keychain Services API, ensuring the key is never hardcoded or exposed.
