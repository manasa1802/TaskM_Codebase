//
//  Constants.swift
//  TaskM_Codebase
//
//  Created by manasa on 6/28/21.
//  Copyright © 2021 manasa. All rights reserved.
//

import Foundation


struct Constants {
    
    static let loginScreenId = "LoginScreenStoryBoardID"
    static let signUpId = "SignUpID"
    static let myProjectScreenID = "MyProjectsVCID"
    static let projectCellId = "ProjectCellId"
    
    static let navigationControllerID = "NavigationControllerID"
    static let mytaskTabbarControllerStoryboardId = "MyTasksTabBarController"
    static let myTasksStoryboardId = "MyTaskStoryboardID"
    static let myTaskCellId = "MyTaskCellID"
    static let createTaskID = "CreateTaskID"
    
    
    struct ProjectList{
        
        static let collectionName = "Projects"
        static let projectName = "ProjectName"
        static let projectDescription = "ProjectDescription"
        static let projectDuration = "ProjectDuration"
        static let emailId = "EmailId"
        static let projectId = "ProjectId"
        static let userId = "UserId"
        static let projectDate  = "ProjectDate"
        
    }
    
    struct TaskList{
        
        static let collectionName = "Tasks"
        static let taskId = "TaskID"
        static let projectId = ProjectList.projectId
        static let status = "Status"
        static let taskName = "TaskName"
        static let taskDescription = "TaskDescription"
        static let noOfDays = "NoOfDays"
        static let dependency = "Dependency"
        static let taskDate = "TaskDate"
        
    }
    
}
