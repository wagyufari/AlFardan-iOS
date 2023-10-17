//
//  APIClient.swift
//  alfardan
//
//  Created by Muhammad Ghifari on 17/10/2023.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    
    private init() { }
    
    func performRequest<T: Decodable>(
        _ url: String,
        decodingType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func performPostRequest<T: Decodable>(
        _ url: String,
        parameters: Parameters?,
        decodingType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
