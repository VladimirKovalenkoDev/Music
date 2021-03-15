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
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveData(){
        if context.hasChanges {
            do {
                try context.save()
                } catch {
                    print("error saving context: \(error)")
            }
        }
    }

}
