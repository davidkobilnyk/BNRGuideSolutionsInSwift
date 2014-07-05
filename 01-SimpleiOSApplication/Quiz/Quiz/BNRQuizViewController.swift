//
//  BNRQuizViewController.swift
//  Quiz
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

/*In Interface Builder, make sure you specify BNRQuizViewController as the Custom Class
of the File's Owner in the Identity Inspector. More specifically, do this in the *second*
Custom Class area, *not the first*. The first one will then auto-populate with the
"mangled name". IBOutlets didn't work for me until I corrected this.*/
class BNRQuizViewController: UIViewController {
    var currentQuestionIndex = 0
    var questions = [
        "From what is cognac made?",
        "What is 7+7?",
        "What is the capital of Vermont?",
    ]
    var answers = [
        "Grapes",
        "14",
        "Montpelier",
    ]
    @IBOutlet var questionLabel: UILabel
    @IBOutlet var answerLabel: UILabel
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibName, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showQuestionButtonPressed(sender: UIButton) {
        // Step to the next question
        self.currentQuestionIndex++
        
        // Am I past the last question? If yes, go back to the first question
        self.currentQuestionIndex %= self.questions.count
        
        // Get the string at the index in the questions array
        var question = self.questions[self.currentQuestionIndex]
        
        // Display the string in the question label
        self.questionLabel.text = question;
        
        // Reset the answer label
        self.answerLabel.text = "???"
    }
    
    @IBAction func showAnswerButtonPressed(sender: UIButton) {
        // What is the answer to the current question?
        var answer = self.answers[self.currentQuestionIndex]
        
        // Display it in the answer label
        self.answerLabel.text = answer
    }
}