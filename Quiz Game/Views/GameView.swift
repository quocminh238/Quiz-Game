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
//  GameView.swift
//
//  Created by minh on 8/14/22.
//

import Foundation
import SwiftUI

struct GameView: View {
    @ObservedObject var gameManagerVM: GameManagerVM

    var body: some View {

        ZStack {
            //MARK: - BACKGROUND FOR THE GAME
            Color("ColorBackground")
                .ignoresSafeArea()
            
            //MARK: - LOGIC TO CONTROL VIEWS FOR THE GAME
            //DISPLAY WELCOME VIEW WHEN THE GAME IS LAUNCHED
            if (gameManagerVM.activeWelcomeView == true) {
                WelcomeView(gameManagerVM: gameManagerVM)
            }
            
            //DISPLAY DIFFICULTY MODE VIEW
            if (gameManagerVM.activeDifficultyModeView == true) {
                DifficultyModeView(gameManagerVM: gameManagerVM)
            }
            
            //DISPLAY LEADERBOARD VIEW
            if (gameManagerVM.activeLeaderBoardView == true) {
                LeaderboardView(gameManagerVM: gameManagerVM)
            }
            
            //DISPLAY MESSAGE WHEN THE GAME IS FINISHED
            if (gameManagerVM.model.quizCompleted) {
                QuizCompletedView(gameManagerVM: gameManagerVM)
                
            }
            
            //DISPLAY GAME VIEW
            else if (gameManagerVM.model.quizCompleted == false && gameManagerVM.activeLeaderBoardView == false && gameManagerVM.activeDifficultyModeView == false && gameManagerVM.activeWelcomeView == false) {
                
                //MARK: - LOGIC HOW GAME VIEW WORK
                VStack {
                    
                    //TITLE (QUESTIONS' CATEGORY)
                    ReusableText(text: "QUIZ GAME", size: 30)
                    
                    //DISPLAY PROGRESS BAR TO HELP PLAYER CAN SEE HOW MANY QUESTIONS LEFT
                    ProgressBar(progress: gameManagerVM.progressBar)
                        .padding()
                    
                    //DISPLAY QUESTIONS
                    ReusableText(text: gameManagerVM.model.quizModel.question, size: 25)
                        .lineLimit(3)
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: 60, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    //DISPLAY TIME COUNTDOWN
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        Circle()
                            .trim(from: 0.0, to: min(CGFloat((Double(gameManagerVM.progress) * Double(gameManagerVM.maxProgress))/100),1.0))
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: 270))
                            .animation(Animation.linear(duration: Double(gameManagerVM.maxProgress)), value: gameManagerVM.progress)
                        
                        ReusableText(text: String(gameManagerVM.progressForTimer), size: 30)
                    }.frame(width: 150, height: 150)
                    
                    Spacer()
                    
                    //DISPLAY ANSWER CARDS AS GRIDVIEW
                    OptionsGridView(gameManagerVM: gameManagerVM)
                
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameManagerVM: GameManagerVM())
    }
}
