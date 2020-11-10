//
//  DetailViewController.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var indicatorView: UIView!
    @IBOutlet var fileTextView: UITextView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dataLabel: UILabel!
    
    var viewModel: DetailViewModelType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fileTextView.layer.cornerRadius = 5
        guard let viewModel = viewModel else { return }
        
        
        self.authorLabel.text = LocStr.authorСapital + viewModel.author
        self.dataLabel.text = LocStr.сhanged + viewModel.changed
        self.title = viewModel.firstFileName
        
        activityIndicator.startAnimating()
        getFile()
    }
    
    func stopActivityIndicator() {
        guard !indicatorView.isHidden else { return }
        indicatorView.isHidden = true
        guard activityIndicator.isAnimating else { return }
        activityIndicator.stopAnimating()
    }

    func getFile() { 
        viewModel?.getFileText { (text) in
            print("TEXT")
            DispatchQueue.main.async {
                self.fileTextView.text = text
                self.stopActivityIndicator()
            }
        }
        
    }

}
