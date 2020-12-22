//
//  HistoryControllerViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit
import CoreData
class HistoryController: UIViewController {
    var story = [History]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frame = CGRect()
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseIdentifier)
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadLocalData()
    }
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
extension HistoryController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return story.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseIdentifier, for: indexPath) as! HistoryCell
        cell.textLabel?.text = story[indexPath.row].name
        return cell
    }
}
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
