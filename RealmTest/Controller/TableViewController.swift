//
//  TableViewController.swift
//  Realm
//
//  Created by Yon Thiri Aung on 6/11/19.
//  Copyright © 2019 Yon Thiri Aung. All rights reserved.
//

import UIKit
import RealmSwift
class TableViewController: UITableViewController{
     
     var name = ""
     var occupation = ""
     var age = ""
     var id = 0
    
    let realm = try! Realm()
    
    var dataItem : Results<Data>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadView), name: NSNotification.Name(rawValue: "load"), object: nil)
        loadData()
    }
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataItem.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     
          name = dataItem[indexPath.row].name
          occupation = dataItem[indexPath.row].occupation
          age = dataItem[indexPath.row].age
     
          id = dataItem[indexPath.row].id
     
        performSegue(withIdentifier: "detailData", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = dataItem?[indexPath.row].name
        cell.occupationLabel.text = dataItem?[indexPath.row].occupation
        cell.ageLabel.text = dataItem?[indexPath.row].age

        return cell
        
    }
    
     
    //Delete Row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete{
          
          let alertController = UIAlertController(title: "Warning", message: "Are You Sure You Want to Delete This Data", preferredStyle: .alert)
          
          // Create Delete button
          let OKAction = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction!) in
               
               // Code in this block will trigger when OK button tapped.
               self.deletData(indexPath: indexPath)
               tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
               
          }
          alertController.addAction(OKAction)
          
          // Create Cancel button
          let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
               print("Cancel button tapped");
          }
          alertController.addAction(cancelAction)
      
          present(alertController,animated: true,completion: nil)

        }
    }
     
     
     //Cell Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailData"{
            
          let destinationVC = segue.destination as! UpdateDataViewController
          destinationVC.name = name
          destinationVC.occupation = occupation
          destinationVC.age = age
          destinationVC.id = id
            
        }
        else{
            let destinationVC = segue.destination as! AddDataViewController
        }
        
    }

    func loadData(){
        dataItem = realm.objects(Data.self)
        tableView.reloadData()
    }
    
    func deletData(indexPath : IndexPath){
        
        if let dataForDeletion = self.dataItem?[indexPath.row]{
            
            do{
                try self.realm.write {
                    self.realm.delete(dataForDeletion)
                }
            }
            catch{
            }
        }
        
    }
}


