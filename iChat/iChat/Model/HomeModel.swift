//
//  HomeModel.swift
//  iChat
//
//  Created by Darío Gallegos on 3/8/22.
//

import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class HomeModel: ObservableObject {
    
    @Published var messages: [MessageModel] = []
    @Published var inputText: String = ""
    @Published var selectedImage: UIImage?
    
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    
    init() {
        readMessages()
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
    func readMessages() {
        ref.collection("Messages").order(by: "timestamp").addSnapshotListener { snap, error in
            
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
    
    func writeMessages() {
        let data = MessageModel(user: user, message: inputText, timestamp: Date())
        
        do {
            let _ = try ref.collection("Messages").addDocument(from: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                self.inputText = ""
            }
        } catch {
            
        }
    }
    
    func uploadPhoto() {
        //Make sure that selected image property isn´t nil
        
        guard selectedImage != nil else {
            return
        }
        
        //Create storage reference
        let storageRef = Storage.storage().reference()
        
        //Turn our image in data
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        
        //Check imageData is not nil
        guard let data = imageData else {
            return
        }
        
        //Specific the file path and name
        let fileRef = storageRef.child("images/\(UUID().uuidString)")
        
        // Upload that data
        let uploadTask = fileRef.putData(data, metadata: nil) { metadata, error in
            
            if let error = error  {
                print("Error \(error)")
            }
            
            if let _ = metadata {
                print("Ha ido todo bien")
            }
        }
        
        
    }
}
