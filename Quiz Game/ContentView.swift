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
//  ContentView.swift
//
//  Created by Minh, Nguyen Quoc on 28/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(gameManagerVM: GameManagerVM())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
