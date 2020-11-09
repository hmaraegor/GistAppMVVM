//
//  CellViewModel.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation
import UIKit

class CellViewModel: CellViewModelType {

    private var gist: Gist
    var avatarImg: UIImage?
    
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
        getDate(strDate: gist.createdAt)
    }
    
    func setImage(completionHandler: @escaping (UIImage) -> ()) {
        if let image = avatarImg {
            completionHandler(image)
            return
        }
        AlamofireNetworkService.fetchData(url: self.avatarUrl) { (data, error) in
            if let data = data {
                self.avatarImg = UIImage(data: data)
                completionHandler( self.avatarImg ?? UIImage() )
            } else if error != nil {
                //TODO:
            }
        }
    }
    
    private func getDate(strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = formatter.date(from: strDate) //as NSDate?
        formatter.dateFormat = "HH:mm d MMM y"
        let newDate = formatter.string(from: myDate!)
        
        return newDate
    }
    
    private func getFileNames(from content: Gist) -> [String] {
        return content.files.map { $0.filename }
    }
    
}
