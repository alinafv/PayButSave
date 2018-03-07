//
//  Payees.swift
//  FinalProject
//
//  Created by Alina FV on 11/21/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class Payees: NSObject, NSCoding{
	
	var payeeName: String!
	var type: String!
	var dueDate: String!
	//var totalBalance = 0.0
    var monthlyBalance: Double!
	var isPaid: Bool!
    
	init(_ payeeName: String, _ type: String, _ dueDate: String, _ monthlyExpenses: Double, _ isPaid: Bool) {
		self.payeeName = payeeName
		self.type = type
		self.dueDate = dueDate
        self.monthlyBalance = monthlyExpenses
        //self.totalBalance = totalBalance + monthlyExpenses
		self.isPaid =  isPaid
	}
	
	required init(coder aDecoder: NSCoder) {
		payeeName = aDecoder.decodeObject(forKey: "payeeName") as! String
		type = aDecoder.decodeObject(forKey: "type") as! String
		dueDate = aDecoder.decodeObject(forKey: "dueDate") as! String
		
        monthlyBalance = aDecoder.decodeObject(forKey: "monthlyBalance") as! Double
        //totalBalance = aDecoder.decodeObject(forKey: "totalBalance") as! Double
		isPaid = aDecoder.decodeObject(forKey: "isPaid") as! Bool
		
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(payeeName, forKey: "payeeName")
		aCoder.encode(type, forKey: "type")
		aCoder.encode(dueDate, forKey: "dueDate")
        aCoder.encode(monthlyBalance, forKey: "monthlyBalance")
       // aCoder.encode(totalBalance, forKey: "totalBalance")
		aCoder.encode(isPaid, forKey: "isPaid")
	}

}
