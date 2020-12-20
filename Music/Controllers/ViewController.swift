//
//  ViewController.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import UIKit

class ViewController: UIViewController {
var searchManager = SearchManager()
    var results = [SearchItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchManager.delegate = self
        searchManager.makeSearch(name: "pixies")
    }


}

extension ViewController:  SearchManagerDelegate{
    func didSearch(_ searchManager: SearchManager, searchItems: Results) {
        DispatchQueue.main.async {
            self.results = searchItems.results
            print(self.results)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
