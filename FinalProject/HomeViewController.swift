//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Alina FV  on 11/9/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFieldPay: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnNewMonth: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    var model = Model() // create the Model
    
    @IBAction func saveSalary(_ sender: Any) {
        model.saveTakeHomePay(checkInput(txtFieldPay.text))
        txtFieldPay.resignFirstResponder()
    }
    
    @IBAction func startNewModel(_ sender: Any) {
       
        //reset variables to start a new month
       /* model.setBudgetAtKey("groceries", "0")
        model.setBudgetAtKey("personalCare", "0")
        model.setBudgetAtKey("consumerDebt", "0")
        model.setBudgetAtKey("entertainment", "0")
        model.updateUserDefaultsCategories()*/
        
        model.restartPayeeAttributes()
        model.updateUserDefaultsPayees()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldPay.text = String( model.getTakeHomePay())
        txtFieldPay.delegate = self
        
        //setting some button styles
        btnContinue.layer.cornerRadius = 5
        imgView.layer.cornerRadius = 5
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
			let controller = (segue.destination as!  CategoryViewController)
			controller.myModel = model

			
	}
    //converts the string input to a double to perfom calculations and
    //returns 0.0 when the conversion is unsuccessful
    func checkInput(_ input: String?) -> Double
    {
        if let result = Double(input!)
        {
            return result
        }
        else
        {
            return 0.0
        }
        
    }
    
    //hiding the keyboard when tapping outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
    

    
}

