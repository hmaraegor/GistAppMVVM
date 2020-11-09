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
                           completionHandler: @escaping (Data?, Error?) -> () ) {
        
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                print("responseData success")
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
                print("responseData error")
            }
            
        }
        
    }
    
    static func fetchAndDecodable(url: String,
                                   completionHandler: @escaping ([Gist]?, Error?) -> () ) {
             guard let newUrl = URL(string: url) else {
                print("fetchAndDecodable url error")
                return }
        
        AF.request(newUrl).validate().responseDecodable(of: [Gist].self) { (response) in
            
            guard let gists = response.value else {
                print("fetchAndDecodable response.value error")
                print(response.error)
                fetchRequest(url: url, completionHandler: completionHandler )
                return
            }
            
            completionHandler(gists, nil)
            print("ok")
        }

    }
    
    static func fetchRequest<T: Decodable>(url: String,
                              completionHandler: @escaping (T?, Error?) -> () ) {
        guard let url = URL(string: url) else { return }
        
        
        AF.request(url).validate().responseData { (data) in
            guard let data = data.value else {
                print("wrong data")
                return
            }
            DecodeService().decodeData(data: data) { (result: Result<T, NetworkErrorService>) -> () in
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
    
}
