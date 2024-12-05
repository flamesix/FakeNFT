//
//  DeleteNftService.swift
//  FakeNFT
//
//  Created by Pavel Bobkov on 17.11.2024.
//

import Foundation

protocol DeleteNftServiceProtocol {
    func updateCart(nfts: [String], completion: @escaping CartCompletion)
}

final class DeleteNftService: DeleteNftServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func updateCart(nfts: [String], completion: @escaping CartCompletion) {
        var parametrs = ""
        
        if nfts.isEmpty {
            parametrs += "&nfts=null"
        } else {
            nfts.forEach {
                parametrs += "&nfts=\($0)"
            }
        }
        
        guard let body = parametrs.data(using: .utf8),
              let url = URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseData = data else {
                completion(.failure(NSError(domain: "No data received", code: 324)))
                return
            }
            
            do {
                let cart = try JSONDecoder().decode(Cart.self, from: responseData)
                completion(.success(cart))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
