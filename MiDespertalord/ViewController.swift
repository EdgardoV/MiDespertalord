//
//  ViewController.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/17/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var mSingleton:Singleton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mSingleton = Singleton.getInstance()
        
        if mSingleton.flag{
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PoUpControllerID") as! PopUpViewController
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
        }else{
            
        }
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "alarma1"
        content.body = "Abrir para mas información"
        content.sound = .default
        content.userInfo = ["flag":true]
        
        let fireDate = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute,.second], from: Date().addingTimeInterval(20))
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)//UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            
        }
        
        
    }


}

