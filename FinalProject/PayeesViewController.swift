//
//  PayeesViewController.swift
//  FinalProject
//
//  Created by Alina FV  on 11/14/17.
//  Copyright © 2017 alina. All rights reserved.
//

import UIKit

class PayeesViewController: UITableViewController {

    var detailViewController: PayeeDetailViewController? = nil
    var newModel: Model!
    var cellCounter = 0
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// adding an Add button
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(PayeesViewController.addButtonPressed(_:)))
		self.navigationItem.rightBarButtonItem = addButton
        
	}
	
	@IBAction func unwindToPayees(segue: UIStoryboardSegue) {
		tableView.reloadData()
		
	}
	// displays next scene
	func addButtonPressed(_ sender: AnyObject) {
		self.performSegue(withIdentifier: "toSettings", sender: self)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func insertNewObject(_ sender: AnyObject) {
		let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
		self.tableView.insertRows(at: [indexPath], with: .automatic)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				//let payee = myModel.payeeAtIndex((indexPath as NSIndexPath).row)
				let controller = (segue.destination as!  PayeeDetailViewController)
				controller.model = newModel
				controller.detailItem = indexPath.row
			}
		}
		else{
			let controller = (segue.destination as!  PayeeDetailViewController)
			controller.model = newModel
			controller.isDetail = false
		}
	}
	
	// This function returns the number of sections in the tableView
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	// This function returns the number of rows in the current section
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return newModel.count
	}
	
	// This function
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PayeeTableViewCell
		
        let amount = newModel.payeeAtIndex(indexPath.row).monthlyBalance
       
        if newModel.payeeAtIndex(indexPath.row).isPaid {
            cell.btncheckMark.setImage(UIImage(named: "checkedSquare.png"), for: .normal)
        }
        else{
            cell.btncheckMark.setImage(UIImage(named: "square.png"), for: .normal)
        }
        cell.lblAmount.text = "$" + String( amount!)
		cell.lblPayeeName.text = newModel.payeeAtIndex(indexPath.row).payeeName
		cell.lblDay.text = newModel.payeeAtIndex(indexPath.row).dueDate
        
        //this adds color to every other cell
        cellCounter = cellCounter + 1
        if cellCounter % 2 != 0{
            let cellColor = UIColor(red: 231.0/255.0, green: 239.0/255.0, blue: 230.0/255.0, alpha: 1.0)
            cell.layer.backgroundColor = cellColor.cgColor
        }
        else {
            cell.backgroundColor = UIColor.clear
        }
        
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			newModel.deletePayeeAtIndex(indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
	
	
}

