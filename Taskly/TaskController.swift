//
//  TaskController.swift
//  Taskly
//
//  Created by Vishal Shelake on 26/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import UIKit

class TaskController : UITableViewController{
     
}


// MARK: - DataSource

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 100
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = "Main Text"
    
    return cell
    
}

