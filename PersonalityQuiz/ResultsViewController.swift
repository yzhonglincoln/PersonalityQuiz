//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Soft Dev Student on 4/8/19.
//  Copyright © 2019 Alice Zhong. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // calculate results
        calculatePersonalityResult()
        // hide back button
        navigationItem.hidesBackButton = true
    }
    
    // outlet
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // array for receiving data of results from question view controller
    var responses: [Answer]!
    
    // function for calculating results
    func calculatePersonalityResult() {
        // find the frequency of each city
        var frequencyOfAnswers: [CityType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        // find the most frequent city
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        // update results label to the most frequent city
        resultAnswerLabel.text = "Go to \(mostCommonAnswer.name)"
        resultDefinitionLabel.text = mostCommonAnswer.definition
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
