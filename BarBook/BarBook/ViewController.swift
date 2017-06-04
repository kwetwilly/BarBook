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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

/*-Global Varaibles-*/
    
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!

    var menuIsShown = false
    let daysOfTheWeek: Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @IBOutlet weak var todayLabel: UILabel!
    
    var ref: FIRDatabaseReference!
    
    var dayday = [NSDictionary]()
    
    var tempitems: Array<Any> = ["hello"]

    
/*----------------*/
/*-Main Functions-*/
/*----------------*/

    override func viewDidLoad() {
        super.viewDidLoad()
        
//side menu
        sideMenu.layer.shadowOpacity = 1
        sideMenu.layer.shadowRadius = 6
        todayLabel.text = "Sunday"
        
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
    
    
/*-Used for detecting menu button click and opening and closing the side menu-*/
/*----------------------------------------------------------------------------*/
    
    @IBAction func openMenu(_ sender: Any) {
        
        if menuIsShown{
            menuLeadingConstraint.constant = -210
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            menuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
        menuIsShown = !menuIsShown
    }
    
    @IBAction func openSearchBar(_ sender: Any) {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        searchBarTopConstraint.constant = 100
    }
    
    
    
//Function for the left edge swipe
    func leftEdgeGeature(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            menuLeadingConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }

//Function for swipe actions. (currently only detecting left swipes
    func swipeAction(swipe:UISwipeGestureRecognizer) {
        
        if swipe.direction.rawValue == 2{
            menuLeadingConstraint.constant = -210
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
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
    
/*-----------------*/
/*-Populate tables-*/
/*-----------------*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            
            return tempitems.count
        } else if tableView.tag == 2 {
            return daysOfTheWeek.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView.tag == 1{
            
            cell.textLabel?.text = String(describing: tempitems[indexPath.row])
            
            return cell
    
        }else if tableView.tag == 2{
            cell.textLabel?.text = daysOfTheWeek[indexPath.row]
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.tag == 1{
            
            
            
        } else if tableView.tag == 2 {
            
            todayLabel.text = daysOfTheWeek[indexPath.row]
            menuLeadingConstraint.constant = -210
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
    }

}

