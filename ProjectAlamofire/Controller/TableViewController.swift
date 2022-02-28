//
//  ViewController.swift
//  ProjectAlamofire
//
//  Created by MAC on 24.02.2022.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    private var cards = [Card]()
    private var filteredCards = [Card]()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 150
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var  searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search name card..."
        definesPresentationContext = true
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
        fetchData()
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func fetchData() {
        AF.request("https://api.magicthegathering.io/v1/cards").responseDecodable(of: Cards.self) {  (data) in
            switch data.result {
            case .success:
                if let JSON = data.value {
                    guard let cardData = data.value else { return }
                    let cards = cardData.cards
                    self.cards = cards
                    self.tableView.reloadData()
                    print(JSON)
                    let status = data.response?.statusCode
                    print("Status code \(status ?? 404)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredCards.count
        }
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.card = self.cards[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let card = self.cards[indexPath.row]
        let vc = ViewControllerDetail()
        vc.cardItems = card
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredCards = cards.filter({ (card: Card) -> Bool in
            return (card.name.lowercased().contains(searchController.searchBar.text?.lowercased() ?? ""))
        })
        tableView.reloadData()
    }
}
