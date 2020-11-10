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
        return Constants.Cell.cellNib
    }
    
    var cellIdentifier: String {
        return Constants.Cell.cellId
    }
    
    var detailVCStoryboard: String {
        return Constants.DetailVC.storyboard
    }
    
    var detailVCControllerId: String {
        return Constants.DetailVC.controllerId
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

    func getGists(completionHandler: @escaping () -> ()) {
        AlamofireNetworkService.fetchAndDecode(url: Constants.gitHubGistsUrl) { (gists, error: NetworkErrorService?) in
            if let gists = gists {
                self.gistArray = gists
            } else if let error = error {
                ErrorAlertService.showAlert(error: error)
            }
            completionHandler()
        }
    }
}
