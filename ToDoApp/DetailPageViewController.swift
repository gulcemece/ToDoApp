//
//  DetailPage.swift
//  ToDoApp
//
//  Created by Gülcem Ece Güneş on 27.03.2023.
//

import UIKit

class DetailPageViewController: UIViewController {
    

    @IBOutlet weak var detailTableView: UITableView!
        
        override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    var rowSelected : Int?
}

extension DetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDo.sampleData[rowSelected!].notes!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! DetailTableViewCell
        let listItem = ToDo.sampleData[rowSelected!].notes![indexPath.item]
        detailCell.detailNote.text = listItem
//        let symbolName = listItem.isComplete ? "circle.fill" : "circle"
//        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
//        detailCell.detailImage.image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        return detailCell
    }
}
