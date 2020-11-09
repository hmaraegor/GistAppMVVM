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
    private var avatarImg: UIImage?
    
    init(gist: Gist) {
        self.gist = gist
    }

    var files: String {
        return getFileNames(from: gist).joined(separator:", ")
    }
    
    var author: String {
        return gist.owner.login
    }
    
    //TODO:
    var avatarUrl: String {
        return gist.owner.avatarUrl ?? ""
    }
    
    func getImage(_ url: String) -> UIImage {
        guard avatarImg == nil else { return avatarImg! }
        
        AlamofireNetworkService.fetchData(url: url) { (data, error) in
            if data != nil {
                self.avatarImg = UIImage(data: data!)!
                
                print("getImage: ok")
            } else if error != nil {
                print("getImage: error")
                //TODO:
            }
//            completionHandler()
        }
        return UIImage()
    }
    
    var date: String {
        getDate(strDate: gist.createdAt)
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
