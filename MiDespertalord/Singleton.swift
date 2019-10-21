//
//  Singleton.swift
//  QroBusConsulta
//
//  Created by Edgardo Victorino Marin on 9/19/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import Foundation

class Singleton{
    public static var instance:Singleton? = nil
    private static var isCreated:Bool = false
    
    public var flag:Bool
    
    init() {
        flag = false
    }
    
    
    public static func getInstance() -> Singleton{
        if instance == nil{
            instance = Singleton()
            isCreated = true
        }
        
        return instance ?? Singleton()
    }
    public static func iscreated() -> Bool{
        return isCreated
    }
}
