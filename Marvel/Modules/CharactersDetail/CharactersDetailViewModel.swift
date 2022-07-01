//
//  CharactersDetailViewModel.swift
//  Marvel
//
//  Created by Jorge Martínez on 30/6/22.
//

import Foundation

protocol CharactersDetailViewModelInput: AnyObject {
    func viewDidLoad()
    func viewDidDisappear()
}

protocol CharactersDetailViewModelOutput: AnyObject {
    var characterName: String? { get }
    var characterDescription: String? { get }
    var characterImageURL: URL? { get }
}

protocol CharactersDetailViewModelDelegate: CharactersDetailViewModelInput, CharactersDetailViewModelOutput {}

final class CharactersDetailViewModel: BaseViewModel, CharactersDetailViewModelDelegate {
    
    private weak var coordinatorDelegate: CharactersDetailCoordinatorDelegate?
    private var character: Character?
    
    // MARK: Output
    
    var characterName: String?
    var characterDescription: String?
    var characterImageURL: URL?
    
    // MARK: Init
    
    init(coordinatorDelegate: CharactersDetailCoordinatorDelegate?,
         visualResponseDelegate: VisualResponseProtocol?,
         character: Character?) {
        super.init(visualResponseDelegate: visualResponseDelegate)
        self.coordinatorDelegate = coordinatorDelegate
        self.character = character
    }
}

// MARK: Input - View event methods

extension CharactersDetailViewModel {
    
    func viewDidLoad() {
        characterName = character?.name
        characterDescription = character?.description != "" ? character?.description : "Empty description."
        characterImageURL = character?.characterImageURL
    }
    
    func viewDidDisappear() {
        coordinatorDelegate?.didFinish()
    }
}
