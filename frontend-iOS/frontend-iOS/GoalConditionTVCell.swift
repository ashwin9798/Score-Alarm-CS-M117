//
//  GoalConditionTVCell.swift
//  frontend-iOS
//
//  Created by Ashwin Vivek on 3/8/18.
//  Copyright © 2018 cs-m117. All rights reserved.
//

import UIKit

class GoalConditionTVCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var isEnabled: UISwitch!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    var teamNames: [String] = ["", "", "Neither"]
    var isTeamCondition: Bool = false
    
    @IBOutlet weak var label1: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    var cellIndex: Int = 0
    
    var picker1Val: Any = 0
    var picker2Val: Any = "N/A"
    
    var parentViewController: CreateAlarmViewController!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(isTeamCondition) {
            //first picker view
            if(pickerView.tag == 0) {
                return 3
            }
            else {
                return 91
            }
        }
        else {
            if(pickerView.tag == 0) {
                return 10
            }
            else {
                return 91
            }
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let parentVC = self.parentViewController as? CreateAlarmViewController {
            if(pickerView.tag == 0) {
                if(isTeamCondition) {
                    picker1Val = teamNames[row]
                }
                else {
                    picker1Val = (row)
                }
            }
            else {
                if(row == 0) {
                    picker2Val = "N/A"
                }
                else {
                    picker2Val = row
                }
            }
            
            var templateString = ""
            if(cellIndex == 0) {
                if let p2val = picker2Val as? String {
                    templateString = "Goal difference of \(picker1Val)"
                    parentViewController.myConditions[0] = Condition(team: -1, game_id: parentViewController.game_id, condition_type: 1, time_option: -1, goal_option: picker1Val as! Int)
                }
                else {
                    templateString = "Goal difference of \(picker1Val) at \(picker2Val) minutes"
                    parentViewController.myConditions[0] = Condition(team: -1, game_id: parentViewController.game_id, condition_type: 1, time_option: picker2Val as! Int, goal_option: picker1Val as! Int)
                }
                
            }
            else if(cellIndex == 1) {
                if let p2val = picker2Val as? String {
                    templateString = "\(teamNames[0]) has scored at least \(picker1Val) goals"
                    parentViewController.myConditions[1] = Condition(team: 0, game_id: parentViewController.game_id, condition_type: 2, time_option: -1, goal_option: picker1Val as! Int)
                }
                else {
                    templateString = "\(teamNames[0]) has scored at least \(picker1Val) after \(picker2Val) minutes"
                    parentViewController.myConditions[1] = Condition(team: 0, game_id: parentViewController.game_id, condition_type: 2, time_option: picker2Val as! Int, goal_option: picker1Val as! Int)
                }
            }
            else if(cellIndex == 2) {
                if let p2val = picker2Val as? String {
                    templateString = "\(teamNames[1]) has scored at least \(picker1Val) goals"
                    parentViewController.myConditions[2] = Condition(team: 1, game_id: parentViewController.game_id, condition_type: 2, time_option: -1, goal_option: picker1Val as! Int)
                }
                else {
                    templateString = "\(teamNames[1]) has scored at least \(picker1Val) after \(picker2Val) minutes"
                    parentViewController.myConditions[2] = Condition(team: 1, game_id: parentViewController.game_id, condition_type: 2, time_option: picker2Val as! Int, goal_option: picker1Val as! Int)
                }
            }
            else if(cellIndex == 3) {
                if let p2val = picker2Val as? String {
                    if(String(describing: picker1Val) == "Neither") {
                        templateString = "The game is drawn"
                    }
                    templateString = "\(picker1Val) is leading"
                    parentViewController.myConditions[3] = Condition(team: -1, game_id: parentViewController.game_id, condition_type: 3, time_option: -1, goal_option: -1)
                }
                else {
                    if(String(describing: picker1Val) == "Neither") {
                        templateString = "The game is drawn at \(picker2Val) minutes"
                    }
                    templateString = "\(picker1Val) is leading at \(picker2Val) minutes"
                    parentViewController.myConditions[3] = Condition(team: -1, game_id: parentViewController.game_id, condition_type: 3, time_option: picker2Val as! Int, goal_option: -1)
                }
               
            }
            parentVC.chosenConditions[cellIndex] = templateString
            parentVC.updateLabel(index: cellIndex)
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(isTeamCondition) {
            if(pickerView.tag == 0) {
                return teamNames[row]
            }
            else {
                return String(row)
            }
        }
        else {
            return String(row)
        }
    }
    
    @objc func switchChanged() {
        if(isEnabled.isOn) {        timePicker.isUserInteractionEnabled = true
            goalPicker.isUserInteractionEnabled = true
            
            timePicker.alpha = 1
            goalPicker.alpha = 1
            label1.alpha = 1
            label2.alpha = 1
            label3.alpha = 1
        }
        else {
            timePicker.isUserInteractionEnabled = false
            goalPicker.isUserInteractionEnabled = false
            
            timePicker.alpha = 0.2
            goalPicker.alpha = 0.2
            label1.alpha = 0.2
            label2.alpha = 0.2
            label3.alpha = 0.2
            
           
            if let parentVC = self.parentViewController as? CreateAlarmViewController {
                parentVC.chosenConditions[cellIndex] = ""
                parentVC.updateLabel(index: cellIndex)
            }

        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Helvetica", size: 17)
            pickerLabel?.textAlignment = .center
        }
        if(isTeamCondition) {
            if(pickerView.tag == 0) {
                pickerLabel?.text = teamNames[row]
            }
            else {
                if(row == 0) {
                    pickerLabel?.text = "N/A"
                }
                else {
                    pickerLabel?.text = String(row)
                }
            }
        }
        else {
            if(pickerView.tag == 0) {
                pickerLabel?.text = String(row)
            }
            else {
                if(row == 0) {
                    pickerLabel?.text = "N/A"
                }
                else {
                    pickerLabel?.text = String(row)
                }
            }
        }
        return pickerLabel!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        isEnabled.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        timePicker.delegate = self
        timePicker.dataSource = self
        
        timePicker.selectRow(45, inComponent: 0, animated: false)
        
        
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        timePicker.isUserInteractionEnabled = false
        goalPicker.isUserInteractionEnabled = false
        
        timePicker.alpha = 0.2
        goalPicker.alpha = 0.2
        label1.alpha = 0.2
        label2.alpha = 0.2
        label3.alpha = 0.2
        
        goalPicker.tag = 0
        timePicker.tag = 1
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
