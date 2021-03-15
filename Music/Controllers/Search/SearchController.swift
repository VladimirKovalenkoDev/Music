//
//  ViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import UIKit
import SnapKit
import CoreData
class SearchController: BaseCollectionController{
    // MARK: - properties
    var history = [History]()
    let core = Core()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frame = CGRect()
    var displayWidth = CGFloat()
    var displayHeight = CGFloat()
    var layout = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        view.backgroundColor = .white
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    @objc func dismissView(gesture: UISwipeGestureRecognizer) {
        searchBar.endEditing(true)
    }
}
// MARK: - search bar delegate methods
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchManager.makeSearch(name: searchBar.text!)
        searchBar.endEditing(true)
        let newName = History(context: self.context)
        newName.name = searchBar.text!
        history.append(newName)
        core.saveData()
      }
}
