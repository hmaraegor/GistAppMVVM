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
            self.files.text = LocStr.files + viewModel.files
            self.author.text = LocStr.author + viewModel.author
            self.date.text = LocStr.date + viewModel.date
            
            avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 5
            viewModel.setImage() { (data) in
                let image = (UIImage(data: data) ?? UIImage())
                self.avatarImage.image = image
            }
        }
    }
}
