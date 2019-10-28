//
//  TaskUtility.swift
//  Taskly
//
//  Created by Vishal Shelake on 27/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import Foundation


class TaskUtility {
    
    private static let key = "Keys"
    
//    //archive //for older Version of Swift
//    private static func archive(_ tasks: [[Task]]) -> NSData {
//        return NSKeyedArchiver.archivedData(withRootObject: tasks) as NSData
//    }

    // archive
    private static func archive(_ tasks: [[Task]]) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
    }

    
//    //featch //for older version of swift
//    static func featch() -> [[Task]]? {
//        guard let unarchiveData = UserDefaults.standard.object(forKey: "tasks") as? Data else { return nil}
//
//        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as? [[Task]]
//    }

    // fetch
    static func fetch() -> [[Task]]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedData) as? [[Task]] ?? [[]]
    }

    
    //save
    static func save(_ tasks: [[Task]]){
        //archive
        let archiveTasks = archive(tasks)
        //set object for key
        UserDefaults.standard.set(archiveTasks, forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    
}
