//
//  NetworkManager.swift
//  RebtelTakeHomeProject
//
//  Created by Sebastian Mendez on 2021-09-12.
//

import UIKit

enum CustomError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getCountries(completed: @escaping (Result<[Country], CustomError>) -> Void) {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {
            completed(.failure(.invalidURL))
            return
        }
         
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil  {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Country].self, from: data)
                completed(.success(decodedResponse))
            } catch let error as DecodingError {
                self.printDecodingError(error)
                completed(.failure(.invalidData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func printDecodingError(_ error: DecodingError) {
        switch error {
        case .typeMismatch(let key, let value):
            print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .valueNotFound(let key, let value):
            print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .keyNotFound(let key, let value):
            print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
        case .dataCorrupted(let key):
            print("error \(key), and ERROR: \(error.localizedDescription)")
        default:
            print("ERROR: \(error.localizedDescription)")
        }
    }
}
