import NCMB
import Bond
import Foundation

class Nail2 {
    
//    let imagePath = Observable<String?>("")
    let userName = Observable<String?>("")
    let objectId = Observable<String?>("")
    let comment = Observable<String?>("")
    let favFlg = Observable<Bool?>(nil)
    let salonPointer = Observable<NCMBObject?>(NCMBObject(className: ""))
    let status = Observable<String?>("")
    let kawaiine = Observable<Int?>(0)
    let nailImage : Observable<UIImage?>
    let favImage : Observable<UIImage?>
    let nailImagePath : NSURL?
    
//    let message: String
//    let averageCost: String
//    let salonName: String
    //    let artistName: String
    //    let artworklURL: String
    
    init(nail: NCMBObject) {
        self.objectId.value = nail.objectId
//        self.imagePath.value = nail.objectForKey("imagePath") as? String
        self.userName.value = nail.objectForKey("userName") as? String
        self.comment.value = nail.objectForKey("comment") as? String
//        self.favFlg.value = false
        self.salonPointer.value = nail.objectForKey("salonPointer") as? NCMBObject
        self.status.value = nail.objectForKey("status") as? String
        self.kawaiine.value = nail.objectForKey("kawaiine") as? Int
        self.favImage = Observable<UIImage?>(nil) // initially no image
        self.nailImage = Observable<UIImage?>(nil) // initially no image
        self.nailImagePath = NSURL(string: (nail.objectForKey("imagePath") as? String!)!)

        
    }
//    init() {
//        self.objectId.value = ""
//        self.imagePath.value = ""
//        self.userName.value = ""
//        self.comment.value = ""
//        self.favFlg.value = false
//        self.salonPointer.value = nil
//        self.status.value = ""
//        self.kawaiine.value = 0
////        self.message = ""
////        self.averageCost = ""
////        self.salonName = ""
//    }
    func fetchImageIfNeeded(){
        if self.nailImage.value != nil {
            print("already have photo")
            // already have photo
            return
        }
        if let nailImagePath = self.nailImagePath {
            let downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(nailImagePath) {
                [weak self] location, response, error in
                if let location = location {
                    if let data = NSData(contentsOfURL: location) {
                        if let image = UIImage(data: data) {
                            dispatch_async(dispatch_get_main_queue()) {
                                // this will automatically update photo in bonded image view
                                print(self?.objectId.value!)
                                self?.nailImage.value = image
                                return
                            }
                        }
                    }
                }
            }
            downloadTask.resume()
        }
    }
    
    func fetchFavIfNeeded(viewModel: FavBindingViewModel) {
//        if self.favImage.value != nil {
//            print("already have fav")
//            return
//        }
//        print("dont have fav")
//        viewModel.favArray2.map{[weak self] a in
////            print(a)
//            if (a == self?.objectId.value) {
//                self?.favImage.value = UIImage(named: "heart_like.jpg")
//                return
//            } else {
////                self?.favImage.value = UIImage(named: "heart_unlike.jpg")
//            }
//        }
        for i in 0..<viewModel.favArray2.count {
            if (self.objectId.value! == viewModel.favArray2[i]) {
                self.favImage.value = UIImage(named: "heart_like.jpg")
                return
            } else {
                //                self.favImage.value = UIImage(named: "heart_unlike.jpg")
            }
        }
        self.favImage.value = UIImage(named: "heart_unlike.jpg")
//        for i in 0..<viewModel.favArray2.count {
//            print(i)
//            print(viewModel.favArray2[i])
//            if (viewModel.favArray2[i] == self.objectId.value!) {
////                self.favFlg.next(true)
//                self.favImage.value = UIImage(named: "heart_like.jpg")
//            } else {
//                self.favImage.value = UIImage(named: "heart_unlike.jpg")
////                self.favFlg.next(false)
//            }
//        }
        
    }
    func fetchFavIfNeeded() {
        if self.favImage.value != nil {
            print("already have fav")
            return
        }
//        self.favImage.value = UIImage(named: "heart_like.jpg")
        let tmp = ["h6yNmukqM4f2yaia","YrKipC9Rr3XSdxRZ","8uErFo056THHXERZ","MjjnHdY1EPoOrpOK"]
        
        for i in 0..<tmp.count {
            if (self.objectId.value! == tmp[i]) {
                self.favImage.value = UIImage(named: "heart_like.jpg")
                return
            } else {
//                self.favImage.value = UIImage(named: "heart_unlike.jpg")
            }
        }
        self.favImage.value = UIImage(named: "heart_unlike.jpg")
//        tmp.map{[weak self](aaa) -> Void in
////                        print(a)
////            print(self?.objectId.value!)
////            print(a == self?.objectId.value!)
//            if (aaa == self?.objectId.value!) {
//                self?.favImage.value = UIImage(named: "heart_like.jpg")
//                return
//            } else {
//                self?.favImage.value = UIImage(named: "heart_unlike.jpg")
//            }
//        }
        //        for i in 0..<viewModel.favArray2.count {
        //            print(i)
        //            print(viewModel.favArray2[i])
        //            if (viewModel.favArray2[i] == self.objectId.value!) {
        ////                self.favFlg.next(true)
        //                self.favImage.value = UIImage(named: "heart_like.jpg")
        //            } else {
        //                self.favImage.value = UIImage(named: "heart_unlike.jpg")
        ////                self.favFlg.next(false)
        //            }
        //        }
        
        
//        if let nailImagePath = self.nailImagePath {
//            let downloadTask = NSURLSession.sharedSession().downloadTaskWithURL(nailImagePath) {
//                [weak self] location, response, error in
//                if let location = location {
//                    if let data = NSData(contentsOfURL: location) {
//                        if let image = UIImage(data: data) {
//                            dispatch_async(dispatch_get_main_queue()) {
//                                // this will automatically update photo in bonded image view
//                                print(self?.objectId.value!)
//                                self?.favImage.value = image
//                                return
//                            }
//                        }
//                    }
//                }
//            }
//            downloadTask.resume()
//        }

        
    }

    
}