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
    
    func getGistsViaAFDecodable(completionHandler: @escaping () -> ()) -> Void
    func getGistsViaAlamofire(completionHandler: @escaping () -> ()) -> Void
    
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath) 
}
