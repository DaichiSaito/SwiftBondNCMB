import UIKit
import NCMB
class RootViewController: UITableViewController {
    
    private var items: [(title: String, className: String)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            (title: "Observable", className: "Observable"),
            (title: "View Binding", className: "Binding"),
            (title: "Combine multiple inputs", className: "CombineMultipleInputs"),
            (title: "NSNotification", className: "Notification"),
            (title: "ViewModel + TableView", className: "FavBindingStoryboard"),
            (title: "ViewModel + CollectionView", className: "NailCollectionView"),
        ]
        
        // メールアドレスとパスワードでログイン
        NCMBUser.logInWithMailAddressInBackground("hrkedz@gmail.com", password: "Megatonh4k2", block: ({(user, error) in
            if (error != nil){
                // ログイン失敗時の処理
//                self.modalView.dismissViewControllerAnimated(false, completion: nil)
//                let alertController = UIAlertController(title: "ログイン失敗です。", message: "IDまたはパスワードに誤りがあります。", preferredStyle: .Alert)
//                
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {
//                    (action:UIAlertAction!) -> Void in
//                    //                    self.closeMyView()
//                })
//                
//                alertController.addAction(defaultAction)
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
                
            }else{
                print("ログイン")
                // ログイン成功時の処理
//                self.modalView.dismissViewControllerAnimated(false, completion: nil)
//                let alertController = UIAlertController(title: "ログイン", message: "ログインしました。", preferredStyle: .Alert)
//                
//                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {
//                    (action:UIAlertAction!) -> Void in
//                    self.closeMyView()
//                })
//                alertController.addAction(defaultAction)
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        let storyboard = UIStoryboard(name: item.className, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        navigationController?.pushViewController(controller!, animated: true)
        controller!.title = item.title
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
