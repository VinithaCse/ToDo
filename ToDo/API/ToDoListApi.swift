//
//  ToDoListApi.swift
//  ToDo
//
//  Created by Vinitha Rao A on 15/03/22.
//

import Foundation

class ToDoListApi {
    
    class func getToDoListAPI(configuration: APIConfigurator, completionHandler: @escaping(_ toDoData: ToDoListModel) -> Void) {
        
        APIHandler.performRequest(with: configuration) {
            (data, urlResponse, error) in
            
            if error == nil, let receivedData = data {
                
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: receivedData, options: [.allowFragments]) as! [String: Any]
                    let toDolist = ToDoListModel(withJSON: jsonResult)
                    completionHandler(toDolist)
                }
                catch {
                    completionHandler(ToDoListModel())
                }
            }
        }
    }
    
    class func markAsCompleted(configuration: APIConfigurator, completionHandler: @escaping() -> Void) {
        
        APIHandler.performRequest(with: configuration) {
            
            (data, urlResponse, error) in
            
            completionHandler()
        }
    }
}
