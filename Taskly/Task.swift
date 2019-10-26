//
//  Task.swift
//  Taskly
//
//  Created by Vishal Shelake on 26/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import Foundation


class Task {
    
    var name : String
    var isDone : Bool
    
    
    init(name: String, isDone : Bool){    // here is the byDefault init to false to set task bydefault as a unDone or added to Todo List
        self.name = name
        self.isDone = isDone
    }
    
}



// MARK: - Task Store
class TaskStore{
    
    var tasks = [[Task](), [Task]()]
    
    // add task
    func add(_ task: Task, at index: Int, isDone:Bool = false){
        
    }
    
    // remove task
    
    
    
}
