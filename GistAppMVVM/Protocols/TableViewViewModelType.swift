//
//  TableViewModelType.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

protocol TableViewViewModelType {
    var numberOfRows: Int { get }
    var gistArray: [Gist] { get set }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType?
    func getGistsViaAFDecodable(completionHandler: @escaping () -> ()) -> Void
    func getGistsViaAlamofire(completionHandler: @escaping () -> ()) -> Void
    func getGistsViaNetworkService(completionHandler: @escaping () -> ()) -> Void
}
