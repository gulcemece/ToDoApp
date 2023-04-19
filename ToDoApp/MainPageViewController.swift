//
//  ViewController.swift
//  ToDoApp
//
//  Created by Gülcem Ece Güneş on 26.03.2023.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    
    // MARK: - Variables
    fileprivate var selectedRow: Int?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - Table View Delegate and Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoManager.mainData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! MainTableViewCell

        let listItem = ToDoManager.mainData[indexPath.item]
        cell.titleLabel.text = listItem.title

        return cell
    }
    
    
    // MARK: - Generating new note
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "detailsegue", sender: self)
    }
    
    @IBAction func didTapAddButton(_ sender:UIBarButtonItem) {
        performSegue(withIdentifier: "detailsegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dVC = segue.destination as? DetailPageViewController {
            dVC.itemIndex = selectedRow
        }
    }
    
    // MARK: - Deleting the selected note
        @IBAction func didTapDeleteButton(_ sender: UIBarButtonItem) {
        if let row = selectedRow  {
            ToDoManager.mainData.remove(at: row)
            tableView.reloadData()
        }
    }
    
}
