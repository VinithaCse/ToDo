//
//  ToDoModel.swift
//  ToDo
//
//  Created by Vinitha Rao A on 15/03/22.
//

import Foundation

class ToDoModel: NSObject {
    
    var title: String = ""
    var author: String = ""
    var tag: String = ""
    var isCompleted: Bool = false
    var priority: String = ""
    var id: Int = 0
    
    var jsonValue: [String: Any] {
        var json: [String: Any] = [:]
        json["title"] = title
        json["author"] = author
        json["tag"] = tag
        json["is_completed"] = isCompleted
        json["priority"] = priority
        json["id"] = id
        return json
    }
    
    override init() {
        super.init()
    }
    
    init(withJSON toDoDict: [String: Any]) {
        
        super.init()
        self.extractDetail(detailDict: toDoDict)
    }
    
    private func extractDetail(detailDict: Dictionary<String, Any>) {
        
        self.title = detailDict["title"] as? String ?? ""
        self.author = detailDict["author"] as? String ?? ""
        self.tag = detailDict["tag"] as? String ?? ""
        self.isCompleted = detailDict["is_completed"] as? Bool ?? false
        self.priority = detailDict["priority"] as? String ?? ""
        self.id = detailDict["id"] as? Int ?? 0
    }
    
    var json: Dictionary<String,Any> {
        
        var dict = Dictionary<String,Any>()
        dict["title"] = self.title
        dict["author"] = self.author
        dict["tag"] = self.tag
        dict["is_completed"] = self.isCompleted
        dict["priority"] = self.priority
        dict["id"] = self.id
        return dict
    }
}
