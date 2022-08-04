//
//  HomeModel.swift
//  iChat
//
//  Created by Darío Gallegos on 3/8/22.
//

import FirebaseFirestore
import SwiftUI

class HomeModel: ObservableObject {
    
    @Published var messages: [MessageModel] = []
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    
    init() {
        fetchMessages()
    }
    
    func onAppear() {
        
        //Checking user is joined
        if user == "" {
            let application = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            
            application?.rootViewController?.present(showAlertJoin(), animated: true)
        }
    }
    
    func showAlertJoin() -> UIAlertController {
        let alert = UIAlertController(title: "Join chat", message: "Enter you nick", preferredStyle: .alert)
        
        alert.addTextField { text in
            text.placeholder = "example dario"
        }
        
        let join = UIAlertAction(title: "Join", style: .default) { _ in
            
            let user = alert.textFields?[0].text ?? ""
            if user != "" {
                self.user = user
                return
            }
            
            let application = UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }
            
            application?.rootViewController?.present(alert, animated: true)
        }
        alert.addAction(join)
        
        return alert
    }
}

extension HomeModel {
    func fetchMessages() {
        ref.collection("Messages").addSnapshotListener { snap, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = snap else { return }
            
            data.documentChanges.forEach { document in
                if document.type == .added {
                    do {
                        print("data", document.document.data())
                        let message = try document.document.data(as: MessageModel.self)
                        
                        DispatchQueue.main.async {
                            self.messages.append(message)
                        }
                    } catch {
                        print("Error al leer los datos de firebase")
                    }
                }
            }
        }
    }
}
