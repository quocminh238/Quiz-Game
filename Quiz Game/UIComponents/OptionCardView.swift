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
//  OptionCardView.swift
//
//  Created by minh on 8/14/22.
//

import SwiftUI

struct OptionCardView : View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            if (quizOption.isMatched) && (quizOption.isSelected) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                    .foregroundColor(Color.white)

            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
                    .foregroundColor(Color.white)
            } else {
                VStack{
                    Text(quizOption.optionId)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .frame(width: 50, height: 50)
                        .background(quizOption.color.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                    
                    Text(quizOption.option)
                        .frame(width: 150, height: 38)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                }
            }
        }.frame(width: 150, height: 150)
            .background(setBackgroundColor())
            .cornerRadius(40)
    }
    
    func setBackgroundColor() -> Color {
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return Color.green
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return Color.red
        } else {
            return Color.white
        }
    }
}

struct OptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            OptionCardView(quizOption: GameManagerVM.quizData[0].optionsList[0])
            OptionCardView(quizOption: GameManagerVM.quizData[0].optionsList[1])
            OptionCardView(quizOption: GameManagerVM.quizData[0].optionsList[2])
            OptionCardView(quizOption: GameManagerVM.quizData[0].optionsList[3])
            
        }
        .previewLayout(.fixed(width: 150, height: 150))
        .background(Color.black)

    }
}
