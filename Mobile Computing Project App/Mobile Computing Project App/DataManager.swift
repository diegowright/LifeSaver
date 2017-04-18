//
//  EventSaver.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/21/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    // Instantiate DataManager singleton.
    static let shared = DataManager()
    
    // This is the current user
    fileprivate var currentUser = User()
    
    // fileprivate var events = [Event]()
    // fileprivate var templates = [Template]()
    
    // MARK: - Medicine Methods
    
    func saveMedicine(name: String, dose:Float, unit: String) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "Medicine", in: managedContext)
        let med = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        print("saving med for \(name)")
        
        med.setValue(name, forKey: "name")
        med.setValue(dose, forKey: "dose")
        med.setValue(unit, forKey: "unit")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return
    }
    
    func loadMedicine() ->  [NSManagedObject]{
        let managedContext = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Medicine")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            return results
        } else {
            print("Could not fetch")
            return fetchedResults!
        }
    }
    
    // MARK: - Medical Event Methods
    
    func saveTemplate(templateName: String, attributeList:[String:[Dictionary<String, String>]]) {
        let managedContext = self.persistentContainer.viewContext

        // Define template entity
        let entity = NSEntityDescription.entity(forEntityName: "Template", in: managedContext)
        let template = NSManagedObject(entity: entity!, insertInto: managedContext) as! Template
        let currentDate:Date = Date()
        // Populate entity values
        
        template.name = templateName
        template.dateCreated = currentDate as NSDate?
        template.user = self.currentUser

        // Go through attributeList
        for (id, atts) in attributeList {
            switch id {
            case "Question":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplateQuestionAtt", in: managedContext)
                    let questionAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplateQuestionAtt
                    questionAtt.id = dict["id"]
                    questionAtt.question = dict["question"]
                    template.addToQuestionAtts(questionAtt)
                    print("Question added to template.")
                }
            case "Pain Location":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplatePainLocAtt", in: managedContext)
                    let painLocAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplatePainLocAtt
                    painLocAtt.id = dict["id"]
                    painLocAtt.loc0 = dict["loc0"]
                    painLocAtt.loc1 = dict["loc1"]
                    painLocAtt.loc2 = dict["loc2"]
                    painLocAtt.loc3 = dict["loc3"]
                    painLocAtt.loc4 = dict["loc4"]
                    template.addToPainLocAtts(painLocAtt)
                    print("Pain Location added to template.")
                }
            case "Pain Type":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplatePainTypeAtt", in: managedContext)
                    let painTypeAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplatePainTypeAtt
                    painTypeAtt.id = dict["id"]
                    template.addToPainTypeAtts(painTypeAtt)
                    print("Pain Type added to template.")
                }
                
            case "Pain Duration":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplatePainDurAtt", in: managedContext)
                    let painDurAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplatePainDurAtt
                    painDurAtt.id = dict["id"]
                    template.addToPainDurAtts(painDurAtt)
                    print("Pain Duration added to template.")
                }
            case "Pain Level":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplatePainLvlAtt", in: managedContext)
                    let painLvlAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplatePainLvlAtt
                    painLvlAtt.id = dict["id"]
                    template.addToPainLvlAtts(painLvlAtt)
                    print("Pain Level added to template.")
                }
            case "Note":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplateNoteAtt", in: managedContext)
                    let noteAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplateNoteAtt
                    noteAtt.id = dict["id"]
                    template.addToNoteAtts(noteAtt)
                    print("Note added to template.")
                }
            case "Date & Time":
                for dict in atts {
                    let entity = NSEntityDescription.entity(forEntityName: "TemplateDateTimeAtt", in: managedContext)
                    let dateTimeAtt = NSManagedObject(entity: entity!, insertInto: managedContext) as! TemplateDateTimeAtt
                    dateTimeAtt.id = dict["id"]
                    template.addToDatetimeAtts(dateTimeAtt)
                    print("Date & Time added to template.")
                }
            default:
                print("Default case. Something went wrong.")
            }
        }
        
        // Try saving newly added template and template attributes
        do {
            try managedContext.save()
            print("Saved template.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return
    }
    
    // Load all template names so that they can be later identified by name
    func loadAllTemplates() -> [Template] {
        var templates:[Template] = []
        
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Template")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            print("Templates loaded.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add each fetched template to list
        if let results = fetchedResults {
            for result in results {
                templates.append(result as! Template)
            }
        } else {
            print("Could not fetch templates.")
        }
        
        print(templates)
        return templates
    }
    
    // This function returns a list with all the id's associated with the template
    func getTemplateAttributeNames(template: Template) -> [Dictionary<String, String>] {
        // I know this code is lame but it kinda needs to be like this
        var attNames:[Dictionary<String, String>] = []
        
        let dateTimeAtts = template.datetimeAtts!
        let questionAtts = template.questionAtts!
        let painLocAtts = template.painLocAtts!
        let painLvlAtts = template.painLvlAtts!
        let painTypeAtts = template.painTypeAtts!
        let painDurAtts = template.painDurAtts!
        let noteAtts = template.noteAtts!
        
        for att in dateTimeAtts {
            let temp = att as! TemplateDateTimeAtt
            let dict = ["id":temp.id!]
            attNames.append(dict)
        }
        for att in questionAtts {
            let temp = att as! TemplateQuestionAtt
            let dict = ["id":temp.id!, "question":temp.question!]
            attNames.append(dict)
        }
        for att in painLocAtts {
            let temp = att as! TemplatePainLocAtt
            let dict = ["id":temp.id!,
                        "loc0":temp.loc0!,
                        "loc1":temp.loc1!,
                        "loc2":temp.loc2!,
                        "loc3":temp.loc3!,
                        "loc4":temp.loc4!]
            attNames.append(dict)
        }
        for att in painLvlAtts {
            let temp = att as! TemplatePainLvlAtt
            let dict = ["id":temp.id!]
            attNames.append(dict)
        }
        for att in painTypeAtts {
            let temp = att as! TemplatePainTypeAtt
            let dict = ["id":temp.id!]
            attNames.append(dict)
        }
        for att in painDurAtts {
            let temp = att as! TemplatePainDurAtt
            let dict = ["id":temp.id!]
            attNames.append(dict)
        }
        for att in noteAtts {
            let temp = att as! TemplateNoteAtt
            let dict = ["id":temp.id!]
            attNames.append(dict)
        }
        
        return attNames
    }
    
    // MARK: - Notes
    
    func saveNoteRecord(date: Date, noteText: String) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        let note = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        print("saving note for \(date), \(noteText)")
        
        note.setValue(date, forKey: "date")
        note.setValue(noteText, forKey: "text")
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return
    }
    
    func loadEventsByDate(_ date: Date) -> [(String, Date)] {
        
        let managedContext = self.persistentContainer.viewContext
        
        //print("\nloading data for \(date)")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        var records:[(String, Date)] = []
        
        if let results = fetchedResults {
            for result in results {
                
                let noteText = result.value(forKey: "text") as! String
                let recordDate = result.value(forKey: "date") as! Date
                
                //compare dates
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy MM dd"
                dateFormatter.locale = NSLocale.autoupdatingCurrent
                let recordDateString = dateFormatter.string(from: recordDate)
                let loadDateString = dateFormatter.string(from: date)
                
                if recordDateString == loadDateString {
                    records.append((noteText, recordDate))
                }
            }
        } else {
            print("Could not fetch")
            return []
        }
        
        return records
    }
    
    // MARK: - Login/Registration Functions
    
    func getUser(username:String, password:String) -> User {
        let userList = self.loadUsers()
        
        for user in userList {
            if user.userName == username && user.passWord == password {
                print("User \(user) found.")
                return user
            }
        }
        print("User not found.")
        return User()
    }
    
    func setCurrentUser(user:User) {
        self.currentUser = user
        print("Current user set to \(user)")
    }
    
    func getCurrentUser() -> User {
        return self.currentUser
    }
    
    func isValidUser(userName: String, passWord: String) -> Bool{
        let userList = self.loadUsers()
        
        for user in userList{
            if userName == user.userName && passWord == user.passWord{
                return true
            }
        }
        return false
    }
    
    func loadUsers() -> [User]{
        var users:[User] = []
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            print("Users loaded.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            for result in results {
                users.append(result as! User)
            }
        } else {
            print("Could not fetch users.")
        }
        
        return users
    }
    
    func saveUser(userN: String, passW: String) -> Bool {
        
        let managedContext = self.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedContext) as! User
        
        if self.isValidUser(userName: userN, passWord: passW) {
            print("This user exists already.")
            return false
        }
        
        // Set attribute values
        user.userName = userN
        user.passWord = passW
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////
    // START - Core Data code moved from AppDelegate - unchanged.
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Mobile_Computing_Project_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // END - Core Data code moved from AppDelegate.
    ///////////////////////////////////////////////////////////////////////////////////////
}
