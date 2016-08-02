//
//  ParentViewController.swift
//  FarmWell
//
//  Created by Aditya on 3/19/16.
//  Copyright © 2016 VinCorp. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    enum TabIndex : Int {
        case FirstChildTab = 0
        case SecondChildTab = 1
    }
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("FirstViewController")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController")
        return secondChildTabVC
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = TabIndex.FirstChildTab.rawValue
        displayCurrentTab(TabIndex.FirstChildTab.rawValue)
        self.navigationItem.title = segmentedControl.titleForSegmentAtIndex(TabIndex.FirstChildTab.rawValue)! + " Screen"
    }
    @IBAction func switchTabs(sender: UISegmentedControl)
    {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
        self.navigationItem.title = segmentedControl.titleForSegmentAtIndex(sender.selectedSegmentIndex)! + " Screen"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.FirstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.SecondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
