//
//  AddAlarmController.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/24/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit
import UserNotifications
import SQLite

class AddAlarmController: UIViewController {
    
    @IBAction func saveAlarm(_ sender: UIButton) {
        
        let alarm = AlarmInfo(name: txtName.text ?? "alarma",time: txtTime.text!,
                              pospose: switchPosponer.isOn,
                              daysrepeat: daysRepeat, active: true, notification: createNotification())
        
        mSigleton.Alarms.append(alarm)
        createAlarm(alarm: alarm)
        
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainControllerID") as! ViewController
        ViewController.modalTransitionStyle = .crossDissolve
        self.present(ViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainControllerID") as! ViewController
        ViewController.modalTransitionStyle = .crossDissolve
        self.present(ViewController, animated: true, completion: nil)
    }
    
    @IBAction func setAlarmOnClock(_ sender: UIButton) {
        txtTime.becomeFirstResponder()
    }
    
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var switchPosponer: UISwitch!
    @IBOutlet weak var btnLunes: UIButton!
    
    private var timePicker:UIDatePicker?
    
    var daysRepeat:[AlarmInfo.days] = [.none,.none,.none,.none,.none,.none,.none]
    
    var lunesselected = false
    var martesselected = false
    var miercolesselected = false
    var juevesselected = false
    var viernesselected = false
    var sabadoselected = false
    var domingoselected = false
    
    var mSigleton: Singleton!
    var db:Connection!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mSigleton = Singleton.getInstance()
        createDBConection()
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        txtTime.text = formatter.string(from: Date())
        
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(AddAlarmController.timeChanged(timePicker:)), for: .valueChanged)
        
        txtTime.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddAlarmController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        txtTime.text = formatter.string(from: timePicker.date)
        view.endEditing(true)
    }
    

    @IBAction func selectLunes(_ sender: UIButton) {
        if !lunesselected{
            btnLunes.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            btnLunes.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[0] = .lunes
            lunesselected = true
        }else{
            btnLunes.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            btnLunes.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[0] = .none
            lunesselected = false
        }
        
    }
    @IBAction func selectMartes(_ sender: UIButton) {
        if !martesselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[1] = .martes
            martesselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[1] = .none
            martesselected = false
        }
    }
    @IBAction func selectMiercoles(_ sender: UIButton) {
        if !miercolesselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[2] = .miercoles
            miercolesselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[2] = .none
            miercolesselected = false
        }
    }
    @IBAction func selectJueves(_ sender: UIButton) {
        if !juevesselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[3] = .jueves
            juevesselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[3] = .none
            juevesselected = false
        }
    }
    @IBAction func selectViernes(_ sender: UIButton) {
        if !viernesselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[4] = .viernes
            viernesselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[4] = .none
            viernesselected = false
        }
    }
    @IBAction func selectSabado(_ sender: UIButton) {
        if !sabadoselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[5] = .sabado
            sabadoselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[5] = .none
            sabadoselected = false
        }
    }
    @IBAction func selectDomingo(_ sender: UIButton) {
        if !domingoselected{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnSelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            daysRepeat[6] = .domingo
            domingoselected = true
        }else{
            sender.setBackgroundImage(#imageLiteral(resourceName: "btnUnselelected"), for: .normal)
            sender.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
            daysRepeat[6] = .none
            domingoselected = false
        }
    }
    
    func createDBConection(){
        do {
            let path = Bundle.main.url(forResource: "DBAlarms", withExtension: "db")
            db = try Connection(path!.path)
        } catch {
            //handle error
            print(error)
        }
    }
    
    func createAlarm(alarm:AlarmInfo){
        let mname = alarm.mName
        let mtime = alarm.mTime
        var mdays = ""
        
        for row in alarm.mRepeat{
            switch row{
            case .lunes:
                mdays.append(contentsOf: "L ")
                break
            case .martes:
                mdays.append(contentsOf: "M ")
                break
            case .miercoles:
                mdays.append(contentsOf: "MI ")
                break
            case .jueves:
                mdays.append(contentsOf: "J ")
                break
            case .viernes:
                mdays.append(contentsOf: "V ")
                break
            case .sabado:
                mdays.append(contentsOf: "S ")
                break
            case .domingo:
                mdays.append(contentsOf: "D")
                break
                
            default: break
            }
        }
        
        let mpospose = alarm.mPospose ? 1 : 0
        let mactive = 1
        
        do {
            let users = Table("alarms")
        
            let name = Expression<String?>("name")
            let time = Expression<String>("time")
            let days = Expression<String>("days")
            let pospose = Expression<Int64>("pospose")
            let active = Expression<Int64>("active")
            
            let insert = users.insert(name <- mname, time <- mtime!, days <- mdays, pospose <- Int64(mpospose), active <- Int64(mactive))
            _ = try db.run(insert)
            
            /*let stmt = try db.prepare("INSERT INTO alarms (name, time, days, pospose, active) VALUES (?,?,?,?,?)")
            let statement = "\(name),\(time),\(days),\(pospose),\(active)"
            for alarm in [statement] {
                try stmt.run(alarm)
            }*/
        } catch {
            print(error)
        }
        
        
    }
    
    public func createNotification() -> UNNotificationRequest{
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = txtName.text ?? "alarma"
        content.body = "Abrir para mas información"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "sound2.mp3"))
        content.launchImageName = "Image 1.pdf"
        content.userInfo = ["flag":true]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let hour1 = formatter.date(from: formatter.string(from: timePicker!.date))
        let hour2 = formatter.date(from: formatter.string(from: Date()))
        
        let diff = hour1!.timeIntervalSince(hour2!)
        
        
        var fireDate = Calendar.current.dateComponents([.hour,.minute,.second], from: Date().addingTimeInterval(10))
        
        if diff > 0 {
            fireDate = Calendar.current.dateComponents([.hour,.minute,.second], from: hour1!)
            print("Time of the day in the second date is greater")
        } else if diff < 0 {
            fireDate = Calendar.current.dateComponents([.hour,.minute,.second], from: hour1!.addingTimeInterval(86400))
            print("Time of the day in the first date is greater")
        } else {
            fireDate = Calendar.current.dateComponents([.hour,.minute,.second], from: hour1!.addingTimeInterval(86400))
            print("Times of the day in both dates are equal")
        }
        
        
        /*if !lunesselected && !martesselected && !miercolesselected && !juevesselected && !viernesselected && !sabadoselected && !domingoselected{
            
            
            let fireDate = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute,.second], from: Date())
        }else{
            let fireDate = Calendar.current.dateComponents([.day,.month,.year,.hour,.minute,.second], from: Date().addingTimeInterval(20))
        }*/
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)//UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            
        }
        
        return request
    }
    
}
