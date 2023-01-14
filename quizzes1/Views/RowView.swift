//
//  RowView.swift
//  quizzes1
//
//  Created by Raul Gimenez on 12/12/22.
//

import Foundation
import SwiftUI

struct RowView: View {
    
    var quiz: QuizItem
    
    var body: some View {
        
        HStack {
            // AsyncImage(url: quiz.attachment?.url)
            if quiz.attachment?.url != nil {
                AsyncImage(url: quiz.attachment?.url)
                { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                .frame(width:80, height: 80)
                .overlay(Circle().stroke(lineWidth:1))
                .shadow(radius: 10)
                .padding()
            }
            
            else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:80, height: 80)
                    .overlay(Circle().stroke(lineWidth:1))
                    .shadow(radius: 10)
                    .padding()
            }
            
            
            
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        if quiz.favourite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            Image(systemName: "heart").foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    Text(quiz.author?.username ?? "Unknown")
                    
                    AsyncImage(url:  quiz.author?.photo?.url)
                    { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .clipShape(Circle())
                    .frame(width:25, height: 25)
                    .shadow(radius: 10)
                    .padding()
                }
                
                Text(quiz.question)
            }
        }
    }
}

        
        
 
