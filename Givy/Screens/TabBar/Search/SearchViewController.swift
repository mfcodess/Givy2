//
//  SearchViewController.swift
//  Givy
//
//  Created by Max on 27.07.2024.
//


import UIKit

class SearchViewController: UIViewController {
    
    let pens = ["AL-Star Aquatic", "Special Safari Nexx Fountain", "Studio Dark", "AL-Star Turmaline", "Balloon 2.0", "Scala dark", "Xevo"]
    
    var isSearching = false
    var filterPen: [String] = []
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .colorGray
        searchBar.searchTextField.textColor = .black
        
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
    
    private lazy var labelNotResult: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var imageSearch: UIImageView = {
        let image = UIImageView()
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 20),
            image.heightAnchor.constraint(equalToConstant: 50),
        ])
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Search Pen"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let apperance = UINavigationBarAppearance()
        apperance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = apperance
        
        view.addSubview(searchBar)
        createSearchBarConstrains()
        
        view.addSubview(tableView)
        createTableViewConstrains()
        
        view.addSubview(imageSearch)
        createImageSearchConstrains()
        
        view.addSubview(labelNotResult)
        createLabelNotResult()
    }
    
    private func createSearchBarConstrains() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    private func createTableViewConstrains() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createLabelNotResult() {
        labelNotResult.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelNotResult.topAnchor.constraint(equalTo: imageSearch.bottomAnchor, constant: 20),
            labelNotResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelNotResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    private func createImageSearchConstrains() {
        imageSearch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSearch.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            imageSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -160),
            imageSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 160),
        ])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        for pen in pens {
            
            if pen.range(of: searchText) != nil {
                print("Search complete")
                filterPen.append(pen)
                tableView.isHidden = true
            } else {
                print("Не найдена Pen")
                tableView.isHidden = false
                
                if let searchText = searchBar.text, !searchText.isEmpty {
                    
                    if filterPen.isEmpty {
                        imageSearch.tintColor = .gray
                        imageSearch.image = UIImage(systemName: "magnifyingglass")
                        labelNotResult.text = "Нет результатов по запросу (\(searchText))"
                    } else {
                        imageSearch.image = UIImage(systemName: "")
                        labelNotResult.text = ""
                    }
                } else  {
                    labelNotResult.text = ""
                    imageSearch.image = UIImage(systemName: "")
                }
            }
        }
        print(filterPen)
        
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filterPen = pens.filter({$0.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if isSearching {
            return filterPen.count
        } else {
            return pens.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        if isSearching {
            cell.textLabel?.text = filterPen[indexPath.row]
        } else {
            cell.textLabel?.text = pens[indexPath.row]
        }
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPen: String

        if isSearching {
            selectedPen = filterPen[indexPath.row]
        } else {
            selectedPen = pens[indexPath.row]
        }
        
        switch selectedPen {
        case "AL-Star Aquatic":
            let vc = BluePen()
            navigationController?.pushViewController(vc, animated: true)
            navigationController?.setNavigationBarHidden(true, animated: true)
            
        case "Special Safari Nexx Fountain":
            let vc = PerplePen()
            navigationController?.present(vc, animated: true)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
