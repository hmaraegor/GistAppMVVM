//
//  TableViewController.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import UIKit

class TableViewController: UITableViewController {
        //TODO: !!!!!
    private var gistViewModel: TableViewViewModelType!
    //TODO:
//    private var gistUpdateService = GistUpdateService()
    private var gistService = GistNetworkService()
//    private var gistDeleteService = GistDeleteService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gistViewModel = GistViewModel()
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //fetchGistList()
        fetchAndDecodable()
    }
    
    func fetchAndDecodable() {
        gistViewModel.getGistsViaAFDecodable {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("done")
            }
        }
    }
    
    func fetchGistList() {
        gistViewModel.getGistsViaAlamofire {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("done")
            }
        }
    }
    
    func fetchGistListViaAlamofire() {
        AlamofireNetworkService.fetchRequestV1(url: "https://api.github.com/gists")
    }
    
    func fetchGistListViaNetworkService() {
        gistViewModel.getGistsViaNetworkService {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //TODO:
    private func fetchGistListDirectlyNetworkService() {
        gistService.getGists() { (array, error) in
            if array != nil {
                self.gistViewModel?.gistArray = array!
            }
            else if error != nil {
                DispatchQueue.main.async {
                    //TODO:
                    //ErrorAlertService.showErrorAlert(error: error as! NetworkServiceError, viewController: self)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Present methods
    
    //TODO:
//    private func presentGistController(with gist: Gist) {
//
//        let storyboard: UIStoryboard = UIStoryboard(name: "Gist", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "GistVC")
//        (vc as? GistViewController)?.gist = gist
//        navigationController?.pushViewController(vc, animated: true)
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gistViewModel?.numberOfRows ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let gistListcell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GistListCell,
              let gistViewModel = gistViewModel else {
            return UITableViewCell()
        }
        
        let cellViewModel = gistViewModel.cellViewModel(forIndexPath: indexPath)
        
        gistListcell.cellViewModel = cellViewModel
        
        return gistListcell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO:
        //presentGistController(with: gistArray[indexPath.row])
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
