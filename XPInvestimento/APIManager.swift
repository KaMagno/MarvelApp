//
//  APIManager.swift
//  XPInvestimento
//
//  Created by Kaique Magno Dos Santos on 23/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    // MARK: - Properties
    // MARK: Private
    static let shared:APIManager = APIManager()
    
    private let session = URLSession(configuration: .default)
    
    // MARK: - Init
    private override init() {
        super.init()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        let hash = Constants.MarvelAPI.hash
        let url = URL(
            string: "\(Constants.MarvelAPI.baseEndpoint)\(request.endpoint)?ts=\(Constants.MarvelAPI.ts)&hash=\(hash)&apikey=\(Constants.MarvelAPI.publicKey)&\(parameters)")!
        return url
    }
    
    // MARK: Public
    func send<T>(_ request: T, completion: @escaping (Result<DataContainer<T.Response>>) -> Void) where T : APIRequest {
        let endpoint = self.endpoint(for: request)
        print("Endpoint: \(endpoint)")
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    // Decode the top level response, and look up the decoded response to see
                    // if it's a success or a failure
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: data)
                    
                    if let dataContainer = marvelResponse.data {
                        completion(Result.success(dataContainer))
                    } else if let message = marvelResponse.message {
                        completion(.failure(APIError.server(message: message)))
                    } else {
                        completion(.failure(APIError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}