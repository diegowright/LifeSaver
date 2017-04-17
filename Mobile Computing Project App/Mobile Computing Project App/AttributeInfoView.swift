//
//  AttributeInformationView.swift
//  Mobile Computing Project App
//
//  Created by Diego Wright on 3/20/17.
//  Copyright © 2017 Robin Stewart. All rights reserved.
//

import UIKit

class AttributeInformationView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var alertController:UIAlertController? = nil
    
    fileprivate let attributeTypes:[String] = ["Date & Time", "Question", "Pain Duration", "Note", "Pain Level", "Pain Location", "Pain Type"]
    fileprivate let attDict = ["Date & Time":addDateTimeAtt,
                               "Question":addQuestionAtt,
                               "Pain Duration":addPainDurAtt,
                               "Note":addNoteAtt,
                               "Pain Level":addPainLvlAtt,
                               "Pain Location":addPainLocAtt,
                               "Pain Type":addPainTypeAtt]
    
    // Varibles for template attributes with changable parameters
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var loc1: UITextField!
    @IBOutlet weak var loc2: UITextField!
    @IBOutlet weak var loc3: UITextField!
    @IBOutlet weak var loc4: UITextField!
    @IBOutlet weak var loc5: UITextField!
    
    // Views that contain question and pain location option inputs
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var painLocView: UIView!
    
    // Picker view
    @IBOutlet weak var attributePicker: UIPickerView!
    
    // Position that quesitonView and painLocView will be moved to and from
    fileprivate var defaultXPoint:CGFloat = 0
    fileprivate var defaultYPoint:CGFloat = 0

    // Save attribute to event by sending a notification that the event will listen for
    @IBAction func saveAttribute(_ sender: Any) {
        print("Saving attribute, about to send notification")
        let id = self.attributeTypes[self.attributePicker.selectedRow(inComponent: 0)]

        // package the data into a dictionary
        var dataDict:Dictionary = ["id":id]
        if (id == "Question") {
            // Add question text to dictionary
            dataDict["question"] = "some question?"
        }
        if (id == "Pain Location") {
            // Add pain locations text to dictionary
            dataDict["loc1"] = "loc1"
            dataDict["loc2"] = "loc2"
            dataDict["loc3"] = "loc3"
            dataDict["loc4"] = ""
            dataDict["loc5"] = ""
        }
        
        // Post notification to add attribute
        NotificationCenter.default.post(name: Notification.Name(rawValue: self.attDict[id]!), object: nil, userInfo: dataDict)
        
        print("Add attribute notification sent. Exit.")

        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create an Attribute"
        
        // Setup picker attribute values
        self.attributePicker.dataSource = self
        self.attributePicker.delegate = self
        
        // Set default X and Y value for moveable view
        self.defaultXPoint = self.questionView.frame.origin.x
        self.defaultYPoint = self.questionView.frame.origin.y
        
        // Move pain location view out of way and question view to default position
        self.movePainLocInputs(pos: "out")
        self.moveQuesitonInputs(pos: "out")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // Functions to satisfy UIPickerView delegate protocol ////////////////////////////////////////////////////
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.attributeTypes.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.attributeTypes[row]
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    // function that is called when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch row {
        case 0:
            // Date & Time
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "out")
            print(row)
        case 1:
            // Question
            print(row)
            // move text label and input box for 
            self.moveQuesitonInputs(pos: "in")
            self.movePainLocInputs(pos: "out")
        case 2:
            // Pain Duration
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "out")
            print(row)
        case 3:
            // Note
            print(row)
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "out")
        case 4:
            // Pain Level
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "out")
            print(row)
        case 5:
            // Pain Location
            print(row)
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "in")
        case 6:
            // Pain Type
            self.moveQuesitonInputs(pos: "out")
            self.movePainLocInputs(pos: "out")
            print(row)
        default:
            print("Something went wrong")
        }
    }
    
    // Move the question label and input textbox to either in or out
    func movePainLocInputs(pos:String) {
        if (pos == "in") {
            // Move inputs in, make sure to move pain type outputs out
            print("Moving pain locs in")
            self.moveQuesitonInputs(pos: "out")
            self.painLocView.frame = CGRect(origin: CGPoint(x: self.defaultXPoint, y: self.defaultYPoint),
                                             size: self.questionView.frame.size)
        } else if (pos == "out") {
            // Move inputs out of view
            print("Moving pain locs out")
            self.painLocView.frame = CGRect(origin: CGPoint(x: self.defaultXPoint - CGFloat(10000),
                                                            y: self.defaultYPoint),
                                            size: self.questionView.frame.size)
        } else {
            print("Not a valid position. Moving inputs out.")
            self.movePainLocInputs(pos: "out")
        }
    }
    
    // Move the question label and input textbox to either in or out
    func moveQuesitonInputs(pos:String) {
        if (pos == "in") {
            // Move inputs in, make sure to move pain type outputs out
            print("Moving question inputs in")
            self.movePainLocInputs(pos: "out")
            self.questionView.frame = CGRect(origin: CGPoint(x: self.defaultXPoint, y: self.defaultYPoint),
                                             size: self.questionView.frame.size)
        } else if (pos == "out") {
            // Move inputs out of view
            print("Moving question inputs out")
            self.questionView.frame = CGRect(origin: CGPoint(x: self.defaultXPoint - CGFloat(10000),
                                                             y: self.defaultYPoint),
                                             size: self.questionView.frame.size)
        } else {
            print("Not a valid position. Moving inputs out.")
            self.moveQuesitonInputs(pos: "out")
        }
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
