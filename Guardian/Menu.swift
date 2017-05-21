//
//  Menu.swift
//  Guardian
//
//  Created by Brian  Dejesus on 5/20/17.
//  Copyright © 2017 Brian  Dejesus. All rights reserved.
//

import Foundation

import UIKit

class Menu: UIViewController {
    
    
    @IBAction func startButton(_ sender: Any) {
        goToGame()
    }
    
    func goToGame(){
        
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
