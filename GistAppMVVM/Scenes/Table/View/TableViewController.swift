//
//  TableViewController.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var gistViewModel: TableViewViewModelType!
    
    
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
            }
        }
    }
    
    func fetchGistList() {
        gistViewModel.getGistsViaAlamofire {
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
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO:
        guard let gistViewModel = gistViewModel else { return }
        gistViewModel.selectRow(atIndexPath: indexPath)
        
        presentGistController()
    }
    
    private func presentGistController() {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC")
        (vc as? DetailViewController)?.viewModel = gistViewModel.viewModelForSelectedRow()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
