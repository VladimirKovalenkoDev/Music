//
//  Request.swift
//  Music
//
//  Created by Владимир Коваленко on 20.12.2020.
//

import Foundation
protocol SearchManagerDelegate {
    func didSearch(_ searchManager : SearchManager, searchItems: Results)
    func didFailWithError (error: Error )
}

struct SearchManager  {
    var delegate : SearchManagerDelegate?
    func makeSearch(name: String){
        let urlString = "https://itunes.apple.com/search?term=\(name)&entity=album"
        performRequest(with: urlString)
        print(urlString)
    }
    func performRequest(with urlString: String){
        // create url
        if let url = URL(string: urlString) {// it is optional cos it can be an error
          // create url session
            let session = URLSession(configuration: .default)
            // GIVE THE session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                         return
                     }
                     if let safeData = data {
                        if  let searchItems = self.parseJSON(safeData){
                            
                            
                           self.delegate?.didSearch(self , searchItems: searchItems)
                            
                        }
                     }
                 }
            // start the task
            task.resume()
            }

        }
    func parseJSON(_ searchData: Data) -> Results? {
        let decoder = JSONDecoder()
        do {
            
      let decodeData = try decoder.decode(Results.self, from: searchData)
            let results = decodeData.results
//            let artist = decodeData.results[0].artistName
//            let collectionName = decodeData.results[1].collectionName
//            let artwork = decodeData.results[2].artworkUrl100
            let searchItems  = Results(results: results)
            return searchItems
        }catch{
           delegate?.didFailWithError(error: error  )
            return nil
            }
        }
    
    }
    

