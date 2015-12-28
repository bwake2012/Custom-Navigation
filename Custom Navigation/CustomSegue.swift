//
//  CustomSegue.swift
//  Custom Navigation
//
//  Created by Bob Wakefield on 12/28/15.
//  Copyright © 2015 Bob Wakefield. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue, UINavigationControllerDelegate {

    deinit {
    
        print( "CustomSegue: deinit" )
    }
    
    override func perform() {
        
        sourceViewController.navigationController?.delegate = self
        
        super.perform()
    }
    
    func navigationController(
            navigationController: UINavigationController,
            animationControllerForOperation operation: UINavigationControllerOperation,
            fromViewController fromVC: UIViewController,
            toViewController toVC: UIViewController ) -> UIViewControllerAnimatedTransitioning? {
        
        return Animator( operation: operation )
    }
}
