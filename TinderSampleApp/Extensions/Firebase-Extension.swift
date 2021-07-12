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
    static func loginWithFireAuth(email:String,password:String,completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログインに失敗: ", err)
                completion(false)
                return
            }
            
            print("ログインに成功")
            completion(true)
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
    
//    FireStoreからユーザー情報を取得
    static func fetchUserFromFirestore(uid:String,completion: @escaping (User?) -> Void) {
        
        Firestore.firestore().collection("users")
            .document(uid).getDocument { snapshot, err in
                
                if let err = err {
                    print("ユーザー情報を取得に失敗")
                    completion(nil)
                    return
                }
                
                guard let dic = snapshot?.data() else {return}
                let user = User(dic: dic)
                completion(user)
            }
    }
    
//    Firebaseから自分の情報以外のUser情報を取得
    static func fetchUsersFromFirestore (completion:@escaping ([User]) -> Void) {
        
        Firestore.firestore().collection("users").getDocuments { snapshots, err in
            if let err = err {
                print("ユーザー上方の取得に失敗",err)
                return
            }
            let users = snapshots?.documents.map({ (snapshot) -> User in
                let dic = snapshot.data()
                let user = User(dic: dic)
                return user
            })
            completion(users ?? [User]())
        }
    }
}
