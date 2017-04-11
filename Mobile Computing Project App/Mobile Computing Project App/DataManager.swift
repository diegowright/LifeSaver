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

class DataManager {
    
    // Saves the template for an event and saves to core data to be used to define data event adder page
    class func saveEventTemplate(name:String, atts:[(String, String)]) {
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
    
    class func saveNoteRecord(date: Date, noteText: String) {
        // Obtain context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
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
    
    class func loadEventsByDate(_ date: Date) -> [(String, Date)] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
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
}
