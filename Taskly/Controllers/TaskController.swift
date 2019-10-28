//
//  TaskController.swift
//  Taskly
//
//  Created by Vishal Shelake on 26/10/19.
//  Copyright © 2019 Vishal Shelake. All rights reserved.
//

import UIKit

class TaskController : UITableViewController{
    
    var taskStore : TaskStore! {
        didSet{
            //get the data
            taskStore.tasks = TaskUtility.fetch() ?? [[Task](),[Task]()]
            
            //reload the table
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        print("add task tapped")
        
        //setting up our alert controller
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        // set up the action
        let addAction = UIAlertAction(title: "Add", style: .default){ _ in
            
            // grabText field Text
            guard let name = alertController.textFields?.first?.text else { return }
            
            // create task
            let newTask = Task(name: name, isDone: false)
            
            //add task
            self.taskStore.add(newTask, at: 0)
            
            //reload table view
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
//            //save
//            TaskUtility.save(self.taskStore.tasks)
        }
        
        addAction.isEnabled = false
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        //add the text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task Name.."
            textField.addTarget(self, action: #selector(self.handleTextchange), for: .editingChanged)
            
        }
        
        // add the action
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        //present
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func handleTextchange(_ sender: UITextField){
        guard   let alertController = presentedViewController as? UIAlertController,
                let addAction = alertController.actions.first,
            let text = sender.text
        else {return}
        
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty // here the ! symbol is invert the whole functionality to inverse
    }
     
}

// MARK: - DataSource

extension TaskController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "To-Do"
//        } else {
//            return "Done"
//        }
        
        //turnary Oprator  which made life more easier and remove all the above if else code
        return section == 0 ? "To-Do" : "Done"
    }
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return taskStore.tasks[section].count
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    cell.textLabel?.text = taskStore.tasks[indexPath.section][indexPath.row].name
    
    return cell
    
    }
    
}


// MARK: - Delegate
extension TaskController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler) in
           
            // determine the task is isDone
            guard let isDone = self.taskStore.tasks[indexPath.section][indexPath.row].isDone else {return}
            
            //remove the task from approp array
            self.taskStore.removeTask(at: indexPath.row, isDone: isDone)
            
            //reload the tableview
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
//            //save
//            TaskUtility.save(self.taskStore.tasks)
            
            
            //indicate that the action ios performed
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor =  UIColor.red  //UIColor(red: 0.5, green: 0.2, blue: 0.1, alpha: 1)
        
        
       return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            
            //toggle that the task is done
            self.taskStore.tasks[0][indexPath.row].isDone = true
            
            
            //reload the table section
            let doneTask = self.taskStore.removeTask(at: indexPath.row)
            
            // remove the task from the array containinig todo tasks
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // add the task to the array containinig todo tasks
            self.taskStore.add(doneTask, at: 0 , isDone: true)
            
            // reload tableview
            tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
            
//            //save
//            TaskUtility.save(self.taskStore.tasks)
//
            
            //indicate the action was performed
            completionHandler(true)
        }
        
        doneAction.image = UIImage(named: "done")
        doneAction.backgroundColor = UIColor.blue
        
        
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
    }
    
    
}
