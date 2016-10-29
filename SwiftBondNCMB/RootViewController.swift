import UIKit

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
