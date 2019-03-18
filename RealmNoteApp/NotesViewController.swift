//
//  ViewController.swift
//  RealmNoteApp
//
//  Created by Serxhio Gugo on 3/17/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController {

    var task = [Item]()
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavController()
        view.snapshotView(afterScreenUpdates: true)
    }
    
    fileprivate func setupTableView() {
        view.backgroundColor = .darkGray
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    fileprivate func setupNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationItem.title = "RealmNote App"
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    @objc func handleAddButton() {
        let addNoteController = AddNoteController()
        addNoteController.taskDelegate = self
        self.navigationController?.pushViewController(addNoteController, animated: true)
    }
    
}

extension NotesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = task[indexPath.row].task
        cell.textLabel?.numberOfLines = 0

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            action.backgroundColor = .yellow
            self.task.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action ,indexPath) in
            let addNoteController = AddNoteController()
            self.navigationController?.pushViewController(addNoteController, animated: true)
        }
        return [deleteAction, editAction]
    }
}



extension NotesViewController: TaskDelegate {
    func addTaskToNote(note: String) {
        self.task.append(Item(task: note))
        self.tableView.reloadData()
    }
    

}
