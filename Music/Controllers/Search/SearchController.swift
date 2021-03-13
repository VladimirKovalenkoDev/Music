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
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frame = CGRect()
    var displayWidth = CGFloat()
    var displayHeight = CGFloat()
    var layout = UICollectionViewFlowLayout()
    // MARK: - UI elements
    lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search Artist"
        bar.delegate = self
        bar.barStyle = .default
        bar.sizeToFit()
        return bar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        collectionView.keyboardDismissMode = .onDrag
        view.backgroundColor = .white
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    // MARK: - add ui elements methods
   private func setUpSearchBar() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(35)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(70)
        }
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
        saveData()
      }
}
// MARK: - core data SAVE
extension SearchController {
    func saveData(){
        if context.hasChanges {
            do {
                try context.save()
                } catch {
                    print("error saving context: \(error)")
            }
        }
    }
}
