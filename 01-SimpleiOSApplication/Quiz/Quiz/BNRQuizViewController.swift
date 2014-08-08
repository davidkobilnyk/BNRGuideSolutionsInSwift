//
//  BNRQuizViewController.swift
//  Quiz
//
//  Created by David Kobilnyk on 7/5/14.
//  Copyright (c) 2014 David Kobilnyk. All rights reserved.
//

import UIKit

/*In Interface Builder, make sure you specify BNRQuizViewController as the Custom Class
of the File's Owner in the Identity Inspector.*/
class BNRQuizViewController: UIViewController {
    
    var currentQuestionIndex = 0 // using var for currentQuestionIndex since it will be updated later
    let questions = [ // using let for the arrays since we won't need to change them
        "From what is cognac made?",
        "What is 7+7?",
        "What is the capital of Vermont?",
    ]
    let answers = [
        "Grapes",
        "14",
        "Montpelier",
    ] // using default property values here instead of initializing in init
    
    // @IBOutlet defaults data members as weak
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This is hooked up to questionLabel in the xib file
    @IBAction func showQuestionButtonPressed(sender: UIButton) {
        // Step to the next question
        self.currentQuestionIndex++
        
        // Am I past the last question?
        if (self.currentQuestionIndex == self.questions.count) {
            // Go back to the first question
            self.currentQuestionIndex = 0
        }
        
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