//
//  TaskDetailViewController.swift
//  Task
//
//  Created by Jonmichael Cheung on 2/9/22.
//

import UIKit




class TaskDetailViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatPicker: UIDatePicker!
    
    
    //Landingpad
    var task: Task?
    var date: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

//Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: taskNotesTextView.text, dueDate: date)
        }else{
            TaskController.shared.createTaskWith(name: name, notes: taskNotesTextView.text, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatPicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatPicker.date = task.dueDate ?? Date()
        self.date = task.dueDate
    }

}
