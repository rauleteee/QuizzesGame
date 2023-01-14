//
//  quizzes1App.swift
//  quizzes1
//
//  Created by Raul Gimenez on 8/11/22.
//

import SwiftUI

@main
struct quizzes1App: App {
    let quizzesModel = QuizzesModel()
    let acertadas = Acertadas()
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(quizzesModel)
                .environmentObject(acertadas)
        }
    }
}
