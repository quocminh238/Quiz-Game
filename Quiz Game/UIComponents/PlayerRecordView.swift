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
//  PlayerRecordView.swift
//
//  Created by minh on 8/19/22.
//

import SwiftUI

struct PlayerRecordView: View {

    var turn: Int
    var numberCorrectAnswers: Int
    var timeCount: Int

    var body: some View {
            
            HStack(alignment: .center, spacing: 40){
                HStack(alignment: .center, spacing: 6) {
                    Text(String(turn))
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        .padding(.trailing, 24)
                }
                
                Text("Player")
                    .fontWeight(.semibold)
                    .font(.system(size: 18))
                    .padding(.trailing, 10)
                
                VStack(alignment: .center, spacing: nil){
                    Text("\(String(numberCorrectAnswers)) correct answers")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                    
                    Text("in \(String(timeCount)) seconds")
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                }
                
            }
            .frame(width: 350, height: 60, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
    }
}


struct PlayerRecordView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRecordView(turn: 1,numberCorrectAnswers: 4, timeCount: 10)
            .previewLayout(.fixed(width: 360, height: 100))
            
            
    }
}
