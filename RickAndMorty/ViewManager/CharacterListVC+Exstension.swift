import Foundation
import UIKit

extension CharacterCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterGridCell", for: indexPath) as? CharacterGridCell,
            let character = dataProvider?.character(at: indexPath.row)
        else {
            return UICollectionViewCell() }
        cell.configure(with: character)
        return cell
    }
}

extension CharacterCollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = dataProvider?.character(at: indexPath.row) else { return }
        actionDelegate?.didSelectCharacter(character)
    }
}

extension CharacterCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return actionDelegate?.cellSize(for: collectionView) ?? CGSize(width: 100, height: 150)
    }
}
