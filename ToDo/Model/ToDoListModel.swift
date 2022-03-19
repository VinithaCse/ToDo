//
//  ToDoListModel.swift
//  ToDo
//
//  Created by Vinitha Rao A on 15/03/22.
//

import Foundation

class ToDoListModel: NSObject {
    
    var toDoList: [ToDoModel] = []
    var totalRecords: Int = 0
    
    override init() {
        super.init()
    }
    
    init(withJSON toDoListDict: Dictionary<String,Any>) {
        super.init()
        
        self.extractList(listDict: toDoListDict)
    }
    
    private func extractList(listDict: Dictionary<String, Any>) {
        
        self.totalRecords = listDict["total_records"] as? Int ?? 0
        
        if let listDataDict = listDict["data"] as? [Dictionary<String,Any>] {
            
            for todoDict in listDataDict {
                let toDoModel = ToDoModel(withJSON: todoDict)
                self.toDoList.append(toDoModel)
            }
        }
    }

}
