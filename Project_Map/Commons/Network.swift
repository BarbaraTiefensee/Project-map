//
//  Network.swift
//  Project_Map
//
//  Created by Bárbara Tiefensee on 24/08/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    private let url = "https://api.jsonbin.io/b/612549c0076a223676b09c8e"
    
    func fetch<T>(completion: @escaping(Result<[T], Error>) -> Void) where T: Decodable {
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    let error = NSError(domain: "Error", code: 001, userInfo: nil)
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decoderMap = try decoder.decode([T].self, from: data)
                completion(.success(decoderMap))
            } catch {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}
