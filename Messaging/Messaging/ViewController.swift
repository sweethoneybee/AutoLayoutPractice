//
//  ViewController.swift
//  Messaging
//
//  Created by 정성훈 on 2021/04/20.
//

import UIKit

class BubbleCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

struct Chat {
    let message: String
    let isMyMessaging: Bool = Bool.random() // 임의로 좌우 가도록
}

class ViewController: UIViewController {
    
    private var chats: [Chat] = []
    private var keyboardShow: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func sendMessage() {
        guard let text = self.messageField.text, text.isEmpty == false else { return }
        
        self.chats.append(Chat(message: text))
        self.messageField.text = nil
        
        let indexPath = IndexPath(row: self.chats.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .none)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // MARK:- Keyboard
    @objc func keyboardWillShow(_ noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrameEndRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        if !self.keyboardShow {
            self.bottomConstraint.constant = keyboardFrameEndRect.height + 8
            guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
            }
            
            UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        }
        self.keyboardShow = true
    }
    
    @objc func keyboardWillHide(_ noti: Notification) {
        if self.keyboardShow {
            self.bottomConstraint.constant = 8
            guard let userInfo = noti.userInfo,
                  let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return
            }
            
            UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
                self.view.layoutIfNeeded()
            }.startAnimation()
        }
        self.keyboardShow = false
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        let identifier = chat.isMyMessaging ? "rightCell" : "leftCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BubbleCell else { return UITableViewCell() }
        
        cell.label.text = chat.message
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}

