//
//  LoginViewController.swift
//  Travel
//
//  Created by Takashi Taguchi on 2021/05/21.
//

import UIKit
import MBProgressHUD
import Loaf
import Combine

class LoginViewController: UIViewController {
    
    var delegate: OnboardingDelegate?
    private let authManager = AuthManager()
    private var subscriber: AnyCancellable?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private enum PageType {
        case login
        case signUp
    }
    
    private var errorMessage: String? {
        didSet {
            showErrorMessageIfNeeded(text: errorMessage)
        }
    }
    
    private var currentPageType: PageType = .login {
        didSet { //ページタイプに値がセットされると呼ばれる
            setupViewsFor(pageType: currentPageType)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsFor(pageType: .login)
        observeTextFields()
    }
    
    private func observeTextFields() {
        //テキストを変更する度に通知される
        subscriber = NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification).sink { [unowned self] (notification) in
            //guard let this = un else { return }
            guard let _ = (notification.object as? UITextField) else { return }
            showErrorMessageIfNeeded(text: nil) //テキストの入力が始まったら、エラーを消す
//            let text = textField.text
//            //どのテキストフィールドが変更されたかを判断する
//            switch textField {
//            case self.emailTextField:
//                print("emailTextField: \(text)")
//            case self.passwordTextField:
//                print("passwordTextField: \(text)")
//            case self.passwordConfirmationTextField:
//                print("passwordConfirmationTextField: \(text)")
//            default: break
//            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    private func setupViewsFor(pageType: PageType) {
        errorLabel.text = nil
        passwordConfirmationTextField.isHidden = (pageType == .login)
        signUpButton.isHidden = (pageType == .login)
        forgetPasswordButton.isHidden = (pageType == .signUp)
        loginButton.isHidden = (pageType == .signUp)
    }
    
    private func showErrorMessageIfNeeded(text: String?) {
        errorLabel.isHidden = (text == nil)
        errorLabel.text = text
    }
    
    @IBAction func forgetPasswordButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Forget Password", message: "Please enter your email address", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let this = self else { return }
            if let textField = alertController.textFields?.first,
               let email = textField.text ,
               !email.isEmpty {
                this.authManager.resetPassword(withEmail: email) { (result) in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.showAlert(title: "Password Reset Successful", message: "Please check your email to find the password reset link.")
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .top, sender: this).show()
                    }
                }
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              let passwordConfirmation = passwordConfirmationTextField.text,
              !passwordConfirmation.isEmpty else {
              showErrorMessageIfNeeded(text: "Invalid form")
              return }
        
        guard password == passwordConfirmation else {
            showErrorMessageIfNeeded(text: "Passwords are incorrect")
            return
        }
        MBProgressHUD.showAdded(to: view, animated: true)
        
        //ユーザー作成のメソッド
        authManager.signUpNewUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else { return }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            //case.success(let user):
            case.success:
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessageIfNeeded(text: error.localizedDescription)
            }
        }
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        
        
        guard  let email = emailTextField.text,
               !email.isEmpty,
               let password = passwordTextField.text,
               !password.isEmpty else {
                showErrorMessageIfNeeded(text: "Invalid form")
                return }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        authManager.loginUser(withEmail: email, password: password) { [weak self] (result) in
            guard let this = self else { return }
            MBProgressHUD.hide(for: this.view, animated: true)
            switch result {
            //case .success(let user):
            case .success: //user使わないからこっちで書く
                this.delegate?.showMainTabBarController()
            case .failure(let error):
                this.showErrorMessageIfNeeded(text: error.localizedDescription)
            }
        }
    }
    //セグメントの変更 ページタイプの変更
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .signUp
    }
}
