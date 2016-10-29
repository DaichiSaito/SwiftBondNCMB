import NCMB
struct Nail2 {
    
    let imagePath: String
    let userName: String
    let objectId: String
    let comment: String
//    let message: String
//    let averageCost: String
//    let salonName: String
    //    let artistName: String
    //    let artworklURL: String
    
    init(nail: NCMBObject) {
        self.objectId = nail.objectId
        self.imagePath = nail.objectForKey("imagePath") as! String
                self.userName = nail.objectForKey("userName") as! String
                self.comment = nail.objectForKey("comment") as! String
//        self.message = nail.objectForKey("message") as! String
//        self.averageCost = nail.objectForKey("averageCost") as! String
//        self.salonName = nail.objectForKey("salonName") as! String
        //        self.artistName = json["artistName"].stringValue
        //        self.artworklURL = json["artworkUrl100"].stringValue
    }
    init() {
        self.objectId = ""
        self.imagePath = ""
        self.userName = ""
        self.comment = ""
//        self.message = ""
//        self.averageCost = ""
//        self.salonName = ""
    }
    
}