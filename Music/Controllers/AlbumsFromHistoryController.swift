//
//  AlbumsFromHistoryControllerViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 23.12.2020.
//

import UIKit

class AlbumsFromHistoryController: UIViewController,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    // MARK: - properties and collection view
    var collectionView: UICollectionView!
    var results = [SearchItems]()
    var searchManager = SearchManager()
    var frame = CGRect()
    var layout = UICollectionViewFlowLayout()
    var name = ""
    // MARK: - UI elements declaration
    lazy var navigation: UIView =  {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9354471564, green: 0.9298860431, blue: 0.9397215843, alpha: 1)
        return view
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action:  #selector(goBackPressed), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager.delegate = self
        configureCollectionView()
        setUpNavView()
        
        searchManager.makeSearch(name:name)
        view.backgroundColor = .white
    }
    // MARK: - setting up views methods,put constraints to the elements
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
            make.top.equalToSuperview().offset(88)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            
        }
    }
    func setUpNavView(){
        view.addSubview(navigation)
        self.navigation.addSubview(backButton)
        navigation.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(88)
        }
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(navigation).offset(55.57)
            make.left.equalTo(navigation).offset(10)
        }
    }
    @objc func goBackPressed(_ sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    // MARK: - collection view methods
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchListCell.id,
                for: indexPath) as? SearchListCell else { return UICollectionViewCell() }
        cell.setCell()
        let sortetdResults = results.sorted(by: { $0.collectionName! < $1.collectionName! })
        switch sortetdResults[indexPath.row].contentAdvisoryRating {
        case "Clean":
            cell.advisoryRating.text = sortetdResults[indexPath.row].contentAdvisoryRating
        case "Explicit":
            cell.advisoryRating.text = sortetdResults[indexPath.row].contentAdvisoryRating
        default:
            cell.advisoryRating.text = ""
        }
        cell.artistName.text = sortetdResults[indexPath.row].artistName
        cell.albumName.text = sortetdResults[indexPath.row].collectionName
        let artworkSting100 = sortetdResults[indexPath.row].artworkUrl100
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
        let sortetdResults = results.sorted(by: { $0.collectionName! < $1.collectionName! })
        let name = sortetdResults[indexPath.row].artistName
        let album = sortetdResults[indexPath.row].collectionName
        let coverUrl = sortetdResults[indexPath.row].artworkUrl100
        let copyright = sortetdResults[indexPath.row].copyright
        let collectionId = sortetdResults[indexPath.row].collectionId
        let vc = AlbumController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.album = album!
        vc.name = name!
        vc.coverUrl = coverUrl!
        vc.copyright = copyright!
        vc.id = collectionId!
        if let contentRaiting = sortetdResults[indexPath.row].contentAdvisoryRating {
            vc.contentRaiting = contentRaiting
        }
        present(vc, animated: true)
    }
}
// MARK: -  Networking
extension AlbumsFromHistoryController: SearchManagerDelegate {
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
