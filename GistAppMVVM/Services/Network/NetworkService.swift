//
//  NetworkService.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkService {
    
    static func fetchData(url: String,
                           completionHandler: @escaping (Data?, NetworkErrorService?) -> () ) {
        
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure:
                completionHandler(nil, .noData)
            }
            
        }
        
    }
    
    static func fetchAndDecode(url: String,
                                   completionHandler: @escaping ([Gist]?, NetworkErrorService?) -> () ) {
             guard let newUrl = URL(string: url) else {
                completionHandler(nil, .badURL)
                return }
        
        AF.request(newUrl).validate().responseDecodable(of: [Gist].self) { (response) in
            guard let statusCode = response.response?.statusCode,
                  (200...299).contains(statusCode) else {
                completionHandler(nil, .badResponse)
                return
            }
            
            guard let gists = response.value else {
                completionHandler(nil, .jsonDecoding)
                return
            }
            completionHandler(gists, nil)
        }

    }
    
}
