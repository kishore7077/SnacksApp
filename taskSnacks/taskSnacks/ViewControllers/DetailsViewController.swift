//
//  DetailsViewController.swift
//  taskSnacks
//
//  Created by Kishore on 18/10/20.
//  Copyright © 2020 Kishore. All rights reserved.
//

import UIKit

typealias Completion = (_ isSelected :Int) ->()

class DetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet weak var btnBlur: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var completion: Completion!

    //MARK:- Constants and Variables
    var selectedName = ""
    var descriptionDict = [ "Pepperoni Pizza": "Pepperoni Pizza Pepperoni Pizza Pepperoni Pizza  Pepperoni Pizza",
                            "Meat Pizza": "Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat Pizza Meat",
                            "Hawaiian Pizza": "Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza Hawaiian Pizza",
                            "Buffalo Pizza": "Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza Buffalo Pizza",
                            "Beef Burgers": "Beef Burgers Beef Burgers Beef Burgers",
                            "Elk Burgers": "Elk Burgers Elk Burgers Elk Burgers",
                            "Turkey Burgers": "Turkey Burgers Turkey Burgers Turkey Burgers Turkey Burgers Turkey Burgers",
                            "Black Bean Burgers": "Black Bean Burgers Black Bean Burgers Black Bean Burgers Black Bean Burgers Black Bean Burgers Black Bean Burgers ",
                            "Lemonade": "Lemonade Lemonade Lemonade Lemonade",
                            "Iced tea": "Iced tea Iced tea Iced tea",
                            "Hot chocolate": "Hot chocolate Hot chocolate Hot chocolate",
                            "Milkshake": "Milkshake Milkshake Milkshake "
    ]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = selectedName
        imgView.image = UIImage(named: selectedName)
        lblDescription.text = descriptionDict[selectedName] ?? ""
        self.navigationController?.isNavigationBarHidden = true

    }
    
    //MARK:- IBActions
    @IBAction func actionBlur(_ sender: UIButton) {
        if let completion = completion {
            completion(1)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func actionBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
