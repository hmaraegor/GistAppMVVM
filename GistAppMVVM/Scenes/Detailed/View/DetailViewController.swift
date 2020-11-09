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
    
    var viewModel: DetailViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel  else { return }
            
//            viewModel.getFileTextViaAlamofire { (text) in
//                DispatchQueue.main.async {
//                    self.fileTextView.text = text
//                    self.stopActivityIndicator()
//                }
//            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
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
        
        viewModel?.getFileTextViaAlamofire { (text) in
            print("TEXT")
            DispatchQueue.main.async {
                self.fileTextView.text = text
                self.stopActivityIndicator()
            }
        }
        
    }

}
