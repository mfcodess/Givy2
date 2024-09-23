//
//  SearchVCViewController.swift
//  Givy
//
//  Created by Max on 17.08.2024.
//

import UIKit

class SearchVCViewController: UIViewController {
    
    let pens = ["AL-Star Aquatic", "Special Safari Nexx Fountain", "Studio Dark", "AL-Star Turmaline", "Balloon 2.0", "Scala dark", "Xevo"]
    
    var isSearching = false
    var filterPens: [String] = []
    
    private lazy var searchBar: UISearchController = {
        let searchBar = UISearchController()
    
        searchBar.searchResultsUpdater = self
        //searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.placeholder = "Search"
        searchBar.searchBar.searchTextField.backgroundColor = .colorButtonIsActive
        
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Search Pen"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let apperance = UINavigationBarAppearance()
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = apperance
        
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(tableView)
        createTableViewConstrains()
    }
    
    private func createTableViewConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SearchVCViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text ?? ""
        
        filterPens = pens.filter { pen in
            pen.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
        
        if searchController.searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filterPens = pens.filter { pen in
                let searchText = searchController.searchBar.text ?? ""
                
                return pen.contains(searchText)
            }
            tableView.reloadData()
        }
    }
}

extension SearchVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterPens.count
        } else {
            return pens.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        
        if isSearching {
            cell.textLabel?.text = filterPens[indexPath.row]
        } else {
            cell.textLabel?.text = pens[indexPath.row]
        }
        
        return cell
    }
    
    
}

extension SearchVCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPen: String
        
        if isSearching {
            selectedPen = filterPens[indexPath.row]
        } else {
            selectedPen = pens[indexPath.row]
        }
        
        switch selectedPen {
        case "AL-Star Aquatic":
            let vc = BluePen()
            navigationController?.pushViewController(vc, animated: true)
        case "Special Safari Nexx Fountain":
            let vc = PerplePen()
            navigationController?.present(vc, animated: true)
        default:
            break
        }
        return tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    SearchVCViewController()
}
