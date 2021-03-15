//
//  HistoryControllerViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit
import CoreData
class HistoryController: UIViewController {
    // MARK: - properties
    var story = [History]()
    let context  = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    var frame = CGRect()
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadLocalData()
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "HistoryCell")
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
// MARK: -  Table view delegate and data source methods
extension HistoryController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return story.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = story[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumsFromHistoryController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.name = story[indexPath.row].name!
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.story[indexPath.row]
        self.context.delete(item)
        self.story.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath] , with: .fade)
        tableView.reloadData()
        
    }
}
// MARK: - Core data LOAD
extension HistoryController {
    func loadLocalData(with request:NSFetchRequest<History> = History.fetchRequest()) {
        do {
           story =  try context.fetch(request)
        } catch  {
            print("error fetching data from context:\(error)")
            }
        tableView.reloadData()
    }
}
