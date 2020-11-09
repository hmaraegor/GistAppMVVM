//
//  TableViewCell.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 09.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import UIKit

class GistListCell: UITableViewCell {
    
    @IBOutlet private var files: UILabel!
    @IBOutlet private var author: UILabel!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var date: UILabel!
    
    weak var cellViewModel: CellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel  else { return }
            self.files.text = "files: " + viewModel.files
            self.author.text = "author: " + viewModel.author
            self.date.text = "date: " + viewModel.date
            //TODO:
            
            avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 5
            AlamofireNetworkService.fetchData(url: viewModel.avatarUrl) { (data, error) in
                if data != nil {
                    self.avatarImage.image = UIImage(data: data!)!
                    print("getImage: ok")
                } else if error != nil {
                    print("getImage: error")
                    //TODO:
                }
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
