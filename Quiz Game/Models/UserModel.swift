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
//  UserModel.swift
//
//  Created by minh on 8/24/22.
//

import Foundation
import SwiftUI

struct UserModel: Identifiable {
    var id = UUID()
    var rank: Int
    var name: String
    var numberOfCorrect: Int
    var timeCount: Int
}
