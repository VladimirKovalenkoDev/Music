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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchManager.makeSearch(name: "Anacondaz")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager.delegate = self
        confureLayout()
        configureCollectionView()
        view.backgroundColor = .white
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        (collectionView.collectionViewLayout
//            as? UICollectionViewFlowLayout)?
//            .footerReferenceSize
//            = CGSize(width: view.bounds.width,
//                     height: view.bounds.height)
//    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .orange
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.register(SearchListCell.self, forCellWithReuseIdentifier: SearchListCell.id)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(UIEdgeInsets(top: 367, left: 0, bottom: 0, right: 0))
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            
        }
    }
    func confureLayout() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
    }
}

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
        let artworkSting600 = artworkSting100.replacingOccurrences(of: "100x100", with: "600x600")
        if let imageURL = URL(string: artworkSting600 ) {
        //cell.spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contextOfUrl = try? Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    if let imageData = contextOfUrl{
                        cell.albumImage.image = UIImage(data: imageData)
                    }
//                    cell.spinner.stopAnimating()
//                    cell.spinner.hidesWhenStopped = true
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
  
//    private func collectionView(collectionView: UICollectionView,
//                                layout collectionViewLayout: UICollectionViewLayout,
//                                insetForSectionAtIndex section: Int) -> UIEdgeInsets  {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }

}
