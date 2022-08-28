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
//  QuizCompletedView.swift
//
//  Created by minh on 8/18/22.
//

import SwiftUI

struct QuizCompletedView: View {
    var gameManagerVM: GameManagerVM
    
    var body: some View {

            VStack {
                Image(gameManagerVM.model.quizWinningStatus ?
                        "winner" : "cry")
                    .foregroundColor(Color.yellow)
                    .font(.system(size: 60))

                ReusableText(text: gameManagerVM.model.quizWinningStatus ?
                             "CONGRATULATIONS" :
                                "GAME OVER",
                             size: 30)
                    .padding()
                
                ReusableText(text: gameManagerVM.model.quizWinningStatus
                             ? "Thank you for playing!!"
                             : "Better luck next time",
                             size: 30)
                    .padding()
                

                Text("You answered correct \(String(gameManagerVM.correctAnswer)) on \(String(GameManagerVM.quizData.count)) questions")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .padding()
                
                Text("in \(String(gameManagerVM.timeCount)) seconds")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))

                Button {
                    playSound(sound: "button", type: "mp3")
                    gameManagerVM.moveToLeaderboard()
                } label: {
                    HStack {

                        Text("Continue")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                    }
                }.frame(width: 240, height: 60, alignment: .center)
                    .background(Color("ColorButton2").opacity(0.8))
                    .cornerRadius(14)
                    .padding()
        }.onAppear(perform: {
            playSound(sound: gameManagerVM.model.quizWinningStatus ? "game-completed" : "game-over", type: "mp3")
            })
    }
}

struct QuizCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        QuizCompletedView(gameManagerVM: GameManagerVM())
            .background(Color("ColorBackground"))
    }
}
