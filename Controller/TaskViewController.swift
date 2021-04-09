//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Akdag's Pro on 8.04.2021.
//

import UIKit

class TaskViewController: UIViewController {
  
    @IBOutlet weak var textLabel: UILabel!
    var task : String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)

        textLabel.text = task
    }
    
    
}
