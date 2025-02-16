//
//  AlbumController.swift
//  Music
//
//  Created by Владимир Коваленко on 22.12.2020.
//

import UIKit

class AlbumController: BaseController {
// MARK: - UI elements declaration
    private let tableView = UITableView()
    // MARK: - properties
    public var name = ""
    public var album = ""
    public var coverUrl = ""
    public var copyright = ""
    public var contentRaiting = ""
    public var id = 0
    private var results = [SearchItems]()
    private var searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchManager.delegate = self
        setView()
        setUpNavView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchManager.showMusic(collectionId: self.id)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - setting up views methods,put constraints to the elements
    private func setView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        //register cells
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AlbumCell")
       tableView.register(CoverCell.self, forCellReuseIdentifier: CoverCell.reuseIdentifier)
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CopyrightCell")
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
   private func setUpNavView(){
        navigation.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(navigation).offset(55.57)
            make.left.equalTo(navigation).offset(10)
        }
    }
}
// MARK: - Table view delegate and data source methods
extension AlbumController: UITableViewDataSource,
                           UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int { //make 3 sections because we have 3 different cells whith differernt information
        return 3
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {// here we says how many rows need every section
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
        if indexPath.section == 0 { // CoverCell must be the 1st
            let cell = tableView.dequeueReusableCell(withIdentifier: CoverCell.reuseIdentifier,
                                                        for: indexPath) as! CoverCell
             cell.albumName.text = album
             cell.artistName.text = name
             cell.advisoryRating.text = contentRaiting
             let artworkSting100 = coverUrl
             let artworkSting600 = artworkSting100.replacingOccurrences(of: "100x100", with: "600x600")
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageURL = URL(string: artworkSting600) {
                DispatchQueue.main.async {
                    cell.cover.kf.setImage(with: imageURL)
                }
            }
}
            return cell
        }else if indexPath.section == 1 { //AlbumCell must be after
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell",
                                                     for: indexPath)
            cell.textLabel?.text = results[indexPath.row].trackName
               return cell
        } else { //CopyrightCell must be the last
            let cell = tableView.dequeueReusableCell(withIdentifier: "CopyrightCell",
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
// MARK: - Network
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
