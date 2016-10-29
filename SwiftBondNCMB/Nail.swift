import NCMB
import Bond
struct Nail {
    
//    let imagePath: String
//    let objectId: String
//    let message: String
//    let averageCost: String
//    let salonName: String
    let imagePath = Observable<String?>("")
    let objectId = Observable<String?>("")
    let message = Observable<String?>("")
    let averageCost = Observable<String?>("")
    let salonName = Observable<String?>("")
    
    init(nail: NCMBObject) {
        self.objectId.value = nail.objectId
        self.imagePath.value = nail.objectForKey("imagePath") as! String
//        self.userName = nail.objectForKey("userName") as! String
//        self.comment = nail.objectForKey("comment") as! String
        self.message.value = nail.objectForKey("message") as! String
        self.averageCost.value = nail.objectForKey("averageCost") as! String
        self.salonName.value = nail.objectForKey("salonName") as! String
//        self.artistName = json["artistName"].stringValue
//        self.artworklURL = json["artworkUrl100"].stringValue
    }
    init() {
        self.objectId.value = ""
        self.imagePath.value = ""
//        self.userName = ""
//        self.comment = ""
        self.message.value = ""
        self.averageCost.value = ""
        self.salonName.value = ""
    }
    
}