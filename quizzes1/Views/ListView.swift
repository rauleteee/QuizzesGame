//
//  ListView.swift
//  quizzes1
//
//  Created by Raul Gimenez on 8/11/22.
//

import SwiftUI


struct ListView: View {
    @EnvironmentObject var quizzesModel: QuizzesModel
    @State var showFavourites: Bool = false
    @EnvironmentObject var acertadas: Acertadas
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                        Text("Recargar quizzes")
                    Spacer()
                        Button {
                            // Borrar el set de acertados cuando se recargan los quizzes
                            acertadas.idS.removeAll()
                            //Cargar quizzes desde url
                            quizzesModel.download()
                        } label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .resizable().scaledToFit().frame(width:30, height: 30)
                        }
                
                }.padding()
                    
                HStack {
                    Toggle("Mostrar favoritos", isOn: $showFavourites).onChange(of: showFavourites){ value in
                        quizzesModel.loadFavourites()
                    }
                }.padding()
                
                    List {
                        ForEach(showFavourites ? quizzesModel.favourites : quizzesModel.quizzes){quiz in
                            NavigationLink(destination: OneCard(item: quiz)) {
                                RowView(quiz: quiz)
                            }
                        }
                    }
                    .onAppear{
                        if quizzesModel.quizzes.count == 0{
                            quizzesModel.download()
                        }
                    }
                    .navigationBarTitle("QUIZ GAME")
                }
        }
    }
}
