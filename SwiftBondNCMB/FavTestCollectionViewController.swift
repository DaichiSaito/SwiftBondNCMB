//
//  FavTestCollectionViewController.swift
//  SwiftBondNCMB
//
//  Created by DaichiSaito on 2016/10/29.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
class FavTestCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = FavBindingViewModel()
    private var nail = ObservableArray<ObservableArray<Nail2>>()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        self.nail = [viewModel.nails]
        viewModel.loadImageData()
        
        nail.bindTo(collectionView) { indexPath, dataSource, collectionView in
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favTestCell", forIndexPath: indexPath) as! FavTestCollectionViewCell
            let dataSource = dataSource[indexPath.section][indexPath.item]
            let url = NSURL(string: dataSource.imagePath)!
            cell.contentsImageView.setImageWithURL(url, placeholderImage: nil)
            
            return cell
        }
//        nail.bind(to: collectionView) { array, indexPath, collectionView in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RepositoryCell
//            let repository = array[indexPath.item]
//            
//            repository.name
//                .bindTo(cell.nameLabel)
//                .disposeIn(cell.onReuseBag)
//            
//            repository.photo
//                .bindTo(cell.avatarImageView)
//                .disposeIn(cell.onReuseBag)
//            
//            return cell
//        }

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
    /* 一つのセルのサイズ設定処理 */
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        
//        // 2カラム
//        let width: CGFloat = super.view.frame.width / 2
//        let height: CGFloat = width
//        
//        return CGSize(width: width, height: height) // The size of one cell
//        
//    }

}
