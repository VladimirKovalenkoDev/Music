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
    #warning("make universal")
    func loadLocalData() ->[History]{
        let request: NSFetchRequest<History> = History.fetchRequest()
        do {
            let history = try context.fetch(request)
                history.forEach { story in
                guard
                    let title = story.name
                else {
                    fatalError("This was not supposed to happen")
                }
                print(title)
            }
            return history
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
}
