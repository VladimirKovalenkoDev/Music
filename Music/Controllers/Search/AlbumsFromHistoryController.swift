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
        searchManager.makeSearch(name:name)
    }
    // MARK: - setting up view
    func setUpNavView(){
        self.navigation.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(navigation).offset(55.57)
            make.left.equalTo(navigation).offset(10)
        }
    }
}

