import NCMB
import Bond
struct Fav {
    let objectId = Observable<String?>("")
    let userName = Observable<String?>("")
    let favFlg = Observable<Bool?>(false)
//    let salonPointer = Observable<NCMBObject?>(NCMBObject(className: ""))
    let myName = Observable<String?>("")
    let imageObjectId = Observable<String?>("")
    
    //    let message: String
    //    let averageCost: String
    //    let salonName: String
    //    let artistName: String
    //    let artworklURL: String
    
    init(fav: NCMBObject) {
        self.objectId.value = fav.objectId
        self.userName.value = fav.objectForKey("userName") as? String
        self.favFlg.value = fav.objectForKey("favFlg") as? Bool
        self.myName.value = fav.objectForKey("myName") as? String
        self.imageObjectId.value = fav.objectForKey("imageObjectId") as? String
        
    }
    init() {
        self.objectId.value = ""
        self.userName.value = ""
        self.favFlg.value = false
        self.myName.value = ""
        self.imageObjectId.value = ""
    }
    
}