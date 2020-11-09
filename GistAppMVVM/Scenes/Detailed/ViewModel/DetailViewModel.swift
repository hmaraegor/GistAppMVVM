//
//  DetailViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import Foundation

class DetailViewModel: DetailViewModelType {
    
    var gist: Gist
    var fileText: String?
    
    var files: [File] {
        return gist.files
    }
    
    init(gist: Gist) {
        self.gist = gist
    }
    
    func getFileTextViaAlamofire(completionHandler: @escaping (String) -> ()) {
        AlamofireNetworkService.fetchData(url: files.first!.rawUrl) { (data, error) in
            if data != nil {
                print("text ok")
                guard let data = data else { return }
                let str: String = String(decoding: data, as: UTF8.self) as! String
                //self.fileText = text!
                completionHandler(str)
            } else if error != nil {
                print("text: error")
                //TODO:
            }
        }
    }
    
}
