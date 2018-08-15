//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Using the () to initialize a new QuestionBank object using the QuestionBank class. It is empty because the initializer
    // in the QuestionBank class does not contain parameters
    let allQuestions = QuestionBank()
    // Used to check the answer vs the correct answer
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tapping into the array, list, from the QuestionBank class and placing it in this firstQuestion container
        let firstQuestion = allQuestions.list[0]
        // questionLabel is the hookup to where the question is displayed on the view. We are accessing the text property
        // of the firstQuestion data using dot notation. questionText is the container in Question class, text is the input.
        questionLabel.text = firstQuestion.questionText
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1

        nextQuestion()
        
        
    }
    
    
    func updateUI() {
      
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
        
    }
    

    func nextQuestion() {
        
        if questionNumber <= 12 {
        // Accessing the text that we've injected into the UI and instructing it to update based
        // on where we are in questionNumber. We are updating our place in the array by accessing the
        // list property of our allQuestion bank. Accessing the questionText property.
        questionLabel.text = allQuestions.list[questionNumber].questionText
            
        updateUI()
            
        }
        else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:
                { (UIAlertAction) in
                self.startOver()
            })

            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    func checkAnswer() {
        
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    

    
}
