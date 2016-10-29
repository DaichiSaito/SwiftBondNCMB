//
//  EditViewController.swift
//  SwiftBondNCMB
//
//  Created by DaichiSaito on 2016/10/26.
//  Copyright © 2016年 DaichiSaito. All rights reserved.
//

import UIKit
import Bond
import NCMB
class EditViewController: UIViewController {

    private let nailViewModel = NailViewModel()
//    private var nail = ObservableArray<ObservableArray<Nail>>()
    private var nail = Observable<Nail>(Nail())
//    private let nailViewModel = NailViewModel()
    
    
    @IBOutlet weak var averageCostTextField: UITextField!
    @IBOutlet weak var salonNameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        nailViewModel.setCurrentNail(nail)
        setupBind()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func setNail(nail: Nail) {
//        self.nail = Observable(nail)
        nailViewModel.setCurrentNail(nail)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setupBind() {
//        nailViewModel.message.bidirectionalBindTo(commentTextField.bnd_text)
        nailViewModel.getCurrentNail().salonName.bidirectionalBindTo(salonNameTextField.bnd_text)
        nailViewModel.getCurrentNail().averageCost.bidirectionalBindTo(averageCostTextField.bnd_text)
        nailViewModel.getCurrentNail().message.bidirectionalBindTo(commentTextField.bnd_text)
        
        updateButton.bnd_controlEvent.filter { $0 == .TouchUpInside }.observe {[weak self] _ -> Void in
            print("updateButton.bnd_controlEvent")
            self?.nailViewModel.registerSalonInfomation()
        }
    }

}
