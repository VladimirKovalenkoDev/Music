//
//  AlbumsFromHistoryControllerViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 23.12.2020.
//

import UIKit

class AlbumsFromHistoryController: BaseCollectionController{
    // MARK: - properties
    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavView()
        remakeView()
        searchManager.makeSearch(name:name)
    }
    // MARK: - setting up view
   private func setUpNavView(){
        self.navigation.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(navigation).offset(55.57)
            make.left.equalTo(navigation).offset(10)
        }
    }
    private func remakeView(){
        searchBar.removeFromSuperview()
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
}

