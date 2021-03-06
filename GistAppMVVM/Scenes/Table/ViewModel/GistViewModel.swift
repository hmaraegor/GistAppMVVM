//
//  TableViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import UIKit

class TableViewModel: TableViewViewModelType {
    
    private var selectedIndexPath: IndexPath?
    
    var gistArray = [Gist]()
    
    var numberOfRows: Int {
        return gistArray.count
    }
    
    var cellNib: String {
        return CellViewModel.nib
    }
    
    var cellIdentifier: String {
        return CellViewModel.identifier
    }
    
    var detailVCStoryboard: String {
        return DetailViewModel.storyboardName
    }
    
    var detailVCControllerId: String {
        return DetailViewModel.controllerId
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
        AlamofireNetworkService.fetchAndDecodable(url: Constants.gitHubGistsUrl) { (gists, error) in
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
}
