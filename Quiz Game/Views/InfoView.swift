//
//  InfoView.swift
//  asm2
//
//  Created by minh on 8/26/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
          Color("ColorBackground")
          VStack(alignment: .center, spacing: 10) {
                    Image("info")
                        .resizable()
                        .frame(width: 250, height: 80, alignment: .center)
            
            Spacer()
            
            Form {
                
              Section(header: Text("How To Play")) {
                  Text("Select one of three difficulty modes.")
                  Text("Try to answer all of those questions as fast as you can when: ")
                  Text("Easy mode gives 45 seconds to answer all questions.")
                  Text("Normal mode gives 30 seconds to answer all questions.")
                  Text("Hard mode gives 15 seconds to answer all questions.")
                  Text("Do not worry about incorrect or correct answers.")
                  Text("Because this game is to help you to learn more things.")
                  Text("You can view your records after each game to see how you are improved.")
                  Text("You can change the difficulty mode after each game by pressing Back To Menu.")
                  Text("Please....Enjoy the game !!")
              }
                
                Section(header: Text("Application Information")) {
                    HStack {
                      Text("App Name")
                      Spacer()
                      Text("Quiz Game")
                    }
                    HStack {
                      Text("Course")
                      Spacer()
                      Text("COSC2659")
                    }
                    HStack {
                      Text("Year Published")
                      Spacer()
                      Text("2022")
                    }
                    HStack {
                      Text("Location")
                      Spacer()
                      Text("Saigon South Campus")
                    }
              }
                
                Section(header: Text("Author Information")) {
                    HStack {
                      Text("Author Name")
                      Spacer()
                      Text("Nguyen Quoc Minh")
                    }
                    HStack {
                      Text("Student ID")
                      Spacer()
                      Text("s3758994")
                    }
                    HStack {
                      Text("Email")
                      Spacer()
                      Text("s3758994@rmit.edu.vn")
                    }
                    HStack {
                      Text("Link")
                      Spacer()
                      Text("https://github.com/quocminh238")
                    }
                }
            }
            .font(.system(.body, design: .rounded))
          }
          .padding(.top, 40)
          .overlay(
            Button(action: {
//                      audioPlayer?.stop()
                playSound(sound: "button", type: "mp3")
                presentationMode.wrappedValue.dismiss()
            }) {
              Image(systemName: "xmark.circle")
                .font(.title)
            }
            .foregroundColor(.white)
            .padding(.top, 30)
            .padding(.trailing, 15),
            alignment: .topTrailing
            )
//                    .onAppear(perform: {
//                      playSound(sound: "drum-music", type: "mp3")
//                    })
    
          }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
