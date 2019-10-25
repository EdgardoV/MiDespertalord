//
//  AlarmInfoCell.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/24/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmInfoCell: UITableViewCell {

    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmDays: UILabel!
    @IBOutlet weak var alarmIsOn: UISwitch!
    
    var alarm:AlarmInfo!
    
    func setAlarm(alarm:AlarmInfo){
        alarmTime.text = alarm.mTime
        alarmName.text = alarm.mName
        alarmDays.text = setDays(days: alarm.mRepeat)
        alarmIsOn.setOn(alarm.isActivated ? true : false, animated: true)
        self.alarm = alarm
    }
    
    func setDays(days:[AlarmInfo.days]) -> String{
        var sFinal:String = ""
        
        for row in days{
            switch row{
                case .lunes:
                    sFinal.append(contentsOf: "L ")
                    break
                case .martes:
                    sFinal.append(contentsOf: "M ")
                    break
                case .miercoles:
                    sFinal.append(contentsOf: "MI ")
                    break
                case .jueves:
                    sFinal.append(contentsOf: "J ")
                    break
                case .viernes:
                    sFinal.append(contentsOf: "V ")
                    break
                case .sabado:
                    sFinal.append(contentsOf: "S ")
                    break
                case .domingo:
                    sFinal.append(contentsOf: "D")
                    break
                
                default: break
            }
        }
        
        
        return sFinal
    }
    
    @IBAction func enableDisable(_ sender: UISwitch) {
        
        if alarmIsOn.isOn{
            
        }else{
           //UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [self.alarm.mNotification!.identifier])
        }
        
        
    }
    

}
