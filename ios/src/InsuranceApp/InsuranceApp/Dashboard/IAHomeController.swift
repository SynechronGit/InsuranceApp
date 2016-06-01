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
    @IBOutlet weak var dashboardContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var fileClaimTabItemView: UIView!
    @IBOutlet weak var fileClaimContainerView: UIView!
    @IBOutlet weak var fileClaimContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var policiesTabItemView: UIView!
    @IBOutlet weak var policiesContainerView: UIView!
    @IBOutlet weak var policiesContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var claimsTabItemView: UIView!
    @IBOutlet weak var claimsContainerView: UIView!
    @IBOutlet weak var claimsContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var accountTabItemView: UIView!
    @IBOutlet weak var accountContainerView: UIView!
    @IBOutlet weak var accountContainerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var notificationsTabItemView: UIView!
    @IBOutlet weak var notificationsContainerView: UIView!
    @IBOutlet weak var notificationsContainerViewLeadingConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dashboardContainerViewLeadingConstraint.constant = 0.0
        var aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectDashboardTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.dashboardTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.fileClaimContainerViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 1
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectFileClaimTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.fileClaimTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.policiesContainerViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 2
        aTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IAHomeController.didSelectPoliciesTabItemView))
        aTapGestureRecognizer.cancelsTouchesInView = false
        self.policiesTabItemView.addGestureRecognizer(aTapGestureRecognizer)
        
        self.claimsContainerViewLeadingConstraint.constant = self.containerScrollView.frame.size.width * 3
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
        
        self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.frame.size.width * 6, self.containerScrollView.frame.size.height)
        self.displayTabWithIndex(0)
    }
    
    
    func displayTabWithIndex(pIndex: Int) {
        let aNormalBackgroundColor = UIColor.clearColor()
        let aSelectedBackgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.09)
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
        self.containerScrollView.scrollRectToVisible(CGRectMake(self.containerScrollView.frame.size.width * CGFloat(pIndex), 0.0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height), animated: true)
    }
    
    
    // MARK: - Selector Methods
    
    /**
     * Selector method that will be called when Dashboard Tab Item view is tapped.
     * @return Void
     */
    func didSelectDashboardTabItemView() {
        self.displayTabWithIndex(0)
    }
    
    
    /**
     * Selector method that will be called when File Claim Tab Item view is tapped.
     * @return Void
     */
    func didSelectFileClaimTabItemView() {
        self.displayTabWithIndex(1)
    }
    
    
    /**
     * Selector method that will be called when Policies Tab Item view is tapped.
     * @return Void
     */
    func didSelectPoliciesTabItemView() {
        self.displayTabWithIndex(2)
    }
    
    
    /**
     * Selector method that will be called when Claims Tab Item view is tapped.
     * @return Void
     */
    func didSelectClaimsTabItemView() {
        self.displayTabWithIndex(3)
    }
    
    
    /**
     * Selector method that will be called when Account Tab Item view is tapped.
     * @return Void
     */
    func didSelectAccountTabItemView() {
        self.displayTabWithIndex(4)
    }
    
    
    /**
     * Selector method that will be called when Notifications Tab Item view is tapped.
     * @return Void
     */
    func didSelectNotificationsTabItemView() {
        self.displayTabWithIndex(5)
    }
    
}
