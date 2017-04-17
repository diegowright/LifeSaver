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
    
    func saveTemplate(templateName: String, attributeList:[String:Dictionary<String, String>]) {
        let managedContext = self.persistentContainer.viewContext
        
        // Define template entity
        let entity = NSEntityDescription.entity(forEntityName: "Template", in: managedContext)
        let template = NSManagedObject(entity: entity!, insertInto: managedContext) as! Template
        let currentDate:Date = Date()
        // Populate entity values
        
        template.name = templateName
        template.dateCreated = currentDate as NSDate?
        //template.user = Config.user // or something like that eventually

        // Go through attributeList
        
        /*
        // Go through attributes and create template attributes
        for (index, attribute) in attributeList.enumerated() {
            print("Index: ", index)
            // Define template attribute entity
            let attEntity = NSEntityDescription.entity(forEntityName: "TemplateAttribute", in: managedContext)
            //let templateAtt = NSManagedObject(entity: attEntity!, insertInto: managedContext) as! TemplateAttribute
            // Define template attribute values
            templateAtt.name = attribute.0
            templateAtt.type = attribute.1
            templateAtt.order = Int16(index)
            
            // Add templateAtt to template by relationship defined in core data model
            template.addToAttributes(templateAtt)
        }
        */
        
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
    func loadTemplates() -> [Template] {
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
        
        return templates
    }
    
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
        
        print("\nloading data for \(date)")
        // let entityNames:Array =
        
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
