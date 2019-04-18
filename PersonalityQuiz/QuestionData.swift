//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Soft Dev Student on 4/8/19.
//  Copyright © 2019 Alice Zhong. All rights reserved.
//

import Foundation

// define types and enums
// question type
struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

// response type enum
enum ResponseType {
    case single, multiple, ranged
}

// answer type
struct Answer {
    var text: String
    var type: CityType
}

// city type enum
enum CityType {
    case beiJing, shangHai, hangZhou, wuHan
    
    // name on the results screen for city types
    var name: String {
        switch self {
        case .beiJing:
            return "BeiJing"
        case .hangZhou:
            return "HangZhou"
        case .shangHai:
            return "ShangHai"
        case .wuHan:
            return "WuHan"
        }
    }
    // label on the results screen for city types
    var definition: String {
        switch self {
        case .beiJing:
            return "Beijing, the capital of China, is an amazing city with great history. Gugong museum is one of the famous places with history in Beijing. There are also many other amazing tourist attractions, such as the Great Wall."
        case .hangZhou:
            return "Hangzhou is a lovely city. It has many beautiful tourist attraction, such as the West Lake. It also has great food. Hangzhou cuisine is quite famous."
        case .shangHai:
            return "Shanghai is a very popular city. It has amazing food, and it has many amazing places where tourists could spend their time playing at, such as Huan Le Gu."
        case .wuHan:
            return "Wuhan has great spicy food and great tourist attractions. Huang He Lou and the East Lake are both famous. Hu Bu Xiang is a street with many amazing food in Wuhan."
        }
    }
}
