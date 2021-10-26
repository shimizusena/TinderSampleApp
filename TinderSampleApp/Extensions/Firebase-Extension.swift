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
            "createAt" : Timestamp(),
            "uid":uid
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
            .document(uid).addSnapshotListener{ snapshot, err in

                
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
            
            let filterdUsers = users?.filter({ (user) -> Bool in
                return user.uid != Auth.auth().currentUser?.uid
            })
            completion(users ?? [User]())
        }
    }
    
//    ユーザー情報更新
    static func updateUserInfo(dic:[String:Any],completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).updateData(dic) { err in
            if let err = err {
                print("ユーザー情報アップデート失敗",err)
            }
            completion()
            print("ユーザー情報更新に成功")
        }
    }
}

//MARK: - Storage

extension Storage {
    
//    ユーザー情報をFireStrageに保存
    static func addProfileImageToStorage(image:UIImage,dic:[String:Any],completion: @escaping () -> Void) {
        guard  let uploadImage = image.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("profile_image").child(filename)
        
        
        
        storageRef.putData(uploadImage, metadata: nil) { metadata, error in
            
            if let err = error {
                print("画像の保存に失敗しました",err)
                return
            }
            storageRef.downloadURL { url, error in
                if let err = error {
                    print("画像の取得に失敗")
                    return
                }
                guard let urlString = url?.absoluteString else {return}
                var dicWithImage = dic
                dicWithImage["profileImageUrl"] = urlString
                
                Firestore.updateUserInfo(dic: dicWithImage) {
                    completion()
                }
            }
                print("画像の保存に成功しました")
        }
    }
}
