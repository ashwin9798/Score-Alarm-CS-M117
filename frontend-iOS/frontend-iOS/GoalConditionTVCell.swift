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
                return 90
            }
        }
        else {
            if(pickerView.tag == 0) {
                return 10
            }
            else {
                return 90
            }
        }
            
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(isTeamCondition) {
            if(pickerView.tag == 0) {
                return teamNames[row]
            }
            else {
                return String(row+1)
            }
        }
        else {
            return String(row+1)
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
                pickerLabel?.text = String(row+1)
            }
        }
        else {
            pickerLabel?.text = String(row+1)
        }
        return pickerLabel!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        isEnabled.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        timePicker.delegate = self
        timePicker.dataSource = self
        
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
