//
//  ViewController.swift
//  ToDoApp
//
//  Created by Gülcem Ece Güneş on 26.03.2023.
//

import UIKit

class MainPageTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate var selectedRow: Int?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDo.sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! MainTableViewCell

        let listItem = ToDo.sampleData[indexPath.item]
        cell.mainTitle.text = listItem.title
        let symbolName = listItem.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        cell.mainImage.image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "detailsegue", sender: self)
//        let dVC = DetailPageViewController()
//        navigationController?.pushViewController(dVC, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dVC = segue.destination as? DetailPageViewController {
            dVC.rowSelected = selectedRow
        }
    }
}

