//
//  NetworkService.swift
//  Books Explorer
//
//  Created by Sina Vosough Nia on 7/29/1403 AP.
//

import Foundation

class NetworkService {
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingFailed(Error)
        case serverError(statusCode: Int)
        case unknownError

        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The URL provided was invalid."
            case .noData:
                return "No data was received from the server."
            case .decodingFailed(let error):
                return "Failed to decode the data: \(error.localizedDescription)"
            case .serverError(let statusCode):
                return "User not found : \(statusCode)."
            case .unknownError:
                return "An unknown error occurred."
            }
        }
    }
    
    func getBooks(query:String)async throws -> [Book]?{
        
        guard let url = URL(string: Constants.baseURL+query+"&maxResults=40&orderBy=relevance&key="+Constants.googleApiKey) else{
            throw NetworkError.invalidURL
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let (result , response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else{
                throw NetworkError.unknownError
            }
            if response.statusCode >= 200 && response.statusCode < 300 {
                do {
                     let result = try decoder.decode(Books.self, from: result)
                        return result.items
                    
                } catch let decodingError{
                    throw  NetworkError.decodingFailed(decodingError)
                 }
            }else{
                throw NetworkError.serverError(statusCode: response.statusCode)
            }
        } catch let error as NetworkError {
            throw error
        }
    }
}
