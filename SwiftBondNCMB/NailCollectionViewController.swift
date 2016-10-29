//
//  NailCollectionViewController.swift
//  SwiftBondNCMB
//
//  Created by DaichiSaito on 2016/10/25.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
//import AlamofireImage
//import AFNetworking
//import AFNetworking

class NailCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let nailViewModel = NailViewModel()
    private var nail = ObservableArray<ObservableArray<Nail>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nail = [nailViewModel.nails]
        nailViewModel.loadImageData()
        
        nail.bindTo(collectionView) { indexPath, dataSource, collectionView in
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! NailCollectionViewCell
            let dataSource = dataSource[indexPath.section][indexPath.item]
            
//            let url = NSURL(string: dataSource.imagePath)!
//            var err: NSError?;
//            var imageData :NSData = NSData(contentsOfURL: url,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
//            var img = UIImage(data:imageData);
            
            let url = NSURL(string: dataSource.imagePath.value!)!
//            let imgData:NSData
//            
//            do{
//                imgData = try NSData(contentsOfURL:url,options:NSDataReadingOptions.DataReadingMappedIfSafe)
//                let img = UIImage(data:imgData);
//                cell.imageView.image = img
////                let imgView=UIImageView(image:img);
////                imgView.frame=CGRectMake(0,0,100,50);
////                self.view.addSubview(imgView);
//            }catch{
//                print("Error: can't create image.")
//            }
//            cell.imageView.se(NSURL(string: dataSource.artworklURL)!)
            cell.imageView.setImageWithURL(url, placeholderImage: nil)
            
            return cell
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = self.collectionView!.indexPathForCell(cell)
        let controller = segue.destinationViewController as! EditViewController
//        controller.imageCollectionObject = mModel!.imageInfo[indexPath!.row] as? NCMBObject
//        nailViewModel.setCurrentNail(nailViewModel.nails[indexPath!.row])
        controller.setNail(nailViewModel.nails[indexPath!.row])
//        controller.nail = nailViewModel.nails[indexPath!.row]
    }

}
