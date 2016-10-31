//
//  FavTestCollectionViewController.swift
//  SwiftBondNCMB
//
//  Created by DaichiSaito on 2016/10/29.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
import ICSPullToRefresh
class FavTestCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = FavBindingViewModel()
    private var nail = ObservableArray<ObservableArray<Nail2>>()
    
    var k = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        collectionView.delegate = self
//        collectionView.dataSource = self
        setRefreshControl()
        self.nail = [viewModel.nails]
        viewModel.loadImageData()
        viewModel.loadFavData()
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        self.setInfinit()
        
        nail.bindTo(collectionView) { indexPath, dataSource, collectionView in
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favTestCell", forIndexPath: indexPath) as! FavTestCollectionViewCell
            let dataSource = dataSource[indexPath.section][indexPath.item]
            dataSource.nailImage
                .bindTo(cell.contentsImageView.bnd_image)
                .disposeIn(cell.bnd_bag)
            
            dataSource.favImage
                .bindTo(cell.favImageView.bnd_image)
                .disposeIn(cell.bnd_bag)
            
//            let num = Observable<Int>(0)
//            num.observe { (num) -> Void in
//                print("契約1")
//            }
            
//            dataSource.userName.observe{(a) -> Void in
//                
//            }
            
//            dataSource.favFlg.observe {(favFlg) -> Void in
//                if ((favFlg) != nil && favFlg!) {
//                    dataSource.favImage.value = UIImage(named: "heart_like.jpg")
//                } else {
//                    dataSource.favImage.value = UIImage(named: "heart_unlike.jpg")
//                }
//            }.disposeIn(cell.bnd_bag)
            
            dataSource.fetchImageIfNeeded()
            dataSource.fetchFavIfNeeded(self.viewModel)
//            dataSource.fetchFavIfNeeded()
//            let url = NSURL(string: dataSource.imagePath.value!)!
//            cell.contentsImageView.setImageWithURL(url, placeholderImage: nil)
//            cell.favImageView.image = UIImage(named: "heart_unlike.jpg")
//            viewModel.favs
//            self.viewModel.setFavImage(cell.favImageView,targetDataSource: dataSource)
            
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
    // リフレッシュ用の処理をセット
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        //下に引っ張った時に、リフレッシュさせる関数を実行する。”：”を忘れがちなので注意。
        refreshControl.addTarget(self, action: #selector(self.reloadCollection(_:)), forControlEvents: UIControlEvents.ValueChanged)
        //UICollectionView上に、ロード中...を表示するための新しいビューを作る
        self.collectionView?.backgroundView = refreshControl
        self.collectionView.alwaysBounceVertical = true
    }
    
    //リフレッシュさせる
    func reloadCollection(sender:AnyObject) {
        sender.beginRefreshing()
        viewModel.loadImageData()
        sender.endRefreshing()
    }
    
    func setInfinit() {
        
        self.collectionView.addPullToRefreshHandler {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                //                sleep(3)
                self.k = 0;
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView.pullToRefreshView?.stopAnimating()
                })
            })
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64) (1 * NSEC_PER_SEC) ), dispatch_get_main_queue()) { () -> Void in
            self.collectionView.triggerPullToRefresh()
        }
        
        self.collectionView.addInfiniteScrollingWithHandler {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                //                sleep(3)
                dispatch_async(dispatch_get_main_queue(), { [unowned self] in
                    
                    self.k += 1
                    self.viewModel.loadImageDataMore()
//                    self.collectionView.reloadData()
                    self.collectionView.infiniteScrollingView?.stopAnimating()
                    })
            })
        }

        
        
        
//        self.collectionView.addInfiniteScrollingWithHandler {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//                sleep(3)
//                dispatch_async(dispatch_get_main_queue(), { [unowned self] in
//                    
////                    self.k += 1
//                    
////                    self.collectionView.infiniteScrollingView?.startAnimating()
////                    self.viewModel.loadImageDataMore()
//                    self.collectionView.reloadData()
//                    self.collectionView.infiniteScrollingView?.stopAnimating()
//                    })
//            })
//        }
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionView.addPullToRefreshHandler {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
////                sleep(3)
//                self.k = 0;
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.collectionView.pullToRefreshView?.stopAnimating()
//                })
//            })
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64) (1 * NSEC_PER_SEC) ), dispatch_get_main_queue()) { () -> Void in
//            self.collectionView.triggerPullToRefresh()
//        }
//        
//        collectionView.addInfiniteScrollingWithHandler {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
////                sleep(3)
//                dispatch_async(dispatch_get_main_queue(), { [unowned self] in
//                    
//                    self.k += 1
//                    self.collectionView.reloadData()
//                    self.collectionView.infiniteScrollingView?.stopAnimating()
//                    })
//            })
//        }
//        
//    }

    

}
