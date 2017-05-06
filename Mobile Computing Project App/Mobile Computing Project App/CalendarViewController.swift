//
//  CalendarViewController.swift
//  Mobile Computing Project App
//
//  Created by Robin Stewart on 3/24/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Set month dictionary
    let monthString:NSDictionary = [1:"January", 2:"February", 3:"March", 4:"April", 5:"May", 6:"June",
                                    7:"July", 8:"August", 9:"September", 10:"October", 11:"November", 12:"December"]
    // Cache colors to reduce lag
    let white = UIColor.white
    let black = UIColor.black
    let gray = UIColor.gray
    
    var selectedDate: Date = Date() // Will be used to load events for that day
    var selectedEvents:[Dictionary<String, Any>] = DataManager.shared.loadEventsByDate(Date())
    var cellDateFormatter:DateFormatter?

    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var eventTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTable.dataSource = self
        eventTable.delegate = self
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.registerHeaderView(xibFileNames: ["MonthHeader"])
        calendarView.scrollToDate(Date())   // set initial month to current month
        calendarView.selectDates([Date()])  // set intial selected date to current date
        
        self.cellDateFormatter = DateFormatter()
        self.cellDateFormatter!.dateFormat = "hh:mm:ss"
        self.cellDateFormatter!.locale = NSLocale.autoupdatingCurrent
        
        self.title = "Calendar"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedEvents = DataManager.shared.loadEventsByDate(self.selectedDate)
        self.eventTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            if let row:Int = self.eventTable.indexPathForSelectedRow?.row {
                if let destination = segue.destination as? ShowNoteVC {
                let note:Note = self.selectedEvents[row]["entity"] as! Note
                destination.date = note.date! as Date
                destination.noteText = note.text!
                }
            }
        } else if segue.identifier == "showEvent" {
            if let row:Int = self.eventTable.indexPathForSelectedRow?.row {
                if let destination = segue.destination as? ShowEventValues {
                    let event:Event = self.selectedEvents[row]["entity"] as! Event
                    destination.event = event
                    destination.eventType = event.eventType!
                }
            }
        } else if segue.identifier == "showMeal" {
            if let row:Int = self.eventTable.indexPathForSelectedRow?.row {
                if let destination = segue.destination as? ShowMealVC {
                    let meal:Meal = self.selectedEvents[row]["entity"] as! Meal
                    destination.meal = meal
                }
            }
        }
    }
    
    // MARK: - Calendar
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.dayLabel.textColor = white
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dayLabel.textColor = black
            } else {
                myCustomCell.dayLabel.textColor = gray
            }
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  25
            myCustomCell.selectedView.isHidden = false
            
            self.selectedDate = myCustomCell.date!
            self.selectedEvents = DataManager.shared.loadEventsByDate(myCustomCell.date!)
            
            print("Date \(self.selectedDate)")
            
            // Update tableview to include stuff
            self.selectedEvents = DataManager.shared.loadEventsByDate(self.selectedDate)
            self.eventTable.reloadData()
        } else {
            myCustomCell.selectedView.isHidden = true
        }
    }

    //MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row:Int = indexPath.row
        let entityType:String = self.selectedEvents[row]["type"] as! String
        print("Entity Type: \(entityType)")
        if (entityType == "Note") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! CalendarNoteCell
            cell.backgroundColor = white
            let note:Note = self.selectedEvents[row]["entity"] as! Note
      
            cell.labelText.text = note.text!
            let exactDate = note.date! as Date
            cell.date.text = self.cellDateFormatter!.string(from: exactDate)
            cell.exactDate = exactDate
            
            return cell
        } else if (entityType == "Event") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! CalendarEventCell
            let event:Event = self.selectedEvents[row]["entity"] as! Event
            cell.backgroundColor = white
            
            cell.labelText.text = event.eventType!
            
            let eventDates = event.datetimes!
            var exactDate:Date?
            
            // Check if entity has a date associated
            if eventDates.count != 0 {
                // Event had datetime attribute so use that time
                let dateTimeValue = Array(eventDates)[0] as! EventDateTimeValue // just use first value
                exactDate = dateTimeValue.datetime! as Date
            } else {
                // No date associated by attribute type so use event creation time
                exactDate = event.dateCreated! as Date
            }
            
            cell.date.text = self.cellDateFormatter!.string(from: exactDate!)
            cell.exactDate = exactDate!
            
            return cell
        } else if (entityType == "MedDose") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "medDoseCell", for: indexPath) as! CalendarMedDoseCell
            let medDose:MedDose = self.selectedEvents[row]["entity"] as! MedDose
            cell.backgroundColor = white
            
            cell.medName.text = medDose.med!
            cell.dose.text = "\(medDose.quantity) taken"
            cell.date.text = self.cellDateFormatter?.string(from: medDose.time! as Date)
            
            return cell
        } else if (entityType == "Meal") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! CalendarMealCell
            let meal:Meal = self.selectedEvents[row]["entity"] as! Meal
            cell.backgroundColor = white
            
            cell.meal.text = meal.food!
            cell.date.text = self.cellDateFormatter?.string(from: meal.date! as Date)
            
            return cell
        } else if (entityType == "WaterLog") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "waterLogCell", for: indexPath) as! CalendarWaterLogCell
            let bev:WaterLog = self.selectedEvents[row]["entity"] as! WaterLog
            cell.backgroundColor = white
            
            cell.beverage.text = bev.type!
            cell.quantity.text = "\(bev.amount) oz"
            cell.date.text = self.cellDateFormatter?.string(from: bev.date! as Date)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            print("something went wrong in loading calendar cell")
            return cell
        }
    }
   
    // New Note action
    @IBAction func createNote(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let eventVC = storyboard.instantiateViewController(withIdentifier: "AddNote") as! NoteVC
        eventVC.selectedDate = self.selectedDate
        self.navigationController!.pushViewController(eventVC, animated: true)
    }
}

// More calendar stuff
extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.locale = NSLocale.autoupdatingCurrent
        formatter.dateFormat = "yyyy MM dd"
        // let startDate = Date()
        let startDate = formatter.date(from: "2006 01 01")! // You can use date generated from a formatter
        let endDate = formatter.date(from: "2018 12 31")!          // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        // Setup Cell text
        myCustomCell.dayLabel.text = cellState.text
        myCustomCell.date = date
        
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    // This sets the height of your header
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: 200, height: 50)
    }
    // This setups the display of your header
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: range.0)
        let headerCell = (header as? MonthHeaderView)
        headerCell?.title.text = "\(self.monthString[dateComponents.month!]!) \(dateComponents.year!)"
    }
}
