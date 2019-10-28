//
//  Task.swift
//  Taskly
//
//  Created by Vishal Shelake on 26/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import Foundation


class Task : NSObject, NSCoding {

    
    var name : String?
    var isDone : Bool?
    
    private let nameKey = "name"
    private let isDoneKey = "isDone"
    
    init(name: String, isDone : Bool){    // here is the byDefault init to false to set task bydefault as a unDone or added to Todo List
        self.name = name
        self.isDone = isDone
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(isDone, forKey: isDoneKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
                let isDone = aDecoder.decodeObject(forKey: isDoneKey) as? Bool
        else { return }
        
        self.name = name
        self.isDone = isDone
    }
    
    
}



