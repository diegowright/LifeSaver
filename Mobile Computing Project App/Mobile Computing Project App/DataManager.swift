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
    fileprivate var currentUser = User()    // Current user
    
    // MARK: - Medicine Methods
    
    func saveMedicine(name: String, dose:Float, unit: String, instruct: String) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "Medicine", in: managedContext)
        let med = NSManagedObject(entity: entity!, insertInto: managedContext) as! Medicine
        
        print("saving med for \(name)")
        
        med.name = name
        med.dose = dose
        med.unit = unit
        med.instruct = instruct
        med.user = self.currentUser
        
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
    
    func loadMedicine() ->  [Medicine] {
        let nsValues = self.getCurrentUser().medicines!
        var medicines:[Medicine] = []
        for val in nsValues {
            medicines.append(val as! Medicine)
        }
        return medicines
    }
    
    func saveDose(med: String, quantity:Double, time: Date) {
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MedDose", in: managedContext)
        let dose = NSManagedObject(entity: entity!, insertInto: managedContext) as! MedDose
        
        print("saving med for \(med)")
        
        dose.med = med
        dose.quantity = quantity
        dose.time = time as NSDate
        dose.user = self.currentUser
        
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
    
    func saveMeal(date: Date, type: String, food: String, beverage: String, comment: String) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "Meal", in: managedContext)
        let meal = NSManagedObject(entity: entity!, insertInto: managedContext) as! Meal
        
        print("saving meal for \(date) \(type) \(food) \(beverage) \(comment)")
        
        meal.date = date as NSDate?!
        meal.type = type
        meal.food = food
        meal.beverage = beverage
        meal.comment = comment
        meal.user = self.currentUser
        
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
    
    func loadMeal() ->  [Meal] {
        let nsValues = self.getCurrentUser().meals!
        
        var meals:[Meal] = []
        for val in nsValues {
            meals.append(val as! Meal)
        }
        
        var oldDate:Date = Date()
        var mealsOrdered:[Meal] = []
        
        for meal in meals {
            if mealsOrdered.count == 0 || meal.date! as Date > oldDate {
                mealsOrdered.append(meal)
                oldDate = meal.date as! Date
            } else {
                mealsOrdered.insert(meal, at: 0)
                oldDate = meal.date as! Date
            }
        }
        
        return mealsOrdered
    }
    
    func saveWater(date: Date, type: String, amount: Int) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "WaterLog", in: managedContext)
        let meal = NSManagedObject(entity: entity!, insertInto: managedContext) as! WaterLog
        
        print("saving water for \(date) \(type) \(amount)")
        
        meal.date = date as NSDate?!
        meal.type = type
        meal.amount = Int16(amount)
        meal.user = self.currentUser
        
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
    
    func loadWater() ->  [WaterLog] {
        let nsValues = self.getCurrentUser().waterLogs!
        
        var meals:[WaterLog] = []
        for val in nsValues {
            meals.append(val as! WaterLog)
        }
        
        var oldDate:Date = Date()
        var mealsOrdered:[WaterLog] = []
        
        for meal in meals {
            if mealsOrdered.count == 0 || meal.date! as Date > oldDate {
                mealsOrdered.append(meal)
                oldDate = meal.date as! Date
            } else {
                mealsOrdered.insert(meal, at: 0)
                oldDate = meal.date as! Date
            }
        }
        
        return mealsOrdered
    }
    
    func saveReminder(name:String, freq:String, time:Date) {
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Reminder", in: managedContext)
        let dose = NSManagedObject(entity: entity!, insertInto: managedContext) as! Reminder
        
        print("saving med for \(name)")
        
        dose.setValue(name, forKey: "name")
        dose.setValue(freq, forKey: "freq")
        dose.setValue(time, forKey: "time")
        dose.user = self.currentUser
        
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
    
    func loadReminder() ->  [Reminder] {
        let nsValues = self.getCurrentUser().reminders!
        var reminders:[Reminder] = []
        for val in nsValues {
            reminders.append(val as! Reminder)
        }
        return reminders
    }
    
    // MARK: - Medical Event Methods
    
    func saveEvent(template:Template, data:[Dictionary<String, Any>]) {
        let managedContext = self.persistentContainer.viewContext
        
        // Define template entity
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)
        let event = NSManagedObject(entity: entity!, insertInto: managedContext) as! Event
        let currentDate:Date = Date()
        // Populate entity values
        
        event.eventType = template.name
        event.dateCreated = currentDate as NSDate?
        event.user = self.currentUser
        event.template = template
        
        for el in data {
            let attType:String = el["id"]! as! String
            switch attType {
            case "Date & Time":
                let entity = NSEntityDescription.entity(forEntityName: "EventDateTimeValue", in: managedContext)
                let dateTimeValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventDateTimeValue
                dateTimeValue.id = el["id"]! as? String
                dateTimeValue.datetime = el["data"]! as? NSDate
                event.addToDatetimes(dateTimeValue)
                print("Datetime value saved.")
                
            case "Note":
                let entity = NSEntityDescription.entity(forEntityName: "EventNoteValue", in: managedContext)
                let noteValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventNoteValue
                noteValue.id = el["id"]! as? String
                noteValue.noteText = el["data"]! as? String
                event.addToNotes(noteValue)
                print("Note value saved.")
                
            case "Pain Location":
                let entity = NSEntityDescription.entity(forEntityName: "EventPainLocValue", in: managedContext)
                let painLocValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventPainLocValue
                painLocValue.id = el["id"]! as? String
                painLocValue.location = el["data"]! as! Int16
                event.addToPainLocs(painLocValue)
                print("Pain Location value saved.")
                
            case "Pain Type":
                let entity = NSEntityDescription.entity(forEntityName: "EventPainTypeValue", in: managedContext)
                let painTypeValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventPainTypeValue
                painTypeValue.id = el["id"]! as? String
                painTypeValue.type = el["data"]! as! Int16
                event.addToPainTypes(painTypeValue)
                print("Pain Type value saved.")
                
            case "Pain Duration":
                let entity = NSEntityDescription.entity(forEntityName: "EventPainDurValue", in: managedContext)
                let painDurValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventPainDurValue
                painDurValue.id = el["id"]! as? String
                let data = el["data"]! as! Array<Any>
                painDurValue.duration = data[0] as! Float
                painDurValue.unit = Int16(data[1] as! Int)
                event.addToPainDurs(painDurValue)
                print("Pain Duration value saved.")
                
            case "Pain Level":
                let entity = NSEntityDescription.entity(forEntityName: "EventPainLvlValue", in: managedContext)
                let painLvlValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventPainLvlValue
                painLvlValue.id = el["id"]! as? String
                painLvlValue.level = el["data"]! as! Int16
                event.addToPainLvls(painLvlValue)
                print("Pain Level value saved.")
                
            case "Question":
                let entity = NSEntityDescription.entity(forEntityName: "EventQuestionValue", in: managedContext)
                let questionValue = NSManagedObject(entity: entity!, insertInto: managedContext) as! EventQuestionValue
                questionValue.id = el["id"]! as? String
                let data = el["data"]! as! Array<Any>
                questionValue.answer = data[0] as! Int16
                questionValue.question = data[1] as? String
                event.addToQuestions(questionValue)
                print("Question value saved.")
                
            default:
                print("Default case, something went wrong.")
            }
        }
        // Try saving newly event record
        do {
            try managedContext.save()
            print("Saved event record.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        return
    }
    
    func loadAllEvents() -> [Event] {
        let nsValues = self.getCurrentUser().events!
        var events:[Event] = []
        for val in nsValues {
            events.append(val as! Event)
        }
        return events
    }
    
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
        let nsValues = self.getCurrentUser().templates!
        var templates:[Template] = []
        for val in nsValues {
            templates.append(val as! Template)
        }
        return templates
    }
    
    // This function returns a list with all the id's associated with the template
    func getEventAttributeData(event: Event) -> [Dictionary<String, Any>] {
        // I know this code is lame but it kinda needs to be like this
        var vals:[Dictionary<String, Any>] = []
        
        let dateTimeVals = event.datetimes!
        let questionVals = event.questions!
        let painLocVals = event.painLocs!
        let painLvlVals = event.painLvls!
        let painTypeVals = event.painTypes!
        let painDurVals = event.painDurs!
        let noteVals = event.notes!
        
        for val in dateTimeVals {
            let temp = val as! EventDateTimeValue
            let dict:Dictionary<String, Any> = ["value":temp.datetime!, "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in questionVals {
            let temp = val as! EventQuestionValue
            let dict:Dictionary<String, Any> = ["value":temp.answer, "question":temp.question!,
                                                "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in painLocVals {
            let temp = val as! EventPainLocValue
            let dict:Dictionary<String, Any> = ["value":temp.location, "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in painLvlVals {
            let temp = val as! EventPainLvlValue
            let dict:Dictionary<String, Any> = ["value":temp.level, "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in painTypeVals {
            let temp = val as! EventPainTypeValue
            let dict:Dictionary<String, Any> = ["value":temp.type, "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in painDurVals {
            let temp = val as! EventPainDurValue
            let dict:Dictionary<String, Any> = ["value":temp.duration, "unit":temp.unit,
                                                "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        for val in noteVals {
            let temp = val as! EventNoteValue
            let dict:Dictionary<String, Any> = ["value":temp.noteText!, "event":temp.event!, "id":temp.id!]
            vals.append(dict)
        }
        
        return vals
    }
    
    // This function returns a list with all the id's associated with the template
    func getTemplateAttributeData(template: Template) -> [Dictionary<String, String>] {
        // I know this code is lame but it kinda needs to be like this
        var atts:[Dictionary<String, String>] = []
        
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
            atts.append(dict)
        }
        for att in questionAtts {
            let temp = att as! TemplateQuestionAtt
            let dict = ["id":temp.id!, "question":temp.question!]
            atts.append(dict)
        }
        for att in painLocAtts {
            let temp = att as! TemplatePainLocAtt
            let dict = ["id":temp.id!,
                        "loc0":temp.loc0!,
                        "loc1":temp.loc1!,
                        "loc2":temp.loc2!,
                        "loc3":temp.loc3!,
                        "loc4":temp.loc4!]
            atts.append(dict)
        }
        for att in painLvlAtts {
            let temp = att as! TemplatePainLvlAtt
            let dict = ["id":temp.id!]
            atts.append(dict)
        }
        for att in painTypeAtts {
            let temp = att as! TemplatePainTypeAtt
            let dict = ["id":temp.id!]
            atts.append(dict)
        }
        for att in painDurAtts {
            let temp = att as! TemplatePainDurAtt
            let dict = ["id":temp.id!]
            atts.append(dict)
        }
        for att in noteAtts {
            let temp = att as! TemplateNoteAtt
            let dict = ["id":temp.id!]
            atts.append(dict)
        }
        
        return atts
    }
    
    // MARK: - Calendar
    
    func saveNoteRecord(date: Date, noteText: String) {
        // Obtain context
        let managedContext = self.persistentContainer.viewContext
        
        // Create note entity
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        let note = NSManagedObject(entity: entity!, insertInto: managedContext) as! Note
        
        print("saving note for \(date), \(noteText)")
        note.date = date as NSDate?
        note.text = noteText
        note.user = self.currentUser
        
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
    
    // Loads in Notes and Events by date
    func loadEventsByDate(_ date: Date) -> [Dictionary<String, Any>] {
        // initiate container that will have Entity name and link to entity
        var records:[Dictionary<String, Any>] = []
        
        // Format date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.locale = NSLocale.autoupdatingCurrent
        
        let nsNotes = self.getCurrentUser().notes!
        var notes:[Note] = []
        for val in nsNotes {
            notes.append(val as! Note)
        }
        
        
        // Fetch note logs
        for note in notes {
            let recordDate:Date = note.date! as Date
            
            //compare dates
            let recordDateString = dateFormatter.string(from: recordDate)
            let loadDateString = dateFormatter.string(from: date)
            
            if recordDateString == loadDateString {
                records.append(["entity":note, "type":"Note"])
            }
        }
        
        // Fetch Event logs
        let nsEvents = self.currentUser.events!
        var events:[Event] = []
        for val in nsEvents {
            events.append(val as! Event)
        }
        
        for event in events {
            let eventDates = event.datetimes!
            
            // Check if entity has a date associated
            if eventDates.count != 0 {
                // Event had datetime attribute so use that time
                let dateTimeValue = Array(eventDates)[0] as! EventDateTimeValue // just use first value
                let recordDate:Date = dateTimeValue.datetime! as Date
                let recordDateString = dateFormatter.string(from: recordDate)
                let loadDateString = dateFormatter.string(from: date)
                
                if recordDateString == loadDateString {
                    records.append(["entity":event, "type":"Event"])
                }
            } else {
                // No date associated by attribute type so use event creation time
                let recordDate:Date = event.dateCreated! as Date
                let recordDateString = dateFormatter.string(from: recordDate)
                let loadDateString = dateFormatter.string(from: date)
                
                if recordDateString == loadDateString {
                    records.append(["entity":event, "type":"Event"])
                }
            }
        }
        
        // Fetch MedDose logs
        let nsMedDose = self.getCurrentUser().medDoses!
        var medDoses:[MedDose] = []
        for val in nsMedDose {
            medDoses.append(val as! MedDose)
        }
        
        for medDose in medDoses {
            let recordDate:Date = medDose.time! as Date
            
            //compare dates
            let recordDateString = dateFormatter.string(from: recordDate)
            let loadDateString = dateFormatter.string(from: date)
            
            if recordDateString == loadDateString {
                records.append(["entity":medDose, "type":"MedDose"])
            }
        }
        
        // Fetch Meal logs
        let nsMeals = self.getCurrentUser().meals!
        var meals:[Meal] = []
        for val in nsMeals {
            meals.append(val as! Meal)
        }
        
        for meal in meals {
            let recordDate:Date = meal.date! as Date
            
            //compare dates
            let recordDateString = dateFormatter.string(from: recordDate)
            let loadDateString = dateFormatter.string(from: date)
            
            if recordDateString == loadDateString {
                records.append(["entity":meal, "type":"Meal"])
            }
        }
        
        // Fetch Water logs
        let nsBevs = self.getCurrentUser().waterLogs!
        var bevs:[WaterLog] = []
        for val in nsBevs {
            bevs.append(val as! WaterLog)
        }
        
        for bev in bevs {
            let recordDate:Date = bev.date! as Date
            
            //compare dates
            let recordDateString = dateFormatter.string(from: recordDate)
            let loadDateString = dateFormatter.string(from: date)
            
            if recordDateString == loadDateString {
                records.append(["entity":bev, "type":"WaterLog"])
            }
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
    
    func saveUser(userN: String, passW: String, theme: String) -> Bool {
        
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
    
    // MARK: - Theme
    
    func saveTheme(backgroundColor: UIColor, buttonColor: UIColor, buttonTxtColor: UIColor, lblTxtColor: UIColor,
                   navBarColor: UIColor, tabBarColor: UIColor, themeName: String) {
        
        let managedContext = self.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Theme", in: managedContext)
        let newTheme = NSManagedObject(entity: entity!, insertInto: managedContext) as! Theme
        
        // Set attribute values
        newTheme.backgroundColor = backgroundColor
        newTheme.buttonTxtColor = buttonColor
        newTheme.buttonTxtColor = buttonTxtColor
        newTheme.lblTxtColor = lblTxtColor
        newTheme.navBarColor = navBarColor
        newTheme.tabBarColor = tabBarColor
        newTheme.name = themeName
        
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        self.setCurrentTheme(theme: newTheme)
        print("Theme saved and set as current theme.")
    }
    
    // This loads all themes on device, these do not have to be associated with a particular user
    func loadThemes() -> [Theme] {
        var themes:[Theme] = []
        let managedContext = self.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Theme")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            print("Themes loaded.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            for result in results {
                themes.append(result as! Theme)
            }
        } else {
            print("Could not fetch themes.")
        }
        
        return themes
    }
    
    // Returns the theme currently associated with the current user
    func getCurrentTheme() -> Theme {
        if let currentTheme = self.currentUser.selectedTheme {
            return currentTheme
        } else {
            let defaultTheme: Theme = Theme()
            defaultTheme.name = "Default"
            let white:UIColor = UIColor.white
            let defaultBlue:UIColor = UIColor(colorLiteralRed: 0, green: (122/255), blue: 1, alpha: 1)
            let defaultGray:UIColor = UIColor(colorLiteralRed: (247/255), green: (247/255), blue: (247/255), alpha: 1)
            defaultTheme.backgroundColor = white
            defaultTheme.buttonColor = white
            defaultTheme.buttonTxtColor = defaultBlue
            defaultTheme.lblTxtColor = defaultBlue
            defaultTheme.navBarColor = defaultGray
            defaultTheme.tabBarColor = defaultGray
            return defaultTheme
        }
    }
    
    // Sets the theme for the current user
    func setCurrentTheme(theme: Theme) {
        self.currentUser.selectedTheme = theme
    }
    
    /*
     //This pseudocode for how a loadAllData function would work
     func loadAllData() -> Dictionary<String,Any> {
        dataDict:Dictionary<String, Any> = [:]
     
        let managedContext = self.persistentContainer.viewContext
     
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Events")
        var fetchedResults:[NSManagedObject]? = nil
     
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            print("Events loaded.")
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
            }
        }
     
         if let results = fetchedResults {
             for result in results {
                 //add data from result to dataDict
             }
         } else {
             print("Could not fetch users.")
         }
     
         //Do basically the same thing for users, templates, and medicine data, etc.
        
         return dataDict
     }
    */
    
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
