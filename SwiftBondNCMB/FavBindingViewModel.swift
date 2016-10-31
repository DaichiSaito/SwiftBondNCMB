import UIKit
import Bond
import NCMB
//import Alamofire
//import SwiftyJSON

class FavBindingViewModel {
    
    internal let nails = ObservableArray<Nail2>()
    internal let favs = ObservableArray<Fav>()
    internal var nailComment = Observable<String?>("")
    internal let nailObjectId = Observable<String?>("")
    internal let nailImagePath = Observable<String?>("")
    internal let salonName = Observable<String?>("")
    internal let message = Observable<String?>("")
    internal let averageCost = Observable<String?>("")
    internal var favArray: NSMutableArray?
    internal var favArray2 = [""]
    var currentSkip: Int32? = 0
    
    var favNCMBObject: NSArray = NSArray()
    internal var favs2 = ObservableArray<NCMBObject>()
    
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
        self.nailObjectId.value = (currentNail?.objectId.value)!
        self.nailImagePath.value = (currentNail?.imagePath.value)!
        self.salonName.value = (currentNail?.salonName.value)!
        self.message.value = (currentNail?.message.value)!
        self.averageCost.value = (currentNail?.averageCost.value)!
    }
    
    func loadImageData() {
        
        var query: NCMBQuery?
        query = NCMBQuery(className: "image")
        query!.orderByDescending("createDate")
        query!.limit = 10
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
                    //                    self.imageInfo = objects
                    for i in 0..<objects.count {
                        let nail = Nail2(nail: objects[i] as! NCMBObject)
                        self.nails.append(nail)
                    }
                    self.currentSkip = 10
                    
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }
    
    func loadImageDataMore() {
        
        var query: NCMBQuery?
        query = NCMBQuery(className: "image")
        query!.orderByDescending("createDate")
        query!.limit = 10
//        query!.whereKey("createDate", lessThanOrEqualTo: self.currentSortKey)
        query!.skip = self.currentSkip!
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
                    
                    //                    self.imageInfo = objects
                    for i in 0..<objects.count {
                        let nail = Nail2(nail: objects[i] as! NCMBObject)
                        self.nails.append(nail)
                        
                    }
                    self.currentSkip = self.currentSkip! + 10
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }
    func loadFavData() {
        
        var query: NCMBQuery?
        query = NCMBQuery(className: "Fav")
        query!.orderByDescending("createDate")
        query!.whereKey("myName", equalTo: NCMBUser.currentUser().userName)
        query!.whereKey("favFlg", equalTo: true)
//        query!.whereKey("myName", equalTo: "oSOqdRkJvK")
        query!.limit = 1000
        query!.findObjectsInBackgroundWithBlock({(objects, error) in
            
            if error == nil {
                
                if objects.count > 0 {
//                    self.favNCMBObject = objects
//                    self.favs.array = objects
                    //                    self.imageInfo = objects
                    for i in 0..<objects.count {
                        
//                        self.favNCMBObject = objects as? NCMBObject
                        let fav = Fav(fav: objects[i] as! NCMBObject)
                        self.favs.append(fav)
                        let imageObjectId: String = ((objects[i].objectForKey("imageObjectId") as? String))!
//                        self.favArray2.append((objects[i].objectForKey("imageObjectId") as! String))
                        if (((objects[i].objectForKey("favFlg") as? Bool))!) {
                                self.favArray2.append(imageObjectId)
                        }
                        
//                        self.favArray!.addObject(fav.objectId.value!)
                    }
                    
                }
                
            } else {
                print("エラー")
                print(error.localizedDescription)
            }
        })
    }
    func setFavImage(favImageView: UIImageView, targetDataSource: Nail2) {
        let targetObjectId = targetDataSource.objectId
        
        for i in 0..<favArray2.count {
            if (favArray2[i] == targetObjectId.value!) {
                favImageView.image = UIImage(named: "heart_like.jpg")
                return
            } else {
                favImageView.image = UIImage(named: "heart_unlike.jpg")
            }
        }
//        if ((favArray?.containsObject(targetObjectId.value!)) != nil) {
//            favImageView.image = UIImage(named: "heart_like.jpg")
//        } else {
//            favImageView.image = UIImage(named: "heart_unlike.jpg")
//        }
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