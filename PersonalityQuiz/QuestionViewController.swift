//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Soft Dev Student on 4/8/19.
//  Copyright © 2019 Alice Zhong. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // update interface
        updateUI()
    }
    
    // outlets
    // outlet for stack views
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    // outlet for buttons under single stack view
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    // outlet for labels under multiple stack view
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    // outlet for switches under multiple stack view
    @IBOutlet weak var multipleSwitch1: UISwitch!
    @IBOutlet weak var multipleSwitch2: UISwitch!
    @IBOutlet weak var multipleSwitch3: UISwitch!
    @IBOutlet weak var multipleSwitch4: UISwitch!
    
    // outlet for labels under ranged stack view
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    // outlet for slider under ranged stack view
    @IBOutlet weak var rangedSlider: UISlider!
    
    // outlet for question label
    @IBOutlet weak var questionLabel: UILabel!
    
    // outlet for progress view
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    // methods
    // method for single answer
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // assign current answers
        let currentAnswers = questions[questionIndex].answers
        
        // assign answer to button
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        // move to next question
        nextQuestion()
    }
    
    // method for multiple answer
    @IBAction func multipleAnswerButtonPressed() {
        // assign current answers
        let currentAnswers = questions[questionIndex].answers
        
        // assign answer to switch
        if multipleSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multipleSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multipleSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multipleSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        // move to next question
        nextQuestion()
    }
    
    // method for ranged answer
    @IBAction func rangedAnswerButtonPressed() {
        // assign current answers
        let currentAnswers = questions[questionIndex].answers
        
        // assign answer to slider
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        // move to next question
        nextQuestion()
    }
    
    // segue for passing answers to results view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    // variables
    // the questions
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Beijing Roast Duck", type: .beiJing),
                    Answer(text: "Shanghai Xiaolongbao", type: .shangHai),
                    Answer(text: "Dongpo Pork", type: .hangZhou),
                    Answer(text: "Hot Dry Noodles", type: .wuHan)
                    ]),
        Question(text: "Which of the following weather do you like?",
                 type: .multiple,
                 answers: [
                    Answer(text: "hot, rainy in summer; cold, dry in winter", type: .beiJing),
                    Answer(text: "wet, sunny and rainy", type: .shangHai),
                    Answer(text: "good weather in spring and autumn", type: .hangZhou),
                    Answer(text: "rainy and hot", type: .wuHan)
                    ]),
        Question(text: "How much do you like museum?",
                 type: .ranged,
                 answers: [
                    Answer(text: "0", type: .shangHai),
                    Answer(text: "1", type: .wuHan),
                    Answer(text: "2", type: .hangZhou),
                    Answer(text: "3", type: .beiJing)
                    ]),
        Question(text: "How much do you like amusement park?",
                 type: .ranged,
                 answers: [
                    Answer(text: "0", type: .hangZhou),
                    Answer(text: "1", type: .beiJing),
                    Answer(text: "2", type: .wuHan),
                    Answer(text: "3", type: .shangHai)
                    ]),
        Question(text: "Are you a quiet or loud person?",
                 type: .single,
                 answers: [
                    Answer(text: "quiet", type: .beiJing),
                    Answer(text: "very loud", type: .shangHai),
                    Answer(text: "very quiet", type: .hangZhou),
                    Answer(text: "loud", type: .wuHan)
                    ])
    ]
    
    // question index
    var questionIndex = 0
    
    // collection which store the player's answers
    var answersChosen: [Answer] = []
    
    // functions
    // function for updating interface
    func updateUI() {
        // hide all stack views
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        // assign current question, answers, and progress
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // assign navigation item title, question label, and question progress view
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // show the needed stack view
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
            updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
    }
    
    // function for setting all three stack view
    // setting single stack view
    func updateSingleStackView(using answers: [Answer]) {
        // show single stack view
        singleStackView.isHidden = false
        // set title for buttons
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    // setting multiple stack view
    func updateMultipleStackView(using answers: [Answer]) {
        // show multiple stack view
        multipleStackView.isHidden = false
        // reset switches
        multipleSwitch1.isOn = false
        multipleSwitch2.isOn = false
        multipleSwitch3.isOn = false
        multipleSwitch4.isOn = false
        // set labels
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
    }
    
    // setting ranged stack view
    func updateRangedStackView(using answers: [Answer]) {
        // show ranged stack view
        rangedStackView.isHidden = false
        // reset slider
        rangedSlider.setValue(0.5, animated: false)
        // set labels
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    // function for moving to next question
    func nextQuestion() {
        // move to next question
        questionIndex += 1
        
        // see if there are remaining questions and act
        if questionIndex < questions.count {
            // there are, update interface
            updateUI()
        } else {
            // there are not, present results
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
