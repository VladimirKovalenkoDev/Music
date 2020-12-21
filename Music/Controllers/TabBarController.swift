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
    
    private func setMenuViewControllers() {
        let searchController = SearchController()
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag:  0)

        let historyController = HistoryControllerViewController()
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
