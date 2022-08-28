/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Quoc Minh
  ID: s3758994
  Created  date: 14/08/2022
  Last modified: 28/08/2022
  Acknowledgement: .
*/
//
//  GameManagerVM.swift
//
//  Created by minh on 8/14/22.
//

import Foundation
import SwiftUI

class GameManagerVM : ObservableObject {
    
    //MARK: - PROPERTIES
    static var currentIndex = 0
    
    static func createGameModel(i:Int) -> Quiz {
        
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    
    //Variables for Controlling Timer
    var timer = Timer()
    
    //VARIABLES TO SETUP TIME FOR EACH DIFFICULTY MODE
    @Published var temp = 0
    
    var maxProgress = 0
    @Published var progress = 0
    @Published var maxProgressForTimer = 0
    @Published var progressForTimer = 0
    
    //VARIABLE FOR RECORD THE TIME RUN
    @Published var timeCount = 0

    //VARIABLES FOR RECORD NUMBER OF CORRECT ANSWERS
    @Published var correctAnswer = 0
    
    //VARIABLES FOR CONTROLLING PROGRESSBAR
    @Published var progressBar: CGFloat = 0
    
    //VARIABLES FOR CONTROLLING VIEWS
    @Published var activeWelcomeView:Bool = true
    @Published var activeDifficultyModeView:Bool = false
    @Published var activeLeaderBoardView:Bool = false
    @Published var activeInfoView:Bool = false

    //ARRAY TO STORE THE RECORD OF PLAYER AFTER EACH GAME
    @Published var storeUserRecord:[UserModel] = []
    
//    init() {
//        self.start()
//    }
    
    //MARK: - FUNCTIONS (GAME LOGICS)
    
    //MARK: - CHECK CORRECT OR INCORRECT ANSWER AND MOVE TO THE NEXT QUESTION
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            
            //CHECK WHEN USER CHOOSE CORRECT ANSWER
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                playSound(sound: "correct-answer", type: "mp3")
                correctAnswer += 1
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.progressBar = CGFloat(Double(GameManagerVM.currentIndex + 1) / Double(GameManagerVM.quizData.count)*350)
                    if (GameManagerVM.currentIndex < GameManagerVM.quizData.count - 1) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        
                        //RESULT OF CURRENT PLAY ON THE LEADERBOARD
                        if(self.storeUserRecord.isEmpty){
                            self.storeUserRecord.append(UserModel(rank: 1, name: "Player", numberOfCorrect: self.correctAnswer, timeCount: self.timeCount))

                        } else {
                            self.storeUserRecord.append(UserModel(rank: self.storeUserRecord.count + 1, name: "Player", numberOfCorrect: self.correctAnswer, timeCount: self.timeCount))
                        }
                        self.reset()
                    }
                }
                
            //CHECK WHEN USER CHOOSE INCORRECT ANSWER
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
                playSound(sound: "incorrect-answer", type: "mp3")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.progressBar = CGFloat(Double(GameManagerVM.currentIndex + 1) / Double(GameManagerVM.quizData.count)*350)
                    if (GameManagerVM.currentIndex < GameManagerVM.quizData.count - 1) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        //RESULT OF CURRENT PLAY ON THE LEADERBOARD
                        if(self.storeUserRecord.isEmpty){
                            self.storeUserRecord.append(UserModel(rank: 1, name: "Player", numberOfCorrect: self.correctAnswer, timeCount: self.timeCount))

                        } else {
                            self.storeUserRecord.append(UserModel(rank: self.storeUserRecord.count + 1, name: "Player", numberOfCorrect: self.correctAnswer, timeCount: self.timeCount))
                        }
                        self.reset()
                    }
                }

            }

        }
    }
    
    //MARK: - MOVE TO Menu View LOGIC
    func moveToMenuView(){
        self.activeWelcomeView = false
        self.activeDifficultyModeView = true
    }
    
   //MARK: - MOVE TO Difficulty View LOGIC
    func backToMenuView() {
        self.activeDifficultyModeView = true
        self.activeLeaderBoardView = false
        GameManagerVM.currentIndex = 0
        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
        self.correctAnswer = 0
        self.progressBar = 0
        self.timeCount = 0
    }
    
    //MARK: - MOVE TO Leaderboard View LOGIC
    func moveToLeaderboard() {
        self.activeLeaderBoardView = true
        self.model.quizCompleted = false
    }

    //MARK: - PLAY AGAIN LOGIC
    func restartGame() {
        GameManagerVM.currentIndex = 0
        model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
        self.activeLeaderBoardView = false
        self.correctAnswer = 0
        self.progressBar = 0
        self.timeCount = 0
        self.start()
    }
    
    //MARK: - START THE GAME LOGIC
    func start() {
        self.maxProgress = self.temp
        self.progressForTimer = self.temp
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true, block: { time in
            if self.progressForTimer == self.maxProgressForTimer {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
                self.progressForTimer -= 1
                self.timeCount += 1
                
            }
        })
    }
          
    //MARK: - RESET GAME LOGIC
    func reset() {
        timer.invalidate()
        self.progress = 0
        self.progressForTimer = self.temp

    }
    
}


//MARK: - LIST OF QUESTIONS
extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [

            QuizModel(
                      question: "How many hearts does an octopus have?",
                      answer: "A",
                      optionsList: [QuizOption(id: 1,optionId: "A", option: "Three", color: Color.yellow),
                                    QuizOption(id: 2,optionId: "B", option: "Four", color: Color.red),
                                    QuizOption(id: 3,optionId: "C", option: "One", color: Color.green),
                                    QuizOption(id: 4,optionId: "D", option: "Two", color: Color.purple)]),
            
            QuizModel(
                      question: "In which European city would you find Orly airport?",
                      answer: "D",
                      optionsList: [QuizOption(id: 5,optionId: "A", option: "London", color: Color.yellow),
                                    QuizOption(id: 6,optionId: "B", option: "Chicago", color: Color.red),
                                    QuizOption(id: 7,optionId: "C", option: "Toronto", color: Color.green),
                                    QuizOption(id: 8,optionId: "D", option: "Paris", color: Color.purple)]),
            
            QuizModel(
                      question: "Which country consumes the most chocolate per capita?",
                      answer: "C",
                      optionsList: [QuizOption(id: 9,optionId: "A", option: "Sweden", color: Color.yellow),
                                    QuizOption(id: 10,optionId: "B", option: "Vietnam", color: Color.red),
                                    QuizOption(id: 11,optionId: "C", option: "Switzerland", color: Color.green),
                                    QuizOption(id: 12,optionId: "D", option: "Germany", color: Color.purple)]),
            
            QuizModel(
                      question: "Which is the fastest animal in the world?",
                      answer: "B",
                      optionsList: [QuizOption(id: 13,optionId: "A", option: "Turtle", color: Color.yellow),
                                    QuizOption(id: 14,optionId: "B", option: "Cheetah", color: Color.red),
                                    QuizOption(id: 15,optionId: "C", option: "Rabbit", color: Color.green),
                                    QuizOption(id: 16,optionId: "D", option: "Leoprd", color: Color.purple)]),
            
            QuizModel(
                      question: "In what year were the first Air Jordan sneakers released?",
                      answer: "C",
                      optionsList: [QuizOption(id: 17,optionId: "A", option: "2004", color: Color.yellow),
                                    QuizOption(id: 18,optionId: "B", option: "1994", color: Color.red),
                                    QuizOption(id: 19,optionId: "C", option: "1984", color: Color.green),
                                    QuizOption(id: 20,optionId: "D", option: "1974", color: Color.purple)]),
            
            QuizModel(
                      question: "Which planet is the hottest in the solar system?",
                      answer: "B",
                      optionsList: [QuizOption(id: 21,optionId: "A", option: "Mar", color: Color.yellow),
                                    QuizOption(id: 22,optionId: "B", option: "Venus", color: Color.red),
                                    QuizOption(id: 23,optionId: "C", option: "Earth", color: Color.green),
                                    QuizOption(id: 24,optionId: "D", option: "Mercury", color: Color.purple)]),

            QuizModel(
                      question: "Which is the world largest living fish?",
                      answer: "B",
                      optionsList: [QuizOption(id: 25,optionId: "A", option: "Manta Ray", color: Color.yellow),
                                    QuizOption(id: 26,optionId: "B", option: "Whale Shark", color: Color.red),
                                    QuizOption(id: 27,optionId: "C", option: "Marlin", color: Color.green),
                                    QuizOption(id: 28,optionId: "D", option: "Sailfish", color: Color.purple)]),

//            QuizModel(
//                      question: "What is the loudest animal on Earth?",
//                      answer: "A",
//                      optionsList: [QuizOption(id: 29,optionId: "A", option: "Sperm Whale", color: Color.yellow),
//                                    QuizOption(id: 30,optionId: "B", option: "Human", color: Color.red),
//                                    QuizOption(id: 31,optionId: "C", option: "Gorilla", color: Color.green),
//                                    QuizOption(id: 32,optionId: "D", option: "Lion", color: Color.purple)]),
//
//            QuizModel(
//                      question: "Who was the first female Prime Minister of Great Britain?",
//                      answer: "D",
//                      optionsList: [QuizOption(id: 33,optionId: "A", option: "Angela Merkel", color: Color.yellow),
//                                    QuizOption(id: 34,optionId: "B", option: "Queen Elizabeth II", color: Color.red),
//                                    QuizOption(id: 35,optionId: "C", option: "Hillary Clinton", color: Color.green),
//                                    QuizOption(id: 36,optionId: "D", option: "Margaret Thatcher", color: Color.purple)]),
//
//            QuizModel(
//                      question: "What country won the very first FIFA World Cup in 1930?",
//                      answer: "A",
//                      optionsList: [QuizOption(id: 37,optionId: "A", option: "Uruguay", color: Color.yellow),
//                                    QuizOption(id: 38,optionId: "B", option: "Brasil", color: Color.red),
//                                    QuizOption(id: 39,optionId: "C", option: "Germany", color: Color.green),
//                                    QuizOption(id: 40,optionId: "D", option: "France", color: Color.purple)]),
        ]
    }
}
