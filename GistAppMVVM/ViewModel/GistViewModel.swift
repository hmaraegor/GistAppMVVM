//
//  GistViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

class GistViewModel: TableViewViewModelType {
    
    var gistArray = [Gist]()
    
    var numberOfRows: Int {
        return gistArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType? {
        let gist = gistArray[indexPath.row]
        
        return CellViewModel(gist: gist)
    }
    
    var gistService = GistNetworkService()
    
    func getGistsViaNetworkService(completionHandler: @escaping () -> ()) {
        gistService.getGists { [weak self] (gists, error) in
            if gists != nil {
                self?.gistArray = gists ?? []
            } else if error != nil {
                //TODO:
            }
            completionHandler()
        }
    }
    
    func getImage(_ url: String, completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchData(url: url) { (data, error) in
            if data != nil {
                //self.gistArray = gists!
                print("getImage: ok")
            } else if error != nil {
                print("getImage: error")
                //TODO:
            }
            completionHandler()
        }
    }
    
    func getGistsViaAFDecodable(completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchAndDecodable(url: "https://api.github.com/gists/public") { (gists, error) in
            if gists != nil {
                print(gists!)
                self.gistArray = gists!
                print("getGists2: ok")
            } else if error != nil {
                print("getGists2: error")
                //TODO:
            }
            completionHandler()
        }
    }
    
    func getGistsViaAlamofire (completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchRequest(url: "https://api.github.com/gists/public") { /*[weak self]!!*/ (gists, error) in
            if gists != nil {
                print(gists!)
                self.gistArray = gists!
                print("getGists2: ok")
            } else if error != nil {
                print("getGists2: error")
                //TODO:
            }
            completionHandler()
        }
    }
}
