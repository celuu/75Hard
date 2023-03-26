//
//  DataController.swift
//  75Hard
//
//  Created by Jacob Rice on 3/26/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "Main")

  init(){
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load \(error.localizedDescription)")
      }
    }
  }

}

