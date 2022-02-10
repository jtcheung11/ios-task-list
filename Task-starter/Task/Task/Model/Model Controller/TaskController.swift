//
//  TaskController.swift
//  Task
//
//  Created by Jonmichael Cheung on 2/10/22.
//

import Foundation

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(name:name, notes:notes, dueDate: dueDate)
        tasks.append(newTask)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        saveToPersistentStore()
        
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        saveToPersistentStore()
    }
    
    func delete(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
        saveToPersistentStore()
    }
    
    func createPersistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Task.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do{
            let data = try jsonEncoder.encode(tasks)
            try data.write(to: createPersistentStore())
        }catch {
            print("\(error.localizedDescription)")
        }
        
        func loadFromPersistentStore() {
            let jsonDecoder = JSONDecoder()
            
            do {
                let data = try Data(contentsOf: createPersistentStore())
                tasks = try jsonDecoder.decode([Task].self, from: data)
            }catch {
                print("\(error) >> \(error.localizedDescription)")
            }
        }
    }
}//End of class
