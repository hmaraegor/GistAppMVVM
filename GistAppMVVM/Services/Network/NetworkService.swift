//
//  NetworkService.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation
import Alamofire

class NetworkService {
    
    typealias Completion<T: Codable> = (Result<T, NetworkErrorService>) -> ()
    
    func get<T: Codable>(url: String, _ completion: @escaping Completion<T>) {
        performHTTPRequest(url: url, method: "GET", data: nil, params: nil, completion)
    }
    
    // MARK: - Private
    private func performHTTPRequest<T: Codable>(url: String, method: String, data: Data?, params: [String: Any]?, _ completion: @escaping Completion<T>) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = data
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response else {
                completion(.failure(.noResponse))
                return }
            guard let data = data else {
                completion(.failure(.noData))
                return }
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.badResponse))
                    print("Status code: ", (response as? HTTPURLResponse)?.statusCode)
                    return
            }
            
            // MARK: - Decoding data and return object
            DecodeService().decodeData(data: data, completionHandler: completion)
            
        }.resume()
    }
}

class AlamofireNetworkService {
    
    static func fetchData(url: String,
                           completionHandler: @escaping (Data?, Error?) -> () ) {
        
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
            
        }
        
    }
    
    static func fetchAndDecodable(url: String,
                                   completionHandler: @escaping ([Gist]?, Error?) -> () ) {
             guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().responseDecodable(of: [Gist].self) { (response) in
          guard let gists = response.value else { return }
            completionHandler(gists, nil)
            print("ok")
        }

    }
    
    static func fetchRequest(url: String,
                              completionHandler: @escaping ([Gist]?, Error?) -> () ) {
        guard let url = URL(string: url) else { return }
        
        
        AF.request(url).validate().responseData { (data) in
            guard let data = data.value else {
                print("wrong data")
                return
            }
            DecodeService().decodeData(data: data) { (result: Result<[Gist], NetworkErrorService>) -> () in
                switch result {
                case .success(let obj):
                    completionHandler(obj, nil)
                    print("decoding ok")
                case .failure(let error):
                    print("error decoding")
                    completionHandler(nil, error)
                }
            }
        }
    }
    
    
    
    
    
    static func fetchRequestV1(url: String) {
        guard let url = URL(string: url) else { return }
        
        guard false else { return }
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value): //success при ответе + validate <- 200-299
                print("value:", value)
            case .failure(let error):
                print("error:", error)
            }
        }
    
        
        guard false else { return }
        AF.request(url).responseJSON { (response) in
            //TODO:
            guard let statusCode = response.response?.statusCode else { return }
            print("StatusCode:", statusCode)
            if (200...299).contains(statusCode) {
                let value = response.result
                let v = response.value
                
                /*switch value {
                case .success(let value2):
                    print("value2:", value2)
                case .failure(_): break
                }*/
                
                print("value:", v ?? "nil")
            } else {
                let error = response.error
                print("error:", error ?? "error")
            }
        }
    }
}
