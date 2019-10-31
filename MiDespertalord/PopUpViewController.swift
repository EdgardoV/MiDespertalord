//
//  PopUpViewController.swift
//  QroBusConsulta
//
//  Created by Edgardo Victorino Marin on 5/31/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit
import UserNotifications

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmImage: UIImageView!
    
    
    @IBAction func endAlarm(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func posposeAlarm(_ sender: UIButton) {
        createNotification()
        removeAnimate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomInt = Int.random(in: 0..<6)
        
        switch randomInt {
        case 0:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "image 1"))
            self.alarmImage.image = #imageLiteral(resourceName: "image 1")
        case 1:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "AP_Portrait_Landscapes_Stu_Meech-16 (1)"))
            self.alarmImage.image = #imageLiteral(resourceName: "AP_Portrait_Landscapes_Stu_Meech-16 (1)")
        case 2:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "portrait-landscape"))
            self.alarmImage.image = #imageLiteral(resourceName: "portrait-landscape")
        case 3:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "857ebd7658e56c84a4dc65cc4453a305"))
            self.alarmImage.image = #imageLiteral(resourceName: "857ebd7658e56c84a4dc65cc4453a305")
        case 4:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "tgrant-8592"))
            self.alarmImage.image = #imageLiteral(resourceName: "tgrant-8592")
        case 5:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "portrait-lighting-landscape-photography-dps-3"))
            self.alarmImage.image = #imageLiteral(resourceName: "portrait-lighting-landscape-photography-dps-3")
        default:
            self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "portrait-landscape"))
            self.alarmImage.image = #imageLiteral(resourceName: "portrait-landscape")
        }
        
        self.showAnimate()
        // Do any additional setup after loading the view.
    }
    
    func showAnimate()
    {
        /*let randomInt = Int.random(in: 0..<3)
        
        switch randomInt {
            case 0:
                self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background_blue"))
            case 1:
                self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background_orange"))
            case 2:
                self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background_purple"))
            default:
                self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background_orange"))
        }*/
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    public func createNotification(){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "alarma"
        content.body = "Abrir para mas información"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sound2.mp3"))
        content.launchImageName = "Image 1.pdf"
        content.userInfo = ["flag":true]

        let fireDate = Calendar.current.dateComponents([.hour,.minute,.second], from: Date().addingTimeInterval(300))
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)//UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            
        }
    }
    
}
