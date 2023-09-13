//
//  ViewController.swift
//  CannyYakala
//
//  Created by Rıdvan Sağlam on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        if storedHighScore == nil{
            highScore = 0
            highscoreLabel.text = "Hihgscore: \(highScore)"
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if self.score > self.highScore{
            self.highScore = self.score
            highscoreLabel.text = " Highscore: \(highScore)"
            UserDefaults.standard.set(self.highScore, forKey:"highscore")
        }
        
        image1.isUserInteractionEnabled=true
        image2.isUserInteractionEnabled=true
        image3.isUserInteractionEnabled=true
        image4.isUserInteractionEnabled=true
        image5.isUserInteractionEnabled=true
        image6.isUserInteractionEnabled=true
        image7.isUserInteractionEnabled=true
        image8.isUserInteractionEnabled=true
        image9.isUserInteractionEnabled=true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        
        kennyArray = [image1,image2,image3,image4,image5,image6,image7,image8,image9]
        
        hideKenny()
        
        
        //Timer
        
        counter = 10
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
    }
       @objc func hideKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
           let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
           kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore (){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timerLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
           
            //HighScore
            if self.score > self.highScore{
                self.highScore = self.score
                highscoreLabel.text = "Hightscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "Highscore")
            }
           
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again? ", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert , animated: true, completion: nil)
            
            
            
        }
    }
    
    
}
