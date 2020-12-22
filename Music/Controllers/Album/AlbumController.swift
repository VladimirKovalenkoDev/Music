//
//  AlbumController.swift
//  Music
//
//  Created by Владимир Коваленко on 22.12.2020.
//

import UIKit

class AlbumController: UIViewController {

    let tableView = UITableView()
    lazy var navigation: UIView =  {
        let view = UIView()
        return view
    }()
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action:  #selector(goBackPressed), for: .touchUpInside)
        return button
    }()
    
    var name = ""
    var album = ""
    var coverUrl = ""
    var copyright = ""
    var results = [SearchItems]()
    var searchManager = SearchManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchManager.delegate = self
        setView()
        setUpNavView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
       tableView.register(AlbumCell.self, forCellReuseIdentifier: AlbumCell.reuseIdentifier)
       tableView.register(CoverCell.self, forCellReuseIdentifier: CoverCell.reuseIdentifier)
       tableView.register(CopyrightCell.self, forCellReuseIdentifier: CopyrightCell.reuseIdentifier)
    }
    func setView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        searchManager.showMusic(name: name, album: album)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.right.equalToSuperview()
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
}

extension AlbumController: UITableViewDataSource,
                           UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return results.count
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CoverCell.reuseIdentifier,
                                                        for: indexPath) as! CoverCell
             cell.albumName.text = album
             cell.artistName.text = name
             let artworkSting100 = coverUrl
             let artworkSting600 = artworkSting100.replacingOccurrences(of: "100x100", with: "600x600")
             if let imageURL = URL(string: artworkSting600) {
                       DispatchQueue.global(qos: .userInitiated).async {
                           let contextOfUrl = try? Data(contentsOf: imageURL)
                           DispatchQueue.main.async {
                               if let imageData = contextOfUrl{
                                   cell.cover.image = UIImage(data: imageData)
                               }
                           }
                       }
                   }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier,
                                                     for: indexPath)
            cell.textLabel?.text = results[indexPath.row].trackName
               return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CopyrightCell.reuseIdentifier,
                                                     for: indexPath)
            cell.textLabel?.text = copyright
            cell.textLabel?.textColor = .lightGray
            return cell
        }
          
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 270
        } else {
            return 50
        }
    }
}
extension AlbumController:  SearchManagerDelegate{
    func didSearch(_ searchManager: SearchManager, searchItems: Results) {
        DispatchQueue.main.async {
            self.results = searchItems.results
            print(self.results)
            self.tableView.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
