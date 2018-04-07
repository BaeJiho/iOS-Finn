//
//  SignUpPassWordViewController.swift
//  Finn
//
//  Created by 배지호 on 2018. 4. 4..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit
import Alamofire

class SignUpPassWordViewController: UIViewController {
  
  var signUpData: [String: Any] = [:]
  
  @IBOutlet weak var passWordTF: UITextField!
  @IBOutlet weak var checkPassWordTF: UITextField!
  @IBOutlet weak var keyboardMargin: NSLayoutConstraint!
  
  @IBAction func removeKeyboard(_ sender: Any) {
    passWordTF.resignFirstResponder()
    checkPassWordTF.resignFirstResponder()
  }
  @IBAction func signUpAction(_ sender: Any) {
    passwordData()
    dataInfo()
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passWordTF.borderBottom(height: 1.0, color: .white)
    checkPassWordTF.borderBottom(height: 1.0, color: .white)
    addKeyboardObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
}

extension SignUpPassWordViewController {
  
  private func dataInfo() {
    let params: Parameters = [
      "email" : signUpData["email"]!,
      "password" : signUpData["password"]!,
      "confirm_password" : signUpData["confirm_password"]!,
      "first_name" : signUpData["first_name"]!,
      "last_name" : signUpData["last_name"]!,
      "phone_num" : signUpData["phone_num"]!
    ]
    print("params:\(params)")
    Alamofire
      .request(Network.Auth.signUpURL, method: .post, parameters: params)
      .validate()
      .responseData { (response) in
        switch response.result {
        case .success(let value):
          print("value: \(value)")
        case.failure(let error):
          print("error: \(error)")
        }
    }
  }

  private func passwordData() {
    guard let password = passWordTF.text else { return print("passwordTF: nil") }
    signUpData.updateValue(passWordTF.text!, forKey: "password")
    guard let checkPassword = checkPassWordTF.text else { return print("checkPassWordTF: nil") }
    signUpData.updateValue(checkPassWordTF.text!, forKey: "confirm_password")
  }
  
  private func addKeyboardObserver() {
    NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) {
      [weak self] in
      guard let userInfo = $0.userInfo,
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
      
      UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
        self?.keyboardMargin.constant = keyboardFrame.height + 20
        self?.view.layoutIfNeeded()
      })
    }
    
    NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) {
      [weak self] in
      guard let userInfo = $0.userInfo,
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
      
      UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve), animations: {
        self?.keyboardMargin.constant = 10
        self?.view.layoutIfNeeded()
      })
    }
  }
}

extension SignUpPassWordViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if passWordTF.text == "" {
      passWordTF.becomeFirstResponder()
    } else {
      passWordTF.resignFirstResponder()
      checkPassWordTF.becomeFirstResponder()
    }
    return true
  }
}
