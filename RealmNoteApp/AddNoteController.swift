//
//  AddNoteController.swift
//  RealmNoteApp
//
//  Created by Serxhio Gugo on 3/17/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

protocol TaskDelegate {
    func addTaskToNote(note: String)
}

class AddNoteController: UIViewController {
    
    var taskDelegate: TaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.title = "Do something today..."
        navigationController?.navigationBar.prefersLargeTitles = false
        setupLayout()
    }
    
    let noteTextField: UITextField = {
       let tf = UITextField()
        tf.textAlignment = .center
        tf.backgroundColor = .darkGray
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Add a task here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        tf.borderStyle = .line
        tf.layer.borderColor = UIColor.white.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let saveTaskButton: UIButton = {
       let button = UIButton()
        button.setTitle("Save Task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleSaveTask), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate func setupLayout() {
        view.addSubview(noteTextField)
        noteTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 25, bottom: 0, right: 25))
        noteTextField.constrainHeight(constant: 50)
        
        view.addSubview(saveTaskButton)
        saveTaskButton.centerInSuperview(size: .init(width: 125, height: 66))
        
    }
    
    @objc func handleSaveTask() {
        print("Save Task Pressed")
        
        guard let note = noteTextField.text else { return }
        if !note.trimmingCharacters(in: .whitespaces).isEmpty {
            
            taskDelegate?.addTaskToNote(note: note)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Write something...", message: "Please add an item before you proceed!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return

        }

    }
    
}
