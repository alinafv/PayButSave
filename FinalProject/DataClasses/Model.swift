//
//  Model.swift
//  FinalProject
//
//  Created by Alina FV on 11/14/17.
//  Copyright © 2017 alina. All rights reserved.
//

import Foundation
class Model {
    // keys used for storing app's data in app's NSUserDefaults
	fileprivate let categoriesKey = "Categories" //for budget by category
    fileprivate let payeeKey = "PayeeSettings" // for payee-setting pair
	fileprivate let takeHomePayKey = "TakeHomePay"
	
	//initializing variables needed
	fileprivate var categoriesAmount = ["utilities" : "0", // stores budget by category
	                                    "housing" : "0",
	                                    "saving" : "0",
	                                    "groceries" : "0",
	                                    "personalCare" : "0",
	                                    "consumerDebt" : "0",
	                                    "entertainment" : "0"]
	fileprivate var payees: [Payees] = []// stores payee-setting
	fileprivate var takeHomePay: Double = 0.0

    // initializes the Model
   init() {
        
        // get the NSUserDefaults object for the app
        let userDefaults = UserDefaults.standard
    
        //get takeHomePay amount
        self.takeHomePay = userDefaults.double(forKey: "TakeHomePay")

	    // get dictionary with the category and its amount
	    if let categoriesArray = userDefaults.dictionary(forKey: categoriesKey) {
			self.categoriesAmount = categoriesArray as! [String:String]
	    }
		 
        // get Array of the app's payee-setting pairs
	    if let decodedPayees = UserDefaults.standard.object(forKey: payeeKey) as? NSData {
			payees =  NSKeyedUnarchiver.unarchiveObject(with: decodedPayees as Data) as! [Payees]
	     }
    }
    
	//**** TakeHomePay data ******
    func getTakeHomePay() -> Double {
        return takeHomePay
    }
    func saveTakeHomePay(_ takeHomeSalary: Double){
        takeHomePay = takeHomeSalary
        updateUserDefaultsTakeHomePay()
    }
    
    func  updateUserDefaultsTakeHomePay(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(takeHomePay, forKey: takeHomePayKey)
        userDefaults.synchronize() // force immediate save to device
    
    }
    
	//***** Category Data *******
	
	func getBudgetAtCategory(_ category: String) -> String? {
		return categoriesAmount[category]
	}
	
    func setBudgetAtKey(_ key: String, _ value: String){
		categoriesAmount[key] = value
	}
	
	func saveBudget(_ categories: [String:String]){
		
		categoriesAmount = categories
		updateUserDefaultsCategories()
	}
	
	func updateUserDefaultsCategories() {
		let userDefaults = UserDefaults.standard
		userDefaults.set(categoriesAmount, forKey: categoriesKey)
		userDefaults.synchronize() // force immediate save to device
	}
	
	
	//*********** Payee Data *****
	
	// returns the payee at the specified index
	func payeeAtIndex(_ index: Int) -> Payees {
		return payees[index]
	}
	
		// returns the number of payees
	var count: Int {
		if payees == []{
			return 0
		}
		else{
			return payees.count}
	}
	
	// deletes a payee given an index
	func deletePayeeAtIndex(_ index: Int) {
		let _ = payees
		payees.remove(at: index)
		updateUserDefaultsPayees()
	}
	
	// update user defaults with current payee's settings
	func updateUserDefaultsPayees() {
		let userDefaults = UserDefaults.standard
		userDefaults.setValue(NSKeyedArchiver.archivedData(withRootObject: payees), forKey: payeeKey)
		userDefaults.synchronize() // force immediate save to device
	}
	
	func savePayee(_ payee: Payees){
		payees.append(payee) // stores payee in array
		updateUserDefaultsPayees()
	}
	
	func savePayeeAtIndex(_ index: Int, _ newPayee: Payees){
		payees.remove(at: index)
		payees.insert(newPayee, at: index)
		updateUserDefaultsPayees()
		
	}
    func restartPayeeAttributes() {
        for payee in payees {
            payee.monthlyBalance = 0.0
            payee.isPaid = false
            payee.type = ""

        }
    }
	
}
