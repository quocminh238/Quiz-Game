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
//  Created by minh on 8/14/22.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
    
    var gameManagerVM: GameManagerVM
    var body: some View {
            
        //MARK: - HEADER
        VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
            HStack(alignment: .center, spacing: 14){
                Image("award")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                
                
                Text("Leaderboard")
                    .font(.system(size: 34, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Image("award")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                
            }
            .padding()
        
        //MARK: - BODY
            //TITLE
            HStack(alignment: .center, spacing: 40){
                Text("Turn")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("Name")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.leading, 8)

                Text("Record")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.leading, 40)
                
            }
            .padding()
            .padding(.leading, -45)
            
            //DISPLAY PLAYER'S RECORD
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 18){
                    ForEach(gameManagerVM.storeUserRecord){record in                       PlayerRecordView(turn:record.rank,numberCorrectAnswers: record.numberOfCorrect, timeCount: record.timeCount)
                    }
                }
            }
            .navigationBarHidden(true)
            Spacer()
            
        //MARK: - FOOTER
            HStack(alignment: .center, spacing: 26) {
                //BUTTON PLAY AGAIN
                Button {
                    playSound(sound: "button", type: "mp3")
                    gameManagerVM.restartGame()
                } label: {
                    HStack {
                        Text("Play Again")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                    }
                }.frame(width: 166, height: 60, alignment: .center)
                    .background(Color("ColorButton").opacity(0.9))
                    .cornerRadius(14)
                
                //BUTTON BACK TO MENU
                Button {
                    playSound(sound: "button", type: "mp3")
                    gameManagerVM.backToMenuView()
                } label: {
                    HStack {
                        Text("Back to Menu")
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .bold))
                    }
                }.frame(width: 166, height: 60, alignment: .center)
                .background(Color("ColorButton").opacity(0.9))
                    .cornerRadius(14)
            }
            .padding()
            
        }
       
    }
}

struct LeaderboardView_Preview: PreviewProvider {
    static var previews: some View {
        LeaderboardView(gameManagerVM: GameManagerVM())
            .background(Color("ColorBackground").ignoresSafeArea(.all))
    }
}

