//
//  TableViewController.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tableViewModel: TableViewViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: tableViewModel.cellNib, bundle: nil)
        let identifier = tableViewModel.cellIdentifier
        tableView.register(nib, forCellReuseIdentifier: identifier)
        fetchAndDecodable()
    }
    
    func fetchAndDecodable() {
        tableViewModel.getGists {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel?.numberOfRows ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewModel = tableViewModel,
              let gistListcell = tableView.dequeueReusableCell(withIdentifier: tableViewModel.cellIdentifier, for: indexPath) as? GistListCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = tableViewModel.cellViewModel(forIndexPath: indexPath)
        gistListcell.cellViewModel = cellViewModel
        return gistListcell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewModel = tableViewModel else { return }
        tableViewModel.selectRow(atIndexPath: indexPath)
        presentGistController()
    }
    
    private func presentGistController() {
        let storyboard: UIStoryboard = UIStoryboard(name: tableViewModel.detailVCStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: tableViewModel.detailVCControllerId) as? DetailViewController else { return }
        vc.viewModel = tableViewModel.viewModelForSelectedRow()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
