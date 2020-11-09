//
//  GistNetworkService.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import UIKit

class GistNetworkService {
    private let networkService = NetworkService()
        
    func getGists(completionHandler:
    @escaping ([Gist]?, Error?) -> ()) {
        let gistsURL = "gists"
        let url = "https://api.github.com/" + gistsURL
        
        var completion = { (result: Result<[Gist], NetworkErrorService>) in
            switch result {
            case .success(let returnedContentList):
                completionHandler(returnedContentList, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
        networkService.get(url: url, completion)
    }
}
