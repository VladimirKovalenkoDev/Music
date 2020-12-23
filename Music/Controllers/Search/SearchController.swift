//
//  ViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import UIKit
import SnapKit
import CoreData
class SearchController: UIViewController {
    // MARK: - properties
    var searchManager = SearchManager()
    var results = [SearchItems]()
    var history = [History]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frame = CGRect()
    var displayWidth = CGFloat()
    var displayHeight = CGFloat()
    var layout = UICollectionViewFlowLayout()
    // MARK: - UI elements
    var collectionView: UICollectionView!
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
        searchManager.delegate = self
        configureCollectionView()
        setUpSearchBar()
        collectionView.keyboardDismissMode = .onDrag
        view.backgroundColor = .white
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dismissView(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    // MARK: - add ui elements methods
    func configureCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIEdgeInsets(top: 110, left: 0, bottom: 0, right: 0))
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            
        }
    }
    func setUpSearchBar() {
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
// MARK: - Networking
extension SearchController:  SearchManagerDelegate{
    func didSearch(_ searchManager: SearchManager, searchItems: Results) {
        DispatchQueue.main.async {
            self.results = searchItems.results
            self.collectionView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
// MARK: - collection view layout, delegate, datasource methods
extension SearchController: UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("layout: \(results.count)")
        return self.results.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchListCell.id,
                for: indexPath) as? SearchListCell else { return UICollectionViewCell() }
        cell.setCell()
        cell.artistName.text = results[indexPath.row].artistName
        cell.albumName.text = results[indexPath.row].collectionName
        let artworkSting100 = results[indexPath.row].artworkUrl100
        let artworkSting600 = artworkSting100?.replacingOccurrences(of: "100x100", with: "600x600")
        if let imageURL = URL(string: artworkSting600!) {
            DispatchQueue.global(qos: .userInitiated).async {
                let contextOfUrl = try? Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    if let imageData = contextOfUrl{
                        cell.albumImage.image = UIImage(data: imageData)
                    }
                }
            }
}
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = results[indexPath.row].artistName
        let album = results[indexPath.row].collectionName
        let coverUrl = results[indexPath.row].artworkUrl100
        let copyright = results[indexPath.row].copyright
        let collectionId = results[indexPath.row].collectionId
        let vc = AlbumController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.album = album!
        vc.name = name!
        vc.coverUrl = coverUrl!
        vc.copyright = copyright!
        vc.id = collectionId!
        present(vc, animated: true)
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
