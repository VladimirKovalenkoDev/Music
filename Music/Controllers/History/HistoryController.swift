//
//  HistoryControllerViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit
import CoreData
class HistoryController: BaseController {
    // MARK: - properties
    public var story = [History]()
    private var frame = CGRect()
    private let tableView = UITableView()
    private var core = Core()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTableView()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        navName.text = "History"
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "HistoryCell")
    tableView.snp.makeConstraints { (make) in
        make.top.equalToSuperview().offset(88)
        make.left.right.equalToSuperview()
        make.bottom.equalToSuperview()
    }
    
    }
    private func loadData(){
        core.fetchPlaces(name: "History") { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result{
                case .success(let story):
                    self.story = story!
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
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
        DispatchQueue.main.async {
            vc.setUpLoadingView()
        }
        vc.name = story[indexPath.row].name!
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = self.story[indexPath.row]
        self.core.context.delete(item)
        self.story.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath] , with: .fade)
        tableView.reloadData()
    }
}
