//
//  QuizzesModel.swift
//  Quiz con SwiftUI
//
//  
//

import Foundation
import SwiftUI

class QuizzesModel: ObservableObject {
    
    private let urlBase = "https://core.dit.upm.es"
    private let urlParams = "api/quizzes/random10wa?token"
    private let token = "c68198357677df7d340c"
    
    private var urlParamsFavourite = "api/users/tokenOwner/favourites"
    
    @Published private(set) var quizzes = [QuizItem]()
    @Published private(set) var favourites = [QuizItem]()

    func endpointFav(quizId: Int) -> URL? {
        let surl  = "\(urlBase)/\(urlParamsFavourite)/\(quizId)?token=\(token)"
       
            
        guard let url = URL(string: surl) else{
            print("Incorrect url")
            return nil
        }
        return url
    }
    
        /**
                    Function download
         It downloads quizzes from url (GET Api)
         
         */
    func download() {
        
        let url  = "\(urlBase)/\(urlParams)=\(token)"
            
        guard let URL = URL(string: url) else{
            print("Incorrect url")
            return
        }
        /* Creates new thread for queing the quizzes */
        DispatchQueue.global().async(){
            do{
                let data = try  Data(contentsOf: URL)
                    
                let quizzes = try JSONDecoder().decode([QuizItem].self, from: data)
                    
                DispatchQueue.main.async {
                    self.quizzes = quizzes
                    }
                    
            }catch{
                print("No se han descargado los quizzes \(error)")
            }
        }
        }
    
    /* Toggle controller: POST method for favourite toggle */
    func toggleFav(quizItemId : Int){
        guard let index = (quizzes.firstIndex{qui in qui.id == quizItemId})else{
            print("No se ha encontrado el id")
            return
        }

        guard let url = endpointFav(quizId: quizItemId) else {return}
        
        var req = URLRequest(url: url)
        req.httpMethod = quizzes[index].favourite ? "DELETE" : "PUT"
        
        /* Function PUT on DB for favourite change */
        URLSession.shared.uploadTask(with: req, from: Data()) {_, response, error in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                        print("Fallo en fav1")
                        return
            }
            DispatchQueue.main.async{
                /* Change from true to false and viceversa*/
                self.quizzes[index].favourite.toggle()
            }
            
        }
        .resume()
        }
    
    func loadFavourites(){
        favourites = quizzes.filter{$0.favourite}
        self.favourites = favourites
        print( "ARRAY DE FAVORITOS ===== \(favourites)")

    }
    }

        
