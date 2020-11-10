//
//  TableViewModelType.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

protocol TableViewViewModelType {
    var numberOfRows: Int { get }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType?
    var cellNib: String { get }
    var cellIdentifier: String { get }
    var detailVCStoryboard: String { get }
    var detailVCControllerId: String { get }
    func getGists(completionHandler: @escaping () -> ()) -> Void
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath) 
}

extension TableViewViewModelType {
    var detailVCStoryboard: String { return "" }
    var detailVCControllerId: String { return "" }
}
