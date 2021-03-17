//
//  BaseCollectionController.swift
//  Music
//
//  Created by Владимир Коваленко on 13.03.2021.
//

import UIKit
import Kingfisher
class BaseCollectionController: UIViewController {
    public var collectionView: UICollectionView!
    private var frame = CGRect()
    private var layout = UICollectionViewFlowLayout()
    public var results = [SearchItems]()
    public var searchManager = SearchManager()
    public let spinner = UIActivityIndicatorView(style: .medium)
    public lazy var navigation: UIView =  {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9354471564, green: 0.9298860431, blue: 0.9397215843, alpha: 1)
        return view
    }()
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action:  #selector(goBackPressed), for: .touchUpInside)
        return button
    }()
    public lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search Artist"
        bar.barStyle = .default
        bar.sizeToFit()
        return bar
    }()
    private lazy var loading: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .lightGray
        label.font = UIFont(name: "Roboto", size: 25)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager.delegate = self
        configureCollectionView()
        setUpNavView()
        setUpSearchBar()
        setUpLoadingView()
        view.backgroundColor = .white
    }
    // MARK: - setting up views methods,put constraints to the elements
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SearchListCell.self,
                                forCellWithReuseIdentifier: SearchListCell.id)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(158)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    private func setUpLoadingView(){
        view.addSubview(spinner)
        view.addSubview(loading)
        spinner.startAnimating()
        spinner.center = view.center
        loading.snp.makeConstraints { (make) in
            make.top.equalTo(spinner.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
    }
    private func setUpSearchBar() {
         view.addSubview(searchBar)
         searchBar.snp.makeConstraints { (make) in
             make.top.equalToSuperview().offset(88)
             make.left.equalToSuperview()
             make.right.equalToSuperview()
             make.height.equalTo(70)
         }
     }
    private func setUpNavView(){
        view.addSubview(navigation)
        navigation.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(88)
        }
    }
    @objc func goBackPressed(_ sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
}
// MARK: - collection view methods
extension BaseCollectionController: UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchListCell.id,
                for: indexPath) as? SearchListCell else { return UICollectionViewCell() }
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
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageURL = URL(string: artworkSting600!) {
                DispatchQueue.main.async {
                    cell.albumImage.kf.setImage(with: imageURL)
                }
            }
}
        return cell
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
extension BaseCollectionController: SearchManagerDelegate {
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
