//
//  Firebase-Extension.swift
//  TinderSampleApp
//
//  Created by 清水世那 on 2021/07/01.
//


import Firebase

//MARK: - Auth
extension Auth {
    static func createUserToFireAuth (email:String?,password:String?,name:String?,completion :@escaping (Bool) ->()) {
        guard let email = email else {return}
        guard let password = password else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { auth, error in
            if let e = error {
                print("auth情報の保存に失敗",e)
                return
            }
            guard let uid = auth?.user.uid else {return}
            print("uidの取得に成功",uid)
            Firestore.setUserDateToFirestore(uid: uid, email: email,name:name) { success in
                completion(success)
            }
        }
    }
}


//MARK: - Firestore
extension Firestore {
    static func setUserDateToFirestore(uid:String,email:String,name:String?,completion:@escaping (Bool) -> ()) {
        
        guard let name = name else { return }
        let document = [
            "name": name,
            "email" : email,
            "createAt" : Timestamp()
        ] as [String : Any]
        Firestore.firestore().collection("users").document(uid).setData(document) { error in
            if let e = error {
                print("ユーザー情報の保存に失敗しました",e)
            }
            completion(true)
            print("firestore保存成功")
        }
    }
}
