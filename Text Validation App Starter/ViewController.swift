//
//  ViewController.swift
//  Text Validation App Starter
//
//  Created by Jane Madsen on 10/1/24.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var passwordTextField: UITextField!

  @IBOutlet weak var statusMessageLabel: UILabel!

  @IBOutlet weak var loginButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    guard let sender = sender as? UIButton else { return }

    if sender == loginButton {
      (segue.destination.navigationItem.title = "Account")
    } else {
      segue.destination.navigationItem.title = "Try again"
    }
  }

  @IBAction func validatePassword(_ sender: Any) {
    guard let password = passwordTextField.text, !password.isEmpty else {
      statusMessageLabel.text = "Please enter a password."
      return
    }

    let passwordIsValid = isPasswordValid(password)
    if passwordIsValid {
      statusMessageLabel.text = "Password is valid."
    } else {
      statusMessageLabel.text = "Password must be at least 8 characters, contain an uppercase letter, a lowercase letter, a number, and a special character."
    }

    func isPasswordValid(_ password: String) -> Bool {
      guard password.count >= 8 else { return false }

      let uppercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
      let lowercaseLetter = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
      let digit = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
      let specialCharacter = NSPredicate(format: "SELF MATCHES %@", ".*[!&^%$#@()/]+.*")

      return uppercaseLetter.evaluate(with: password) &&
      lowercaseLetter.evaluate(with: password) &&
      digit.evaluate(with: password) &&
      specialCharacter.evaluate(with: password)
    }
  }
}

