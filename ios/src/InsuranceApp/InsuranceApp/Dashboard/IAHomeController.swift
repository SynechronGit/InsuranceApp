//
//  IAHomeController.swift
//  InsuranceApp
//
//  Created by rupendra on 5/31/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

class IAHomeController: IABaseController {
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var dashboardTabItemView: UIView!
    @IBOutlet weak var dashboardContainerView: UIView!
    @IBOutlet weak var dashboardImageView: UIImageView!
    @IBOutlet weak var dashboardTabContentViewLeadingConstraint: NSLayoutConstraint!
    weak var dashboardController: IADashboardController!
    
    @IBOutlet weak var fileClaimTabItemView: UIView!
    @IBOutlet weak var fileClaimContainerView: UIView!
    @IBOutlet weak var fileClaimImageView: UIImageView!
    @IBOutlet weak var fileClaimTabContentViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var policiesTabItemView: UIView!
    @IBOutlet weak var policiesContainerView: UIView!
    @IBOutlet weak var policiesImageView: UIImageView!
    @IBOutlet weak var policiesTabContentViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var claimsTabItemView: UIView!
    @IBOutlet weak var claimsContainerView: UIView!
    @IBOutlet weak var claimsImageView: UIImageView!
    @IBOutlet weak var claimsTabContentViewLeadingConstraint: NSLayoutConstraint!
    weak var claimsController: IAClaimsController!
    
    @IBOutlet weak var accountTabItemView: UIView!
    @IBOutlet weak var accountContainerView: UIView!
    @IBOutlet weak var accountContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var notificationsTabItemView: UIView!
    @IBOutlet weak var notificationsContainerView: UIView!
    @IBOutlet weak var notificationsContainerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.accountTabItemView.alpha = 0.5
        self.notificationsTabItemView.alpha = 0.5
        
        self.dashboardImageView.layer.borderWidth = 1.0
        self.dashboardImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).CGColor
        
        self.fileClaimImageView.layer.borderWidth = 1.0
        self.fileClaimImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).CGColor
        
        self.policiesImageView.layer.borderWidth = 1.0
        self.policiesImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).CGColor
        
        self.claimsImageView.layer.borderWidth = 1.0
        self.claimsImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).CGColor
        
        self.dashboardTabContentViewLeadingConstraint.constant = 0.0
        var aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectDashboardTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.dashboardTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.fileClaimTabContentViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 1
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectFileClaimTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.fileClaimTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.policiesTabContentViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 2
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectPoliciesTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.policiesTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.claimsTabContentViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 3
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectClaimsTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.claimsTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.accountContainerViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 4
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectAccountTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.accountTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.notificationsContainerViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 5
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectNotificationsTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.notificationsTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.notificationCountLabel.layer.cornerRadius = self.notificationCountLabel.frame.size.width / 2.0
        self.notificationCountLabel.layer.masksToBounds = true
        self.notificationCountLabel.layer.backgroundColor = UIColor(red: 160.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        
        self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 6, self.containerScrollView.frame.size.height)
        self.displayTabWithIndex(0, animated: false)
    }
    
    
    func displayTabWithIndex(pIndex: Int, animated pAnimated :Bool) {
        let aNormalBackgroundColor = UIColor.clearColor()
        let aSelectedBackgroundColor = UIColor(red: 167.0/255.0, green: 97.0/255.0, blue: 183.0/255.0, alpha: 0.2)
        if pIndex == 0 {
            self.dashboardTabItemView.backgroundColor = aSelectedBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aNormalBackgroundColor
            self.policiesTabItemView.backgroundColor = aNormalBackgroundColor
            self.claimsTabItemView.backgroundColor = aNormalBackgroundColor
            self.accountTabItemView.backgroundColor = aNormalBackgroundColor
            self.notificationsTabItemView.backgroundColor = aNormalBackgroundColor
        } else if pIndex == 1 {
            self.dashboardTabItemView.backgroundColor = aNormalBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aSelectedBackgroundColor
            self.policiesTabItemView.backgroundColor = aNormalBackgroundColor
            self.claimsTabItemView.backgroundColor = aNormalBackgroundColor
            self.accountTabItemView.backgroundColor = aNormalBackgroundColor
            self.notificationsTabItemView.backgroundColor = aNormalBackgroundColor
        } else if pIndex == 2 {
            self.dashboardTabItemView.backgroundColor = aNormalBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aNormalBackgroundColor
            self.policiesTabItemView.backgroundColor = aSelectedBackgroundColor
            self.claimsTabItemView.backgroundColor = aNormalBackgroundColor
            self.accountTabItemView.backgroundColor = aNormalBackgroundColor
            self.notificationsTabItemView.backgroundColor = aNormalBackgroundColor
        } else if pIndex == 3 {
            self.dashboardTabItemView.backgroundColor = aNormalBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aNormalBackgroundColor
            self.policiesTabItemView.backgroundColor = aNormalBackgroundColor
            self.claimsTabItemView.backgroundColor = aSelectedBackgroundColor
            self.accountTabItemView.backgroundColor = aNormalBackgroundColor
            self.notificationsTabItemView.backgroundColor = aNormalBackgroundColor
        } else if pIndex == 4 {
            self.dashboardTabItemView.backgroundColor = aNormalBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aNormalBackgroundColor
            self.policiesTabItemView.backgroundColor = aNormalBackgroundColor
            self.claimsTabItemView.backgroundColor = aNormalBackgroundColor
            self.accountTabItemView.backgroundColor = aSelectedBackgroundColor
            self.notificationsTabItemView.backgroundColor = aNormalBackgroundColor
        } else if pIndex == 5 {
            self.dashboardTabItemView.backgroundColor = aNormalBackgroundColor
            self.fileClaimTabItemView.backgroundColor = aNormalBackgroundColor
            self.policiesTabItemView.backgroundColor = aNormalBackgroundColor
            self.claimsTabItemView.backgroundColor = aNormalBackgroundColor
            self.accountTabItemView.backgroundColor = aNormalBackgroundColor
            self.notificationsTabItemView.backgroundColor = aSelectedBackgroundColor
        }
        
        
        if pAnimated == true {
            let aDiff :CGFloat = 150.0
            
            UIGraphicsBeginImageContextWithOptions(self.dashboardContainerView.bounds.size, self.dashboardContainerView.opaque, 0.0);
            self.dashboardContainerView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let aDashboardImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.dashboardImageView.image = aDashboardImage
            self.dashboardContainerView.hidden = true
            self.dashboardImageView.hidden = false
            self.dashboardImageView.frame = CGRectMake(0.0, 0.0, self.dashboardContainerView.frame.size.width, self.dashboardContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.fileClaimContainerView.bounds.size, self.fileClaimContainerView.opaque, 0.0);
            self.fileClaimContainerView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let aFileClaimImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.fileClaimImageView.image = aFileClaimImage
            self.fileClaimContainerView.hidden = true
            self.fileClaimImageView.hidden = false
            self.fileClaimImageView.frame = CGRectMake(0.0, 0.0, self.fileClaimContainerView.frame.size.width, self.fileClaimContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.policiesContainerView.bounds.size, self.policiesContainerView.opaque, 0.0);
            self.policiesContainerView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let aPoliciesImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.policiesImageView.image = aPoliciesImage
            self.policiesContainerView.hidden = true
            self.policiesImageView.hidden = false
            self.policiesImageView.frame = CGRectMake(0.0, 0.0, self.policiesContainerView.frame.size.width, self.policiesContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.claimsContainerView.bounds.size, self.claimsContainerView.opaque, 0.0);
            self.claimsContainerView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let aClaimsImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.claimsImageView.image = aClaimsImage
            self.claimsContainerView.hidden = true
            self.claimsImageView.hidden = false
            self.claimsImageView.frame = CGRectMake(0.0, 0.0, self.claimsContainerView.frame.size.width, self.claimsContainerView.frame.size.height)
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
                self.dashboardImageView.frame = CGRectMake(aDiff, aDiff, self.dashboardContainerView.frame.size.width - (aDiff * 2.0), self.dashboardContainerView.frame.size.height - (aDiff * 2.0))
                self.fileClaimImageView.frame = CGRectMake(aDiff, aDiff, self.fileClaimContainerView.frame.size.width - (aDiff * 2.0), self.fileClaimContainerView.frame.size.height - (aDiff * 2.0))
                self.policiesImageView.frame = CGRectMake(aDiff, aDiff, self.policiesContainerView.frame.size.width - (aDiff * 2.0), self.policiesContainerView.frame.size.height - (aDiff * 2.0))
                self.claimsImageView.frame = CGRectMake(aDiff, aDiff, self.claimsContainerView.frame.size.width - (aDiff * 2.0), self.claimsContainerView.frame.size.height - (aDiff * 2.0))
                }, completion: { pFinished in
                    self.containerScrollView.scrollRectToVisible(CGRectMake(self.containerScrollView.frame.size.width * CGFloat(pIndex), 0.0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height), animated: true)
                    
                    UIView.animateWithDuration(0.3, delay: 0.7, options: .CurveEaseOut, animations: {
                        self.dashboardImageView.frame = CGRectMake(0.0, 0.0, self.dashboardContainerView.frame.size.width, self.dashboardContainerView.frame.size.height)
                        self.fileClaimImageView.frame = CGRectMake(0.0, 0.0, self.fileClaimContainerView.frame.size.width, self.fileClaimContainerView.frame.size.height)
                        self.policiesImageView.frame = CGRectMake(0.0, 0.0, self.policiesContainerView.frame.size.width, self.policiesContainerView.frame.size.height)
                        self.claimsImageView.frame = CGRectMake(0.0, 0.0, self.claimsContainerView.frame.size.width, self.claimsContainerView.frame.size.height)
                        }, completion: { pFinished in
                            self.dashboardContainerView.hidden = false
                            self.dashboardImageView.hidden = true
                            
                            self.fileClaimContainerView.hidden = false
                            self.fileClaimImageView.hidden = true
                            
                            self.policiesContainerView.hidden = false
                            self.policiesImageView.hidden = true
                            
                            self.claimsContainerView.hidden = false
                            self.claimsImageView.hidden = true
                    })
            })
        } else {
            self.containerScrollView.scrollRectToVisible(CGRectMake(self.containerScrollView.frame.size.width * CGFloat(pIndex), 0.0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height), animated: false)
            
            self.dashboardContainerView.hidden = false
            self.dashboardImageView.hidden = true
            
            self.policiesContainerView.hidden = false
            self.policiesImageView.hidden = true
            
            self.claimsContainerView.hidden = false
            self.claimsImageView.hidden = true
        }
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Dashboard Tab Item view is tapped.
     * @return Void
     */
    func didSelectDashboardTabItemView() {
        self.displayTabWithIndex(0, animated: true)
    }
    
    
    /**
     * Selector method that will be called when File Claim Tab Item view is tapped.
     * @return Void
     */
    func didSelectFileClaimTabItemView() {
        self.displayTabWithIndex(1, animated: true)
    }
    
    
    /**
     * Selector method that will be called when Policies Tab Item view is tapped.
     * @return Void
     */
    func didSelectPoliciesTabItemView() {
        self.displayTabWithIndex(2, animated: true)
    }
    
    
    /**
     * Selector method that will be called when Claims Tab Item view is tapped.
     * @return Void
     */
    func didSelectClaimsTabItemView() {
        self.displayTabWithIndex(3, animated: true)
    }
    
    
    /**
     * Selector method that will be called when Account Tab Item view is tapped.
     * @return Void
     */
    func didSelectAccountTabItemView() {
        //self.displayTabWithIndex(4, animated: true)
    }
    
    
    /**
     * Selector method that will be called when Notifications Tab Item view is tapped.
     * @return Void
     */
    func didSelectNotificationsTabItemView() {
        //self.displayTabWithIndex(5, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is UINavigationController {
            let aNavController = segue.destinationViewController as! UINavigationController
            if aNavController.viewControllers[0] is IAClaimsController {
                self.claimsController = aNavController.viewControllers[0] as! IAClaimsController
            } else if aNavController.viewControllers[0] is IADashboardController {
                self.dashboardController = aNavController.viewControllers[0] as! IADashboardController
            }
        }
    }
    
}
