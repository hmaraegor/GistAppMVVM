//
//  DecodeService.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

class DecodeService {
    
    func decodeData<T: Decodable>(data: Data, completionHandler:
                                    @escaping (Result<T, NetworkErrorService>) -> ()) {
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print("json\n", json)
        } catch {
            print("json error")
        }
        
        do {
            let gistList = try JSONDecoder().decode(T.self, from: data)
            completionHandler(.success(gistList))
        } catch {
            completionHandler(.failure(.jsonDecoding))
        }
        
        
    }
    
}
