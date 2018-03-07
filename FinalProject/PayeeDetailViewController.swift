//
//  PayeeDetailViewController.swift
//  FinalProject
//
//  Created by Alina FV  on 11/14/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class PayeeDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var txtFieldType: UITextField!
    
    @IBOutlet weak var pkrType: UIPickerView!
    let categories = ["Utilities", "Housing", "Saving", "Groceries","Personal Care","Consumer Debt","Entertainment" ]
    @IBOutlet weak var txtFieldPayeeName: UITextField!
	@IBOutlet weak var txtFieldDueDate: UITextField!
	@IBOutlet weak var txtFieldExpenses: UITextField!
	@IBOutlet weak var stepper: UIStepper!
	@IBOutlet weak var switchPaid: UISwitch!
	@IBOutlet weak var btnSave: UIBarButtonItem!
	
    @IBOutlet weak var btnDelete: UIButton!
    var model:Model!
	
	var detailItem: Int = 0
	var isDetail = true
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories [row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFieldType.text = categories[row]
        pkrType.isHidden = true
    }
    
    @IBAction func showPicker(_ sender: Any) {
        txtFieldType.resignFirstResponder()
        pkrType.isHidden = false
        if  txtFieldType.text == ""{
            pkrType.selectRow(3, inComponent: 0, animated: true)
            txtFieldType.text = categories [3]
        }
        else {
            let str = categories.index(of: txtFieldType.text!)
            pkrType.selectRow(str!, inComponent: 0, animated: true)
        }
       
    }
    
    @IBAction func savePayee(_ sender: Any) {
		
		let payee = Payees (txtFieldPayeeName.text!, txtFieldType.text!,txtFieldDueDate.text!,
		                    checkInput(input: txtFieldExpenses.text), switchPaid.isOn)
		if isDetail {
			model.savePayeeAtIndex(detailItem, payee)
		}
		else {
			model.savePayee(payee)
		
		}
		
		self.performSegue(withIdentifier: "unwindToPayee", sender: self)
	}

	@IBAction func deletePayee(_ sender: Any) {
		if isDetail{
			model.deletePayeeAtIndex(detailItem)
		}
		self.performSegue(withIdentifier: "unwindToPayee", sender: self)
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
        pkrType.isHidden = true;
        
		if isDetail{
			configureView()
		}
        btnDelete.layer.cornerRadius = 5
        
        self.txtFieldType.delegate = self
		self.txtFieldDueDate.delegate = self
        self.txtFieldPayeeName.delegate = self
        self.txtFieldExpenses.delegate = self
        
       
        addinputAccessories()
        
    }
    func addinputAccessories(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: #selector(self.donePressed))
        let doneButton = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        toolBar.setItems([flexSpace, doneButton], animated: false)
        
        txtFieldExpenses.inputAccessoryView  = toolBar
        txtFieldDueDate.inputAccessoryView = toolBar
        txtFieldPayeeName.inputAccessoryView = toolBar
        
        txtFieldType.inputAccessoryView = toolBar
    }
    func donePressed() {
        view.endEditing(true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ txtField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	func checkInput(input: String?) -> Double {
		if let result = Double(input!){
		return result
		}
		else{
		return 0.0
		}
	}
    
    func configureView() {
        
        // Update the user interface for the detail item.
        
        txtFieldPayeeName.text = model.payeeAtIndex(detailItem).payeeName
        txtFieldType.text = model.payeeAtIndex(detailItem).type
        txtFieldDueDate.text = model.payeeAtIndex(detailItem).dueDate
        txtFieldExpenses.text = String (model.payeeAtIndex(detailItem).monthlyBalance)
        switchPaid.setOn(model.payeeAtIndex(detailItem).isPaid, animated: true)
        
    }
    
  
}
