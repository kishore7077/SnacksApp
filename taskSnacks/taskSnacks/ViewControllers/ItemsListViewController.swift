//
//  ItemsListViewController.swift
//  taskSnacks
//
//  Created by Kishore on 16/10/20.
//  Copyright © 2020 Kishore. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var listTableView: UITableView!
    var selectedIndexPaths = [IndexPath]()
    
    //MARK:- Constants and Variables
    var itemsArray = ["Pizza","Burgers","Beverages"]
    var expandPizzaSction = false
    var expandBurgersSection = false
    var expandBeveragesSection = false
    var dictData = ["Pizza" : ["Pepperoni Pizza","Meat Pizza","Hawaiian Pizza","Buffalo Pizza"],
                    "Burgers" : ["Beef Burgers","Elk Burgers","Turkey Burgers","Black Bean Burgers"],
                    "Beverages" : ["Lemonade","Iced tea","Hot chocolate","Milkshake"]]
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.tableFooterView = UIView()
        self.title = "FOOD ITEMS"
    }
    //MARK:- Additional Functions
    @objc func pizzaSectionTapped(_ sender: UITapGestureRecognizer?) {
        self.expandPizzaSction = !self.expandPizzaSction
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    @objc func burgersSectionTapped(_ sender: UITapGestureRecognizer?) {
        self.expandBurgersSection = !self.expandBurgersSection
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }
    }
    @objc func beveragesSectionTapped(_ sender: UITapGestureRecognizer?) {
        self.expandBeveragesSection = !self.expandBeveragesSection
        DispatchQueue.main.async {
            self.listTableView.reloadData()
        }

    }
}

extension ItemsListViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = listTableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
            return cell
        } else {
            let cell = listTableView.dequeueReusableCell(withIdentifier: "ItemsNamesTableViewCell") as! ItemsNamesTableViewCell
            if indexPath.section == 1 {
                cell.lblName.text = dictData["Pizza"]?[indexPath.row]
            } else if indexPath.section == 2 {
                cell.lblName.text = dictData["Burgers"]?[indexPath.row]
            } else if indexPath.section == 3 {
                cell.lblName.text = dictData["Beverages"]?[indexPath.row]
            }
            if selectedIndexPaths.contains(indexPath) {
                cell.vwBackGround.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
            } else {
                cell.vwBackGround.backgroundColor = .white
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("SectionHeaderTableViewCell", owner: self, options: nil)?.last as! SectionHeaderTableViewCell
        if section == 0 {
            return nil
        } else if section == 1 {
            header.lblTitle.text = itemsArray[0]
            header.btnExpandable.addTarget(self, action: #selector(pizzaSectionTapped(_:)), for: .touchUpInside)
        } else if section == 2 {
            header.lblTitle.text = itemsArray[1]
            header.btnExpandable.addTarget(self, action: #selector(burgersSectionTapped(_:)), for: .touchUpInside)
        } else if section == 3 {
            header.lblTitle.text = itemsArray[2]
            header.btnExpandable.addTarget(self, action: #selector(beveragesSectionTapped(_:)), for: .touchUpInside)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let nextVC = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        nextVC.completion = { (isSelected: Int) in
            if self.selectedIndexPaths.contains(indexPath) {
                self.selectedIndexPaths.removeAll(where: {
                    $0 == indexPath
                })
            } else {
                self.selectedIndexPaths.append(indexPath)
            }
            DispatchQueue.main.async {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        if indexPath.section == 1 {
            nextVC.selectedName = dictData["Pizza"]?[indexPath.row] ?? ""
        } else if indexPath.section == 2 {
            nextVC.selectedName = dictData["Burgers"]?[indexPath.row] ?? ""
        } else if indexPath.section == 3 {
            nextVC.selectedName = dictData["Beverages"]?[indexPath.row] ?? ""
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 210
        } else if indexPath.section == 1{
            if expandPizzaSction{
                if dictData["Pizza"]?.isEmpty == false{
                    return 50
                } else {
                    return 0
                }
            }
        } else if indexPath.section == 2 {
            if expandBurgersSection {
                if dictData["Burgers"]?.isEmpty == false {
                    return 50
                } else {
                    return 0
                }
            }
        } else if indexPath.section == 3 {
            if expandBeveragesSection {
                if dictData["Beverages"]?.isEmpty == false {
                    return 50
                } else {
                    return 0
                }
            }
        }
        return 0
    }
}

