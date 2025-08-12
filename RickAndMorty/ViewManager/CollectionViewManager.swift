import UIKit

protocol CharacterCollectionViewDataProvider: AnyObject{
    var characters: [Character] {get}
    func numberOfItems() -> Int
    func character(at index: Int) -> Character
}

protocol CharacterCollectionViewActionDelegate: AnyObject{
    func didSelectCharacter(_ character: Character)
    func cellSize(for collectionView: UICollectionView) -> CGSize
}

class CharacterCollectionViewManager: NSObject {
    
    weak var dataProvider: CharacterCollectionViewDataProvider?
    weak var actionDelegate: CharacterCollectionViewActionDelegate?
    
    init(dataProvider: CharacterCollectionViewDataProvider, actionDelegate: CharacterCollectionViewActionDelegate) {
        self.dataProvider = dataProvider
        self.actionDelegate = actionDelegate
        super.init()
    }
}

