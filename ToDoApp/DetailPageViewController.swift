//
//  DetailPage.swift
//  ToDoApp
//
//  Created by Gülcem Ece Güneş on 27.03.2023.
//

import UIKit
// TODO: - Remove additional navigationbar from storyboard
class DetailPageViewController: UIViewController {
    // MARK: - Variables
    var itemIndex : Int?
    var noteIndex : Int?
    var currentNotes: [Note] = []
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = itemIndex, let notes = ToDoManager.mainData[index].noteList {
            self.currentNotes = notes
            self.titleTextField.text = ToDoManager.mainData[index].title
        }
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func saveButton(_ sender: Any) {
        if let index = itemIndex {
            var item = ToDoManager.mainData[index]
            item.title = titleTextField.text!
            item.noteList = currentNotes
            ToDoManager.mainData[index] = item
        } else {
            let item = ToDo(title: titleTextField.text!, noteList: currentNotes)
            ToDoManager.mainData.append(item)
        }
        
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func addButtonItem(_ sender: Any) {
        let alertController = UIAlertController(title: "New note",
                                                message: nil,
                                                preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) {_ in
            let text = alertController.textFields?.first?.text
            if text != "" {
                self.currentNotes.append(Note(noteText: text!))
//UI processes run in the main thread. UI updates require the bottom line.
                DispatchQueue.main.async {
                    self.detailTableView.reloadData()
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alertController.addTextField()
        alertController.addAction(addAction)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    // MARK: - Alert
    func deleteAlert(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Item will be deleted.",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.currentNotes.remove(at: indexPath.row)
            DispatchQueue.main.async { [weak self] in
                self?.detailTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func editAlert(for indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit",
                                                message: nil,
                                                preferredStyle: .alert)
        
        let editAction = UIAlertAction(title: "OK", style: .default) { [self]_ in
            let text = alertController.textFields?.first?.text
            if text != "" {
                currentNotes[indexPath.row].noteText = text!
                DispatchQueue.main.async {
                    self.detailTableView.reloadData()
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addTextField(configurationHandler: { [self] textField in
            textField.text = currentNotes[indexPath.row].noteText
        })
        alertController.addAction(editAction)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
        
        
    }
}


// MARK: - Table View Delegate and Data Source
extension DetailPageViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! DetailTableViewCell
        let listItemText = currentNotes[indexPath.item].noteText
        detailCell.detailLabel.text = listItemText
        let listItem = currentNotes[indexPath.item]
        let symbolName = listItem.isComplete ? "circle.fill" : "circle"
        let image = UIImage(systemName: symbolName, withConfiguration: .none)
        detailCell.doneButton.image = image
        return detailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNotes[indexPath.item].isComplete.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            DispatchQueue.main.async {
                self.deleteAlert(for: indexPath)
            }
            
            success(true)
        })
        
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { [self]
            (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            DispatchQueue.main.async {
                self.editAlert(for: indexPath)
            }
            success(true)
        })
        
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        
    }
    
}
