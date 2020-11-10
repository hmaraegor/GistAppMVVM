//
//  CellViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

class CellViewModel: CellViewModelType {

    private var gist: Gist
    
    init(gist: Gist) {
        self.gist = gist
    }

    var files: String {
        return getFileNames(from: gist).joined(separator:", ")
    }
    
    var author: String {
        return gist.owner.login
    }
    
    var avatarUrl: String {
        return gist.owner.avatarUrl
    }
    
    var date: String {
        return DateService.getDate(from: gist.createdAt)
    }
    
    func setImage(completionHandler: @escaping (Data) -> ()) {
        AlamofireNetworkService.fetchData(url: self.avatarUrl) { (data, error) in
            if let data = data {
                completionHandler( data )
            } else if let error = error {
                ErrorAlertService.showAlert(error: error)
            }
        }
    }
    
    private func getFileNames(from content: Gist) -> [String] {
        return content.files.map { $0.filename }
    }
    
}
