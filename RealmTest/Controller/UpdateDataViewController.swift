//
//  UpdateDataViewController.swift
//  RealmTest
//
//  Created by Yon Thiri Aung on 6/11/19.
//  Copyright © 2019 Yon Thiri Aung. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateDataViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var occupationTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    
    let realm = try! Realm()
    let data = Data()
    var name = ""
    var occupation = ""
    var age = ""
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBtn.layer.cornerRadius = 4
        nameTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        
        nameTextField.text = name
        occupationTextField.text = occupation
        ageTextField.text = age
        idLabel.text = String(id)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func updateData(_ sender: Any) {
        
        if nameTextField.text != "" && occupationTextField.text != "" && ageTextField.text != ""{
            data.name = nameTextField.text!
            data.occupation = occupationTextField.text!
            data.age = ageTextField.text!
            data.id = Int(idLabel.text!)!
            
            updateData()
            
            navigationController?.popToRootViewController(animated: true)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        
        else{
            
            let alert = UIAlertController(title: "Warning", message: "Please Input Data", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
            
            
        }
    }
    
    func updateData(){
        
        do{
            try realm.write {
                realm.add(data, update: true)
            }
        }
        catch{
            
        }
    }
    
    @IBAction func ageTextChanged(_ sender: Any) {
        
        checkMaxLength(textField: sender as! UITextField, maxLength: 3)
    }
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    
   
    
    

}
