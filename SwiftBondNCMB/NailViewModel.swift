import UIKit
import Bond
import NCMB
//import Alamofire
//import SwiftyJSON

class NailViewModel {
    
    internal let nails = ObservableArray<Nail>()
    internal var nailComment = Observable<String?>("")
    internal let nailObjectId = Observable<String?>("")
    internal let nailImagePath = Observable<String?>("")
    internal let salonName = Observable<String?>("")
    internal let message = Observable<String?>("")
    internal let averageCost = Observable<String?>("")
    
    private let urlString = "https://itunes.apple.com/search"
    private let parameters = ["term":"Swift",
                              "entity":"musicTrack",
                              "limit":"30"]
    
    var currentNail: Nail? = nil
    
//    internal func reload() {
//        Alamofire.request(.GET, urlString, parameters: parameters).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let jsons = JSON(value)
//                    for i in 0...jsons["results"].count {
//                        let album = Album(json: jsons["results"][i])
//                        self.albums.append(album)
//                    }
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func setCurrentNail(nail: Nail) {
        self.currentNail = nail
//        self.nailComment.value = (currentNail?.comment)!
//        self.nailObjectId.value = (currentNail?.objectId.value)!
//        self.nailImagePath.value = (currentNail?.imagePath.value)!
//        self.salonName.value = (currentNail?.salonName.value)!
//        self.message.value = (currentNail?.message.value)!
//        self.averageCost.value = (currentNail?.averageCost.value)!
    }
    
    func getCurrentNail() -> Nail {
        return self.currentNail!
    }
    
    func loadImageData() {
        
        var query: NCMBQuery?
        query = NCMBQuery(className: "salon")
        query!.orderByDescending("createDate")
        query!.limit = 1000
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
//                    self.imageInfo = objects
                    for i in 0..<objects.count {
                        let nail = Nail(nail: objects[i] as! NCMBObject)
                        self.nails.append(nail)
                    }
                    
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }
    
    func registerSalonInfomation() {
        
        let targetSalonInfomation: NCMBObject = NCMBObject(className: "salon")
        
//        if (!(param1["shinkiFlg"] as! Bool)) {
//            // 新規登録じゃない場合
//            targetSalonInfomation = self.salonInformation[0] as! NCMBObject
//            
//        } else {
//            targetSalonInfomation = NCMBObject(className: "salon")
//            
//        }
        // objectId
        targetSalonInfomation.objectId = self.nailObjectId.value
        
        // メッセージ
        targetSalonInfomation.setObject(self.message.value, forKey:"message")
        // サロン名
        targetSalonInfomation.setObject(self.salonName.value, forKey:"salonName")
//        // 住所（地域１）
//        targetSalonInfomation.setObject(param1["locationPrefecture"], forKey:"locationPrefecture")
//        // 住所（地域２）
//        targetSalonInfomation.setObject(param1["locationCity"], forKey:"locationCity")
//        // 住所（正式）
//        targetSalonInfomation.setObject(param1["fullAddress"], forKey:"fullAddress")
//        // 営業時間
//        targetSalonInfomation.setObject(param1["openTime"], forKey:"openTime")
//        // 定休日
//        targetSalonInfomation.setObject(param1["closeDay"], forKey:"closeDay")
//        // 平均予算
//        targetSalonInfomation.setObject(param1["averageCost"], forKey:"averageCost")
//        // URL
//        targetSalonInfomation.setObject(param1["url"], forKey:"url")
//        // 電話番号
//        targetSalonInfomation.setObject(param1["tel"], forKey:"tel")
//        // メールアドレス
//        targetSalonInfomation.setObject(param1["mailAddress"], forKey:"mailAddress")
//        // LINE
//        targetSalonInfomation.setObject(param1["lineId"], forKey:"lineId")
//        
//        if param1["time"] != nil {
//            // timeがnilじゃない場合（サムネイル画像変更があった場合）
//            let time = param1["time"] as! String
//            // プロフィール画像設定
//            targetSalonInfomation.setObject(urlUploadSalonThumbNailImagesLocation + time + ".jpg", forKey: "imagePath")
//        }
        
        //                targetSalonInfomation.setObject(param1["mailAddress"], forKey:"mailAddress")
        //                targetSalonInfomation.setObject(param1["tel"], forKey:"tel")
        //                targetSalonInfomation.setObject(param1["locationPrefecture"], forKey:"locationPrefecture")
        //                targetSalonInfomation.setObject(param1["locationCity"], forKey:"locationCity")
        //                targetSalonInfomation.setObject(param1["salonName"], forKey:"salonName")
        //                targetSalonInfomation.setObject(param1["lineId"], forKey:"lineId")
        //                targetSalonInfomation.setObject(param1["url"], forKey:"url")
        ////                targetSalonInfomation.setObject(param1["averageAge"], forKey:"averageAge")
        //                targetSalonInfomation.setObject(param1["averageCost"], forKey:"averageCost")
        //                targetSalonInfomation.setObject(param1["campane"], forKey:"campane")
        //                carrentUser.setObject(salonObject, forKey: "salonPointer")
        
        
//        if (!(param1["shinkiFlg"] as! Bool)) {
            // 新規登録じゃない場合
            targetSalonInfomation.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
                print("サロン登録完了")
//                if (self.imageUploadFlg) {
//                    print("サロン情報更新・画像アップロードどっちもできたぜ")
//                    self.uploadDoneFlg = true
//                } else {
//                    print("画像のアップロードがまだできてないぜ")
//                    self.salonInfoUploadFlg = true
//                }
            })
            
            
//        } else {
//            let currentUser = NCMBUser.currentUser()
//            targetSalonInfomation.setObject(currentUser, forKey: "userPointer")
//            currentUser.setObject(targetSalonInfomation, forKey: "salonPointer")
//            currentUser.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
//                print("サロン登録完了")
//                if (self.imageUploadFlg) {
//                    print("サロン情報更新・画像アップロードどっちもできたぜ")
//                    self.uploadDoneFlg = true
//                } else {
//                    print("画像のアップロードがまだできてないぜ")
//                    self.salonInfoUploadFlg = true
//                }
//            })
//            
        }

    
}