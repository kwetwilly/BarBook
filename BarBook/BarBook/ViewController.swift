//
//  ViewController.swift
//  BarBook
//
//  Created by Zach Bockskopf on 5/31/17.
//  Copyright © 2017 Zach Bockskopf. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    

/*-Global Varaibles-*/
    
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    var menuIsShown = false
    
/*----------------*/
/*-Main Functions-*/
/*----------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
//side menu
        sideMenu.layer.shadowOpacity = 1
        sideMenu.layer.shadowRadius = 6
        
        
//Swipe Declarations
        
        //Left edge swipe. Used for opening the side menu
        let leftEdgeSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(leftEdgeGeature))
        leftEdgeSwipe.edges = .left
        self.view.addGestureRecognizer(leftEdgeSwipe)
        
        //Left swipe. Used to close the side menu
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        //Get data from Firebase
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("sports_pub").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get bar deal info value
            let value = snapshot.value as? NSDictionary
            print(value)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
/*----------------*/
/*-User functions-*/
/*----------------*/
    
//Used for detecting menu button click and opening and closing the side menu
    @IBAction func openMenu(_ sender: Any) {
        
        if menuIsShown{
            menuLeadingConstraint.constant = -200
        }else{
            menuLeadingConstraint.constant = 0
        }
        
        menuIsShown = !menuIsShown
    }
    
    @IBAction func openSearchBar(_ sender: Any) {
        
        
        
        
    }
    
    
    
//Function for the left edge swipe
    func leftEdgeGeature(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            menuLeadingConstraint.constant = 0
        }
    }

//Function for swipe actions. (currently only detecting left swipes
    func swipeAction(swipe:UISwipeGestureRecognizer) {
        
        if swipe.direction.rawValue == 2{
            menuLeadingConstraint.constant = -200
        }
        menuIsShown = !menuIsShown
        
        /*Code for detecting left and right swipes, may have to use later
         
        switch swipe.direction.rawValue {
        case 1:
            //right swipe
        case 2:
            //left swipe
        default:
            break
        }*/
    }
    

}

