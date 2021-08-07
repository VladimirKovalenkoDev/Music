//
//  Core.swift
//  Music
//
//  Created by Владимир Коваленко on 15.03.2021.
//

import Foundation
import CoreData
import UIKit
class Core {
    let context  = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    func saveData(){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error saving context: \(error)")
            }
        }
    }
    
    func fetchPlaces(name: String,
                     completion: @escaping (Result<[History]?, Error>) -> Void){
        let all = NSFetchRequest<History>(entityName: name)
        do {
            let fetched = try context.fetch(all)
            completion(.success(fetched))
        } catch {
            completion(.failure(error))
        }
    }
}
