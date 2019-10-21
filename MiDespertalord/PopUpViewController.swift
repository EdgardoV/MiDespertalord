//
//  PopUpViewController.swift
//  QroBusConsulta
//
//  Created by Edgardo Victorino Marin on 5/31/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBAction func endAlarm(_ sender: UIButton) {
        removeAnimate()
    }
    
    @IBAction func posposeAlarm(_ sender: UIButton) {
        removeAnimate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}
