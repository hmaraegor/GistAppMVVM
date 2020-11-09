//
//  GistViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

class GistViewModel: TableViewViewModelType {
    
    private var selectedIndexPath: IndexPath?
    
    var gistArray = [Gist]()
    
    var numberOfRows: Int {
        return gistArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType? {
        let gist = gistArray[indexPath.row]
        
        return CellViewModel(gist: gist)
    }
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(gist: gistArray[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func getGistsViaAFDecodable(completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchAndDecodable(url: "https://api.github.com/gists/public") { (gists, error) in
            if gists != nil {
                //print(gists!)
                self.gistArray = gists!
                print("getGistsDecodable: ok")
            } else if error != nil {
                print("getGistsDecodable: error")
                //TODO:
            }
            completionHandler()
        }
    }
    
    func getGistsViaAlamofire (completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchRequest(url: "https://api.github.com/gists/public") { (gists: [Gist]?, error) in
            if gists != nil {
                print(gists!)
                self.gistArray = gists!
                print("getGistsAlamofire: ok")
            } else if error != nil {
                print("getGistsAlamofire: error")
                //TODO:
            }
            completionHandler()
        }
    }
}
