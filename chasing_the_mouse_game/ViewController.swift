//
//  ViewController.swift
//  chasing_the_mouse_game
//
//  Created by Tarık Reis on 22.09.2020.
//  Copyright © 2020 tarikreisgroup. All rights reserved.
//
//try to git
import UIKit

class ViewController: UIViewController {
   
    var score = 0
    var highscore = 0
    var timer = Timer()
    var counter = 0
    var mousearray = [UIImageView]()
    var hidetimer = Timer()
    
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var highscorelabel: UILabel!
   
   
    @IBOutlet weak var mouse1: UIImageView!
    @IBOutlet weak var mouse2: UIImageView!
    @IBOutlet weak var mouse3: UIImageView!
    @IBOutlet weak var mouse4: UIImageView!
    @IBOutlet weak var mouse5: UIImageView!
    @IBOutlet weak var mouse6: UIImageView!
    @IBOutlet weak var mouse7: UIImageView!
    @IBOutlet weak var mouse8: UIImageView!
    @IBOutlet weak var mouse9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        scorelabel.text = "score \(score)"
        
        //highscorecheck
        let storedhighscore = UserDefaults.standard.object(forKey: "highscore")
        if storedhighscore == nil {
            highscore = 0
            highscorelabel.text = " highscore: \(highscore)"
        }
        
        if let newscore = storedhighscore as? Int {
            highscore = newscore
            highscorelabel.text = "highscore: \(highscore)"
        }
        
        mouse1.isUserInteractionEnabled = true
        mouse2.isUserInteractionEnabled = true
        mouse3.isUserInteractionEnabled = true
        mouse4.isUserInteractionEnabled = true
        mouse5.isUserInteractionEnabled = true
        mouse6.isUserInteractionEnabled = true
        mouse7.isUserInteractionEnabled = true
        mouse8.isUserInteractionEnabled = true
        mouse9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increasescore))

        mouse1.addGestureRecognizer(recognizer1)
        mouse2.addGestureRecognizer(recognizer2)
        mouse3.addGestureRecognizer(recognizer3)
        mouse4.addGestureRecognizer(recognizer4)
        mouse5.addGestureRecognizer(recognizer5)
        mouse6.addGestureRecognizer(recognizer6)
        mouse7.addGestureRecognizer(recognizer7)
        mouse8.addGestureRecognizer(recognizer8)
        mouse9.addGestureRecognizer(recognizer9)

        mousearray=[mouse1,mouse2,mouse3,mouse4,mouse5,mouse6,mouse7,mouse8,mouse9]
        
        counter = 10
        timelabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hidetimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(hidemouse), userInfo: nil, repeats: true)
        
       hidemouse()
    }
    @objc func hidemouse(){
        for mouse in mousearray {
            mouse.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(mousearray.count-1)))
        mousearray[random].isHidden = false
    }
    
    @objc func increasescore(){
        score += 1
        scorelabel.text = "score: \(score)"
    }
    @objc func countdown() {
        counter -= 1
        timelabel.text = String(counter)
       
        if counter == 0 {
            timer.invalidate()
            hidetimer.invalidate()
            for mouse in mousearray {
                mouse.isHidden = true
            }
            //highscore
            if self.score > self.highscore {
                self.highscore = self.score
                highscorelabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            //alert
            let alert = UIAlertController(title: "time is up", message: "want you play again", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replaybutton = UIAlertAction(title:"Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
              //replay
                self.score = 0
                self.scorelabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timelabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hidetimer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.hidemouse), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okbutton)
            alert.addAction(replaybutton)
            self.present(alert, animated: true)
        }
    }
}

