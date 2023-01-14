//
//  AcertadasModel.swift
//  quizzes1
//
//  Created by Raul Gimenez on 17/12/22.
//

import Foundation
import SwiftUI

class Acertadas: ObservableObject{
    @Published var idS = Set<Int>()
    func incCount(quiz: QuizItem){
        if(!idS.contains(quiz.id)){
            idS.insert(quiz.id)
        }
    }
}

