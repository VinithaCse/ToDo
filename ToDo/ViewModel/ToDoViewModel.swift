//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by Vinitha Rao A on 17/03/22.
//

import Foundation

class ToDoViewModel {
    
    var dataModel = ToDoListModel()
    
    func getData(completionHandler: @escaping(_ isCompleted: Bool) -> Void) {
        
        let apiConfig = APIConfigurator(jsonValue: [:], httpMethod: .get, urlToBeCalled: "http://167.71.235.242:3000/todo?_page=1&_limit=15&author=vinitha")
        ToDoListApi.getToDoListAPI(configuration: apiConfig) {
            [weak self] toDoListModel in
            
            if let self = self {
                self.dataModel = toDoListModel
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    func markAsCompleted(data: ToDoModel, completionHandler: @escaping(_ isCompleted: Bool) -> Void) {
        
        let apiConfig = APIConfigurator(jsonValue: data.json, httpMethod: .put, urlToBeCalled: "http://167.71.235.242:3000/todo/1")
        ToDoListApi.markAsCompleted(configuration: apiConfig) {
                completionHandler(true)
            }
        }
}
