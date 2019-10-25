//
//  AlarmInfo.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/24/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class AlarmInfo{
    var mName:String!
    var mTime:String!
    var mPospose:Bool!
    var mNotification: UNNotificationRequest!
    
    enum days {
        case lunes
        case martes
        case miercoles
        case jueves
        case viernes
        case sabado
        case domingo
        case none
    }
    
    var mRepeat:[days]
    var isActivated:Bool!
    
    init(name:String, time:String, pospose:Bool, daysrepeat:[days], active:Bool) {
        self.mName = name
        self.mTime = time
        self.mPospose = pospose
        self.mRepeat = daysrepeat
        self.isActivated = active
    }
    
    init(name:String, time:String, pospose:Bool, daysrepeat:[days], active:Bool, notification: UNNotificationRequest) {
        self.mName = name
        self.mTime = time
        self.mPospose = pospose
        self.mRepeat = daysrepeat
        self.isActivated = active
        self.mNotification = notification
    }
    
}
