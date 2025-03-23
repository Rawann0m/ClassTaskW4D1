//
//  APIInterceptor.swift
//  ClassTaskW4D1
//
//  Created by Rawan on 23/09/1446 AH.
//
import Alamofire
import Foundation

final class APIInterceptor: RequestInterceptor {
     private var authToken: String {
        return "fe24dbf8ea434d89a5c230b1e88c8c89"
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var modifiedRequest = urlRequest
        // Add the Authorization token to the header
        modifiedRequest.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        print("\n=============================")
        print("🔗 API REQUEST: Adapted Request")
        print("🛠 URL: \(urlRequest.url?.absoluteString ?? "")")
        print("🔑 Authorization: \(urlRequest.value(forHTTPHeaderField: "Authorization") ?? "No Token")")
        print("=============================\n")
        completion(.success(modifiedRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Handle retry logic if needed (e.g., refresh token on 401)
        guard let response = request.response, response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        print("🔄 Retrying request due to expired token...")
        // Refresh token logic can be added here before retrying
        completion(.retry)
    }
}
