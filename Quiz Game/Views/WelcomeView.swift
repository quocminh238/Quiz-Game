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
//  WelcomeView.swift
//
//  Created by minh on 8/26/22.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    var gameManagerVM: GameManagerVM
    @State var displayInfoView:Bool = false

    var body: some View {
        ZStack{
            
            Image("QuizGame")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                
                    //PLAY GAME BUTTON
                    Button {
                        playSound(sound: "game-start", type: "mp3")
                        gameManagerVM.moveToMenuView()
                    } label: {
                            Text("Play now")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                                .frame(width: 250, height: 60, alignment: .center)
                                .background(Color("ColorButton2").opacity(0.8))
                                .cornerRadius(14)
                                .padding(.bottom, 10)
                    }
                    
                    //ABOUT BUTTON
                    Button {
                        playSound(sound: "button", type: "mp3")
                        displayInfoView = true
                    } label: {
                            Text("About")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                                .frame(width: 250, height: 60, alignment: .center)
                                .overlay(RoundedRectangle(cornerRadius: 14)
                                            .stroke(Color.white, lineWidth: 3)
                                            .opacity(0.8)
                                )
                    }
                }
                .padding(.bottom, 125)
            Spacer()
        }
        .onAppear(perform: {
            playSound(sound: "background", type: "mp3")
        })
        .sheet(isPresented: $displayInfoView, content: {
            InfoView()
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(gameManagerVM: GameManagerVM())
    }
}
