//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Jorge Martínez on 28/6/22.
//

import Foundation

protocol CharactersViewModelInput: AnyObject {
    func viewDidLoad()
    func loadMoreCharacters()
    func didSelectItem(at index: Int)
}

protocol CharactersViewModelOutput: AnyObject {
    var characters: Observable<[Character]?> { get }
    var showFooterLoader: Observable<Bool> { get }
    var navTitle: String { get }
}

protocol CharactersViewModelDelegate: CharactersViewModelInput, CharactersViewModelOutput {}

final class CharactersViewModel: BaseViewModel, CharactersViewModelDelegate {
    
    private weak var coordinatorDelegate: CharactersCoordinatorDelegate?
    private weak var dataSourceDelegate: CharactersDataSourceDelegate?
    
    private var offset: Int = 0
    private var limit: Int = 0
    private var totalCharacters: Int = 0
    
    // MARK: Output
    
    var characters: Observable<[Character]?> = Observable([])
    var showFooterLoader: Observable<Bool> = Observable(false)
    var navTitle: String = "Marvel"
    
    // MARK: Init
    
    init(coordinatorDelegate: CharactersCoordinatorDelegate?,
         dataSourceDelegate: CharactersDataSourceDelegate?,
         visualResponseDelegate: VisualResponseProtocol?) {
        super.init(visualResponseDelegate: visualResponseDelegate)
        self.coordinatorDelegate = coordinatorDelegate
        self.dataSourceDelegate = dataSourceDelegate
    }
}

// MARK: Input - View event methods

extension CharactersViewModel {
    
    func viewDidLoad() {
        getCharacters(showLoader: true, offset: offset)
    }
    
    func loadMoreCharacters() {
        guard offset + limit < totalCharacters - 1 else { return }
        showFooterLoader.value = true
        getCharacters(showLoader: false, offset: offset + limit)
    }
    
    func didSelectItem(at index: Int) {
        coordinatorDelegate?.pushToCharactersDetail(character: characters.value?[index])
    }
    
    private func getCharacters(showLoader: Bool, offset: Int) {
        dataSourceDelegate?.getCharacters(delegate: showLoader ? self : nil, offset: offset, success: { [weak self] response in
            guard let `self` = self, let results = response.data?.results else { return }
            self.offset = response.data?.offset ?? 0
            self.limit = response.data?.limit ?? 0
            self.totalCharacters = response.data?.total ?? 0
            self.characters.value?.append(contentsOf: results)
            self.showFooterLoader.value = false
        }, failure: { [weak self] _ in
            guard let `self` = self else { return }
            self.characters.value?.append(contentsOf: [])
            self.showFooterLoader.value = false
        })
    }
}
