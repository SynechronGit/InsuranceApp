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
        self.dashboardImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
        
        self.fileClaimImageView.layer.borderWidth = 1.0
        self.fileClaimImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
        
        self.policiesImageView.layer.borderWidth = 1.0
        self.policiesImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
        
        self.claimsImageView.layer.borderWidth = 1.0
        self.claimsImageView.layer.borderColor = UIColor(red: 113.0/255.0, green: 104.0/255.0, blue: 147.0/255.0, alpha: 1.0).cgColor
        
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
        self.notificationCountLabel.layer.backgroundColor = UIColor(red: 160.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
        self.containerScrollView.contentSize = CGSize(width: self.containerScrollView.frame.size.width * 6, height: self.containerScrollView.frame.size.height)
        self.displayTabWithIndex(0, animated: false)
    }
    
    
    func displayTabWithIndex(_ pIndex: Int, animated pAnimated :Bool) {
        let aNormalBackgroundColor = UIColor.clear
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
            
            UIGraphicsBeginImageContextWithOptions(self.dashboardContainerView.bounds.size, self.dashboardContainerView.isOpaque, 0.0);
            self.dashboardContainerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let aDashboardImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.dashboardImageView.image = aDashboardImage
            self.dashboardContainerView.isHidden = true
            self.dashboardImageView.isHidden = false
            self.dashboardImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.dashboardContainerView.frame.size.width, height: self.dashboardContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.fileClaimContainerView.bounds.size, self.fileClaimContainerView.isOpaque, 0.0);
            self.fileClaimContainerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let aFileClaimImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.fileClaimImageView.image = aFileClaimImage
            self.fileClaimContainerView.isHidden = true
            self.fileClaimImageView.isHidden = false
            self.fileClaimImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.fileClaimContainerView.frame.size.width, height: self.fileClaimContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.policiesContainerView.bounds.size, self.policiesContainerView.isOpaque, 0.0);
            self.policiesContainerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let aPoliciesImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.policiesImageView.image = aPoliciesImage
            self.policiesContainerView.isHidden = true
            self.policiesImageView.isHidden = false
            self.policiesImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.policiesContainerView.frame.size.width, height: self.policiesContainerView.frame.size.height)
            
            UIGraphicsBeginImageContextWithOptions(self.claimsContainerView.bounds.size, self.claimsContainerView.isOpaque, 0.0);
            self.claimsContainerView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let aClaimsImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.claimsImageView.image = aClaimsImage
            self.claimsContainerView.isHidden = true
            self.claimsImageView.isHidden = false
            self.claimsImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.claimsContainerView.frame.size.width, height: self.claimsContainerView.frame.size.height)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.dashboardImageView.frame = CGRect(x: aDiff, y: aDiff, width: self.dashboardContainerView.frame.size.width - (aDiff * 2.0), height: self.dashboardContainerView.frame.size.height - (aDiff * 2.0))
                self.fileClaimImageView.frame = CGRect(x: aDiff, y: aDiff, width: self.fileClaimContainerView.frame.size.width - (aDiff * 2.0), height: self.fileClaimContainerView.frame.size.height - (aDiff * 2.0))
                self.policiesImageView.frame = CGRect(x: aDiff, y: aDiff, width: self.policiesContainerView.frame.size.width - (aDiff * 2.0), height: self.policiesContainerView.frame.size.height - (aDiff * 2.0))
                self.claimsImageView.frame = CGRect(x: aDiff, y: aDiff, width: self.claimsContainerView.frame.size.width - (aDiff * 2.0), height: self.claimsContainerView.frame.size.height - (aDiff * 2.0))
                }, completion: { pFinished in
                    self.containerScrollView.scrollRectToVisible(CGRect(x: self.containerScrollView.frame.size.width * CGFloat(pIndex), y: 0.0, width: self.containerScrollView.frame.size.width, height: self.containerScrollView.frame.size.height), animated: true)
                    
                    UIView.animate(withDuration: 0.3, delay: 0.7, options: .curveEaseOut, animations: {
                        self.dashboardImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.dashboardContainerView.frame.size.width, height: self.dashboardContainerView.frame.size.height)
                        self.fileClaimImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.fileClaimContainerView.frame.size.width, height: self.fileClaimContainerView.frame.size.height)
                        self.policiesImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.policiesContainerView.frame.size.width, height: self.policiesContainerView.frame.size.height)
                        self.claimsImageView.frame = CGRect(x: 0.0, y: 0.0, width: self.claimsContainerView.frame.size.width, height: self.claimsContainerView.frame.size.height)
                        }, completion: { pFinished in
                            self.dashboardContainerView.isHidden = false
                            self.dashboardImageView.isHidden = true
                            
                            self.fileClaimContainerView.isHidden = false
                            self.fileClaimImageView.isHidden = true
                            
                            self.policiesContainerView.isHidden = false
                            self.policiesImageView.isHidden = true
                            
                            self.claimsContainerView.isHidden = false
                            self.claimsImageView.isHidden = true
                    })
            })
        } else {
            self.containerScrollView.scrollRectToVisible(CGRect(x: self.containerScrollView.frame.size.width * CGFloat(pIndex), y: 0.0, width: self.containerScrollView.frame.size.width, height: self.containerScrollView.frame.size.height), animated: false)
            
            self.dashboardContainerView.isHidden = false
            self.dashboardImageView.isHidden = true
            
            self.policiesContainerView.isHidden = false
            self.policiesImageView.isHidden = true
            
            self.claimsContainerView.isHidden = false
            self.claimsImageView.isHidden = true
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UINavigationController {
            let aNavController = segue.destination as! UINavigationController
            if aNavController.viewControllers[0] is IAClaimsController {
                self.claimsController = aNavController.viewControllers[0] as! IAClaimsController
            } else if aNavController.viewControllers[0] is IADashboardController {
                self.dashboardController = aNavController.viewControllers[0] as! IADashboardController
            }
        }
    }
    
}
