//
//  ViewController.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import UIKit

final class CharactersViewController: BaseViewController {

    weak var viewModel: CharactersViewModelDelegate!
    
    // MARK: UI elements
    
    private lazy var tableFooterView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .medium)
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = tableFooterView
        tableView.rowHeight = 80
        tableView.register(CharacterItemCell.self, forCellReuseIdentifier: CharacterItemCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setUpLayout()
        binding()
    }
    
    private func binding() {
        navTitle = viewModel.navTitle
        
        viewModel.characters.observe { [weak self] characters in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
        
        viewModel.showFooterLoader.observe { [weak self] showLoader in
            guard let `self` = self else { return }
            if showLoader {
                self.tableFooterView.startAnimating()
            } else {
                self.tableFooterView.stopAnimating()
            }
        }
    }
    
    // MARK: Layout
    
    private func setUpLayout() {
        navBarTitleLarge = true
        addTableView()
    }

    private func addTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterItemCell.reuseIdentifier, for: indexPath) as? CharacterItemCell else {
            return UITableViewCell()
        }
        
        if let character = viewModel.characters.value?[indexPath.row] {
            cell.configure(with: character)
        }
        
        if let charactersCount = viewModel.characters.value?.count, indexPath.row == charactersCount - 1 {
            viewModel.loadMoreCharacters()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
