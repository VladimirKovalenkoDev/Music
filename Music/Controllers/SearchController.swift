//
//  ViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import UIKit
import SnapKit
class SearchController: UIViewController {
var searchManager = SearchManager()
    var results = [SearchItems]()
    var collectionView: UICollectionView!
    var frame = CGRect()
    var displayWidth = CGFloat()
    var displayHeight = CGFloat()
    var layout = UICollectionViewFlowLayout()
    var navBar = UINavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager.delegate = self
        searchManager.makeSearch(name: "pixies")
        configureCollectionView()
        view.backgroundColor = .white
    }
    

    func configureCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIEdgeInsets(top: 367, left: 0, bottom: 0, right: 0))
           // make.width.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            
        }
    }

}

extension SearchController:  SearchManagerDelegate{
    func didSearch(_ searchManager: SearchManager, searchItems: Results) {
        DispatchQueue.main.async {
            self.results = searchItems.results
            print(self.results)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
extension SearchController: UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchListCell.id,
                for: indexPath) as? SearchListCell else { return UICollectionViewCell() }
        //cell.backgroundColor = .black
        cell.setCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
//    private func collectionView(collectionView: UICollectionView,
//                                layout collectionViewLayout: UICollectionViewLayout,
//                                insetForSectionAtIndex section: Int) -> UIEdgeInsets  {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }

}
