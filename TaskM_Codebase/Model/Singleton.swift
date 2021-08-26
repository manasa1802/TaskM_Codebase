//
//  Singleton.swift
//  TaskM_Codebase
//
//  Created by manasa on 7/21/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import Foundation

class Singleton{
    static let sharedInstance = Singleton()
    var projectId = 0
    var taskId = 0
    
    func getProjectId() -> String{
        projectId += 1
        return "P\(projectId)"
    }
    
    func getTaskId() -> String{
        taskId = Int.random(in: 100000...999999)
        return "T\(taskId)"
    }

}
