//
//  ViewController.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/17/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var mSingleton:Singleton!
    var mAlarmInfo:[AlarmInfo] = [AlarmInfo]()
    var db:Connection!
    
    @IBOutlet weak var mTable: UITableView!
    @IBOutlet weak var lblTime: UILabel!
    
    
    @IBAction func addAlarm(_ sender: UIButton) {
        let AddAlarmController = self.storyboard?.instantiateViewController(withIdentifier: "AddAlarmControllerID") as! AddAlarmController
        AddAlarmController.modalTransitionStyle = .crossDissolve
        self.present(AddAlarmController, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mSingleton = Singleton.getInstance()
        setTime()
        createDBConection()
        createAlarms()
        
        
        DispatchQueue.global(qos: .background).async {
            //print("This is run on the background queue")
            DispatchQueue.main.async {
                //print("This is run on the main queue, after the previous code in outer block")
                _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.setTime), userInfo: nil, repeats: true)
            }
        }
        
        if mSingleton.flag{
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PoUpControllerID") as! PopUpViewController
            
            //popOverVC.alarmName.text = mSingleton.currentAlarm.mName
            //popOverVC.alarmTime.text = mSingleton.currentAlarm.mTime
            
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            
            mSingleton.flag = false
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
    
    @objc func setTime(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.timeZone = TimeZone(identifier: "America/Mexico_City")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        lblTime.text = formatter.string(from: Date())
    }
    
    func createAlarms(){
        //if mSingleton.Alarms.count > 0 {
            
            self.mAlarmInfo.removeAll()
            
            do {
                for row in try (db?.prepare("SELECT * FROM alarms"))! {
                    
                    
                    let pospose = row[4] as! Int64
                    var posflag = true
                    let active = row[5] as! Int64
                    var actflag = true
                    
                    
                    if pospose == 1{
                        posflag = true
                    }else{
                        posflag = false
                    }
                    
                    if active == 1{
                        actflag = true
                    }else{
                        actflag = false
                    }
                    
                    let alarm = AlarmInfo(
                        name: row[1] as! String,
                        time: row[2] as! String,
                        pospose: posflag,
                        daysrepeat: decodeDays(str: row[3] as! String),
                        active: actflag
                    )
                    
                    self.mAlarmInfo.append(alarm)
                }
            } catch {
                print(error)
            }
            
            self.mTable.reloadData()
        //}
        
    }
    
    func decodeDays(str:String) -> [AlarmInfo.days]{
        let days = str.components(separatedBy: " ")
        var auxDays:[AlarmInfo.days] = [AlarmInfo.days.none, AlarmInfo.days.none, AlarmInfo.days.none, AlarmInfo.days.none, AlarmInfo.days.none, AlarmInfo.days.none, AlarmInfo.days.none]
        
        for row in days{
            switch row{
                case "L":
                    auxDays[0] = AlarmInfo.days.lunes
                    break
                case "M":
                    auxDays[1] = AlarmInfo.days.martes
                    break
                case "MI":
                    auxDays[2] = AlarmInfo.days.miercoles
                    break
                case "J":
                    auxDays[3] = AlarmInfo.days.jueves
                    break
                case "V":
                    auxDays[4] = AlarmInfo.days.viernes
                    break
                case "S":
                    auxDays[5] = AlarmInfo.days.sabado
                    break
                case "D":
                    auxDays[6] = AlarmInfo.days.domingo
                    break
                default:
                    break
            }
        }
        
        return auxDays
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let suggested = mAlarmInfo[indexPath.row]
        let cell = Bundle.main.loadNibNamed("AlarmCell", owner: self, options: nil)?.first as! AlarmInfoCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.setAlarm(alarm: suggested)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
        
        print(currentCell)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mAlarmInfo.count
    }
    
}

