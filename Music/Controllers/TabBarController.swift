//
//  TabBarController.swift
//  Music
//
//  Created by Владимир Коваленко on 21.12.2020.
//

import UIKit
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabBar()
        setMenuViewControllers()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - making tab bar items
    // get pictures from sfsymbols
    private func setMenuViewControllers() {
        let searchController =  UINavigationController(rootViewController: SearchController())
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag:  0)

        let historyController = UINavigationController(rootViewController: HistoryController())
        historyController.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "archivebox"), tag:  1)
    
        let tabBarList = [searchController, historyController]
        viewControllers = tabBarList
    }
    private func addTabBar(){
        self.delegate = self
        tabBar.backgroundColor = .white
    }

}
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return true
        }
}
