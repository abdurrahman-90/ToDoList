//
//  ViewController.swift
//  ToDoList
//
//  Created by Akdag's Pro on 8.04.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableVİew: UITableView!
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(didTapButton))
        upDateTasks()
    
    }
    func upDateTasks(){
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
                DispatchQueue.main.async { [self] in
                    tableVİew.reloadData()
                }
            }
        }
        
    }
    @objc func didTapButton(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        
        vc.title = "New Task"
        
        vc.upDate = {
            DispatchQueue.main.async {
                self.upDateTasks()
            }
        }
       
        navigationController?.pushViewController(vc, animated: true)
       
        //Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true , forKey: "setup")
            UserDefaults().set(0 , forKey: "count")
        }
        
    }
   


}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "Tasks Detail"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
       
    }
    
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}

