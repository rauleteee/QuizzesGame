//
//  OneCard.swift
//  quizzes1
//
//  Created by Raul Gimenez on 14/11/22.
//

import SwiftUI
import ConfettiSwiftUI
struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
        configuration.label.foregroundColor(.white).bold()
      Spacer()
    }
    .padding(10)
    .background(Color.orange.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.9 : 1)
    
  }
}

struct OneCard: View {
    var item: QuizItem
    @State var input: String = ""
    @State var isPressed = false
    @EnvironmentObject  var _acertadas :  Acertadas
    @EnvironmentObject var quizzesModel: QuizzesModel
    @State private var counter: Int = 0
    
    /*
     Variables que pertenecen a mejoras
     */
    @State var showAnswer = false
    @State private var counter2: Int = 0
    
    
    var body: some View{
        NavigationView{
                VStack{
                    let urlStrAuthor = item.author?.photo?.url;
                    let urlStr = item.attachment?.url;
                    HStack{
                        Text(item.question)
                            .fontWeight(.bold)
                            .italic()
                            .font(.title)
                            .foregroundColor(Color.orange)
                            .padding()
                        
                        
                        Button {
                            quizzesModel.toggleFav(quizItemId: item.id)
                        } label: {
                            item.favourite ?
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 25)
                            :
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 25)
                        }
                       
                    }
                    TextField("Inserte su respuesta", text:$input)
                        .frame(height: 44)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .shadow(radius: 10)
                        
                    
                        Button("CHECK"){
                            isPressed = true
                        }
                        .padding(.leading, 65)
                        .padding(.trailing, 65)
                        .confettiCannon(counter: $counter, num: 50)
                        .buttonStyle(RoundedRectangleButtonStyle())
                        .alert("Respuesta", isPresented: $isPressed, actions:{
                            Button("OK", action: {
                                if(input == item.answer){
                                    counter += 1
                                    _acertadas.incCount(quiz: item)
                                    print(_acertadas.idS)
                                }
                            })
                        },
                                message: {Text(input == item.answer ?"🎊🎊🎊 Correcto 🎊🎊🎊": "👻👻👻 Incorrecto 👻👻👻")}
                        )
                    Spacer()
                    VStack{
                        
                        //Quiz image
                        if(urlStr != nil){
                            let img = AsyncImage(url: urlStr){ image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                /* MEJORA OPCIONAL 1
                                 * Context menu: Long press on the image for openning the
                                 * context menu
                                 */
                                    .contextMenu {
                                        Button {
                                            input = ""
                                        } label: {
                                            Label("Clear input", systemImage: "clear")
                                        }
                                       
                                        Button{
                                            input = item.answer
                                        }label:{
                                            Label("Show the answer", systemImage: "eye")
                                        }
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .cornerRadius(10)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)

                            /* MEJORA OPCIONAL 2
                             * Tap gesture: touch two times on the image to hint the answer
                             * Gesture has two animations: confetti and scaleEffect of the image
                             * when pressing on it
                             */
                            
                            img
                                .gesture(TapGesture(count: 2).onEnded{
                                counter2 += 1
                                showAnswer = true
                                input = item.answer
                            })
                                .confettiCannon(counter: $counter2,
                                        num: 60,
                                        confettis:[.text("💀"), .text("👻")],
                                        confettiSize: 30)
                                .alert("HINT",
                                      isPresented: $showAnswer){
                                   Button("Try another quiz!"){}
                                }message:{
                                Text("You've chosen to be weak...")
                                }
                                .scaleEffect(showAnswer ? 0.8 : 1)
                                
                            //Hint description
                            VStack(alignment: .leading){
                                Text("[HINT #1] Tap two times on the image for uncovering the answer")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray)
                                    .italic()
                                   
                                Text("[HINT #2] Long press on image for more options")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray)
                                    .italic()
                            }  
                        }
                        
                    }
                    
                    
                    
                    Spacer()
                    Label{
                        Label{
                            Text(item.author?.username ?? "Unknown")
                                .foregroundColor(Color.gray)
                        }icon: {
                            //Author
                            AsyncImage(url: urlStrAuthor){ image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }// Muestra este placeholder indefinidamente
                            .frame(width: 30, height: 30, alignment: .top)
                            .clipShape(Circle())
                            
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                    }icon:{
                        Text(String(_acertadas.idS.count))
                            .padding(30)
                            .font(.system(size: 20))
                            .bold()
                            .shadow(color: Color.orange, radius: 2)
                    }
                    
                    

                
           
                
            }
            
        
        }.navigationBarTitle("Play", displayMode: .inline)
           
        }
            
}



