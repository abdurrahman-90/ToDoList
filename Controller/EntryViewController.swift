//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Akdag's Pro on 8.04.2021.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field: UITextField!
    
    var upDate : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text , !text.isEmpty else {
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount , forKey: "count")
        UserDefaults().setValue(text, forKey: "task_\(newCount)")
        upDate?()
        navigationController?.popViewController(animated: true)
    }


}
