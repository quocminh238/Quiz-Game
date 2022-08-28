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
//  DifficultyModeView.swift
//
//  Created by minh on 8/23/22.
//

import Foundation
import SwiftUI

struct DifficultyModeView: View {
    var gameManagerVM: GameManagerVM
    
    var body: some View {
                //MARK: - HEADER
                VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/) {
                    HStack(alignment: .center, spacing: 14){
                        
                        Text("Difficulty Mode")
                            .font(.system(size: 34, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    .padding()
                    
                    Spacer()

                //MARK: - BODY
                    //BUTTON EASY MODE
                    Button {
                        playSound(sound: "button", type: "mp3")
                        gameManagerVM.activeDifficultyModeView = false
                        gameManagerVM.temp = 45
                        gameManagerVM.start()
                    } label: {
                        HStack {
                            Text("Easy")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                    }.frame(width: 240, height: 60, alignment: .center)
                    .background(Color("ColorButton").opacity(0.9))
                        .cornerRadius(14)
                        .padding()
                    
                    //BUTTON NORMAL MODE
                    Button {
                        playSound(sound: "button", type: "mp3")
                        gameManagerVM.activeDifficultyModeView = false
                        gameManagerVM.temp = 30
                        gameManagerVM.start()
                    } label: {
                        HStack {
                            Text("Normal")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                    }.frame(width: 240, height: 60, alignment: .center)
                    .background(Color("ColorButton").opacity(0.9))
                        .cornerRadius(14)
                        .padding()
                    
                    //BUTTON HARD MODE
                    Button {
                        playSound(sound: "button", type: "mp3")
                        gameManagerVM.activeDifficultyModeView = false
                        gameManagerVM.temp = 15
                        gameManagerVM.start()
                    } label: {
                        HStack {
                            Text("Hard")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .bold))
                        }
                    }.frame(width: 240, height: 60, alignment: .center)
                    .background(Color("ColorButton").opacity(0.9))
                        .cornerRadius(14)
                        .padding()
                    
                    Spacer()
        }

    }
}

struct DifficultyModeView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyModeView(gameManagerVM: GameManagerVM())
            .background(Color("ColorBackground").ignoresSafeArea(.all))
    }
}
