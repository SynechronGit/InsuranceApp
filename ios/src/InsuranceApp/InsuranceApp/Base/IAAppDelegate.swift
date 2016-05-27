//
//  IAAppDelegate.swift
//  InsuranceApp
//
//  Created by rupendra on 5/24/16.
//  Copyright © 2016 com. All rights reserved.
//

import UIKit

@UIApplicationMain
class IAAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var loadingOverlayView: UIView!
    var loadingActivityIndicatorView: UIActivityIndicatorView!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    
    
    /**
     * Readonly property that returns app delegate shared instance.
     */
    static var currentAppDelegate :IAAppDelegate {
        get {
            return UIApplication.sharedApplication().delegate as! IAAppDelegate
        }
    }
    
    
    var _displayLoadingOverlayCount :Int = 0
    /**
     * Method that will display loading overlay. It can be used while server calls etc.
     */
    func displayLoadingOverlay() {
        _displayLoadingOverlayCount = _displayLoadingOverlayCount + 1
        
        if self.loadingOverlayView == nil {
            self.loadingOverlayView = UIView(frame: self.window!.bounds)
            self.loadingOverlayView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
            self.window?.addSubview(self.loadingOverlayView)
            
            self.loadingActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            self.loadingOverlayView.addSubview(self.loadingActivityIndicatorView)
        }
        self.loadingOverlayView.frame = self.window!.bounds
        self.loadingActivityIndicatorView.frame = CGRectMake((self.loadingOverlayView.frame.size.width / 2.0) - (self.loadingActivityIndicatorView.frame.size.width / 2.0), (self.loadingOverlayView.frame.size.height / 2.0) - (self.loadingActivityIndicatorView.frame.size.height / 2.0), 37.0, 37.0)
        self.window?.bringSubviewToFront(self.loadingOverlayView)
        self.loadingOverlayView.hidden = false
        if self.loadingActivityIndicatorView.isAnimating() != true {
            self.loadingActivityIndicatorView.startAnimating()
        }
    }
    
    
    /**
     * Method that will hide loading overlay displayed by displayLoadingOverlay() method.
     */
    func hideLoadingOverlay() {
        _displayLoadingOverlayCount = _displayLoadingOverlayCount - 1
        if self.loadingOverlayView != nil {
            if _displayLoadingOverlayCount <= 0 {
                self.loadingOverlayView.hidden = true
                self.loadingActivityIndicatorView.stopAnimating()
            }
        }
        if _displayLoadingOverlayCount < 0 {
            _displayLoadingOverlayCount = 0
        }
    }
    
    
    /**
     * Method that will clear session related and other persistent data related to user on logout.
     */
    func resetAppDatabase() {
        do {
            try NSFileManager.defaultManager().removeItemAtPath(IAConstants.dataManagerSqliteFilePath)
        } catch {
            NSLog("Can not copy app database.")
        }
    }
    
}

