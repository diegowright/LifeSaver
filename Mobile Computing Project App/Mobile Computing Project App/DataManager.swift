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
    // Instantiate the singleton for this class.
    // This is the only code that should create a DataManager object.
    static let shared = DataManager()
    
    // The Core Data data model. Don't allow access from outside this class.
    fileprivate var events = [NSManagedObject]()
    //fileprivate var users = [NSManagedObject]()
    // Data model methods.
    
    // Saves the template for an event and saves to core data to be used to define data event adder page
    func saveEventTemplate(name:String, atts:[(String, String)]) {
        print("Save the event of type \(name)")
        
        var _model: NSManagedObjectModel {
            let model = NSManagedObjectModel()
            
            let entity = NSEntityDescription()
            entity.name = name + "_Template"
            entity.managedObjectClassName = String(describing: DataManager.self)
            
            //set attributes from list of attributes
            var properties:[NSAttributeDescription] = []
            
            for att in atts {
                print(att)
                let (attName, attType) = att
                let attribute: NSAttributeDescription = NSAttributeDescription()
                attribute.name = attName
                attribute.defaultValue = attType
                attribute.attributeType = .stringAttributeType
                attribute.isOptional = false
                attribute.isIndexed = true
                properties.append(attribute)
            }
            
            entity.properties = properties
            model.entities = [entity]
            
            return model
        }
        
    }
    
    // the Register CoreData
    func saveUser(userN: String, passW: String){
        
        
        let managedContext = self.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set attribute values
        user.setValue(userN, forKey: "userName")
        user.setValue(passW, forKey: "passWord")
        
        
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


   
    /*
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
    */
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

    func load() {
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Event")
        
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
            events = results
        } else {
            print("Could not fetch")
        }
    }
    
    func savePerson(name: String, age: String) {
        let managedContext = self.persistentContainer.viewContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        // Set the attribute values
        person.setValue(name, forKey: "name")
        person.setValue(Int(age), forKey: "age")
        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
        events.append(person)
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
