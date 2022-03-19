//
//  ToDoViewController.swift
//  ToDo
//
//  Created by Vinitha Rao A on 16/03/22.
//

import UIKit

class ToDoViewController: UIViewController {
    
    var viewModel = ToDoViewModel()
    
    //MARK: - View Related
    private var searchBar = UISearchBar()
    private var tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "TableCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigation()
        
        view.addSubview(tableView)

        let views = ["tableView": tableView]
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(constraints)
        
        self.viewModel.getData() {
            [weak self] isCompleted in
            if isCompleted {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func addNavigation() {
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
       
        let addVC = AddToDoViewController()
        let nav = UINavigationController(rootViewController: addVC)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(nav, animated: true, completion: nil)
    }
}

extension ToDoViewController: UITableViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UITableViewHeaderFooterView()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        headerView.addSubview(searchBar)
        
        let views = ["searchBar": searchBar]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchBar]-|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-[searchBar]-|", options: [], metrics: nil, views: views))
        NSLayoutConstraint.activate(constraints)

        return headerView
    }
}

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataModel.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.viewModel.dataModel.toDoList[indexPath.row]
        let cell = ToDoTableViewCell(style: .default, reuseIdentifier: "TableCell")
        cell.setDataInCellContent(data: data)
        cell.layoutSubviews()
        cell.buttonTappedClosure = {
            if !data.isCompleted {
                self.viewModel.dataModel.toDoList[indexPath.row].isCompleted = true
                self.viewModel.markAsCompleted(data: self.viewModel.dataModel.toDoList[indexPath.row]) {
                    isCompleted in 
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        return cell
    }
    
}

extension ToDoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }

}
