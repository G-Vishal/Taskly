//
//  TaskStore.swift
//  Taskly
//
//  Created by Vishal Shelake on 27/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import Foundation

// MARK: - Task Store
class TaskStore{
    
    var tasks = [[Task](), [Task]()]
    
    // add task
    func add(_ task: Task, at index: Int, isDone:Bool = false){
        
        let section = isDone ? 1 : 0
        
        tasks[section].insert(task, at: index)
        
    }
    
    // remove task
    @discardableResult func removeTask(at index: Int, isDone : Bool = false) -> Task {
        let section = isDone ? 1 : 0
        
        return tasks[section].remove(at: index)
        
        
    }
    
    
}
