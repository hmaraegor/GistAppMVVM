//
//  DetailViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import Foundation
import UIKit

class DetailViewModel: DetailViewModelType {
    
    var gist: Gist
    var fileText: String?
    
    init(gist: Gist) {
        self.gist = gist
    }

    var files: [File] {
        return gist.files
    }
    
    var firstFileName: String {
        guard let file = self.files.first else { return "" }
        return file.filename
    }
    
    var author: String {
        return gist.owner.login
    }
    
    var changed: String {
        DateService.getDate(from: gist.updatedAt ?? gist.createdAt)
    }
    
    func getFileText(completionHandler: @escaping (Data) -> ()) {
        AlamofireNetworkService.fetchData(url: files.first!.rawUrl) { (data, error) in
            if let data = data {
                //let text: String = String(decoding: data, as: UTF8.self)
                completionHandler(data)
            } else if let error = error {
                ErrorAlertService.showAlert(error: error)
            }
        }
    }
    
}
