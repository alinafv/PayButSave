//
//  CategoryViewController.swift
//  FinalProject
//
//  Created by Alina FV  on 11/14/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtFieldUtilities: UITextField!
    @IBOutlet weak var txtFieldHousing: UITextField!
    @IBOutlet weak var txtFieldSaving: UITextField!
    @IBOutlet weak var txtFieldGroceries: UITextField!
    @IBOutlet weak var txtFieldPersonalCare: UITextField!
    @IBOutlet weak var txtFieldConsumerDebt: UITextField!
    @IBOutlet weak var txtFieldEntertainment: UITextField!
	@IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var txtViewNotifications: UITextView!
    
	var myModel: Model!
    var dictionarySum = ["groceries" : 0.0,
                      "personalCare" : 0.0,
                      "consumerDebt" : 0.0,
                      "entertainment" :0.0]
    
	
	@IBAction func saveBudget(_ sender: Any) {
		
                let dictionary = ["utilities" : txtFieldUtilities.text!,
                                  "housing" : txtFieldHousing.text!,
                                  "saving" : txtFieldSaving.text!,
                                  "groceries" : txtFieldGroceries.text!,
                                  "personalCare" : txtFieldPersonalCare.text!,
                                  "consumerDebt" : txtFieldConsumerDebt.text!,
                                  "entertainment" : txtFieldEntertainment.text!]
		
		myModel.saveBudget(dictionary)
		
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.layer.cornerRadius = 5
		txtFieldUtilities.text = myModel.getBudgetAtCategory("utilities")
		txtFieldHousing.text = myModel.getBudgetAtCategory("housing")
		txtFieldSaving.text = myModel.getBudgetAtCategory("saving")
		txtFieldGroceries.text = myModel.getBudgetAtCategory("groceries")
		txtFieldPersonalCare.text = myModel.getBudgetAtCategory("personalCare")
		txtFieldConsumerDebt.text = myModel.getBudgetAtCategory("consumerDebt")
		txtFieldEntertainment.text = myModel.getBudgetAtCategory("entertainment")
        
        addinputAccessories()
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 12.0/255.0, green: 126.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    func addinputAccessories(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(self.donePressed))
        let doneButton = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        txtFieldUtilities.inputAccessoryView  = toolBar
        txtFieldHousing.inputAccessoryView  = toolBar
        txtFieldSaving.inputAccessoryView  = toolBar
        txtFieldGroceries.inputAccessoryView  = toolBar
        txtFieldPersonalCare.inputAccessoryView = toolBar
        txtFieldConsumerDebt.inputAccessoryView = toolBar
        txtFieldEntertainment.inputAccessoryView = toolBar
    }
    func donePressed() {
        view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let controller = (segue.destination as!  PayeesViewController)
		controller.newModel = myModel
	}
    
    override func viewWillAppear(_ animated: Bool) {
      txtViewNotifications.text = ""
        showNotifications()
    }
    
    
    func showNotifications() {
       
        if myModel.count != 0 {
            
            var expenses = 0.0
            var isPaid = 0.0
            for i in 0...myModel.count-1{
               
                expenses += myModel.payeeAtIndex(i).monthlyBalance
                if myModel.payeeAtIndex(i).isPaid{
                    isPaid += myModel.payeeAtIndex(i).monthlyBalance
                }
                
               /* if !myModel.payeeAtIndex(i).isPaid{
                    let dDate = Int(myModel.payeeAtIndex(i).dueDate)
                    let date = Date()
                    let calendar = Calendar.current
                    let day = calendar.component(.day, from: date)
                    let daysLeft = dDate! - Int (day)
                    
                    txtViewNotifications.text.append("\n**" + myModel.payeeAtIndex(i).payeeName + " has not been paid. " )
                    if daysLeft > 0 {
                        
                        txtViewNotifications.text.append( String (daysLeft) + " days left until the due Date  \n")
                    }
                    else {
                        
                         txtViewNotifications.text.append("You are " + String(abs(daysLeft)) + " days late to pay this bill. \n")
                    }
                }
                
               // To show notifications related with the budget
                
               if dictionarySum[myModel.payeeAtIndex(i).type] {
                    dictionarySum[myModel.payeeAtIndex(i).type] = dictionarySum[myModel.payeeAtIndex(i).type]! + myModel.payeeAtIndex(i).monthlyBalance
                }
                
                
            }
            for j in ["groceries", "personalCare", "consumerDebt", "entertainment"]{
                
                if dictionarySum[j]! > 0.0 {
                    
                    txtViewNotifications.text.append("**\n" + String(dictionarySum[j]!) + " dollars left from the budget  \n")
                }
                else {
                    
                    txtViewNotifications.text.append("**\nYou are " + String(abs(dictionarySum[j]!)) + " dollars over the budget. \n")
                    
                 }
            }*/
        }
        txtViewNotifications.text.append( "\n** $" + String (expenses) + " has been spent of a total of: $" + String (myModel.getTakeHomePay()))
        txtViewNotifications.text.append( "\n** $" + String(myModel.getTakeHomePay() - expenses) + " left." )
        txtViewNotifications.text.append( "\n** $" + String(isPaid) + " has been paid and $" + String(myModel.getTakeHomePay() - isPaid) + " left.")

            txtViewNotifications.text.append( "\n ConsumerDebt includes: \n1- gas-$200 \n2- Cuba-$200 \n3- lunch-$60 \n4- adobe-$30 \n5- hulu & neflix-$26 \n6- hair dye-$15")
            
      }
        
    }
        
}

