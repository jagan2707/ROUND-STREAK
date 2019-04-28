//
//  RegisterViewController.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterDisplayLogic: class {
   func displayAlert(loginFailure: Register.LoginFailure.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic {
    var interactor: RegisterBusinessLogic?
    var router: RegisterRoutingLogic?
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var currentTextField: UITextField!
    
    var offsetY:CGFloat = 0

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.view.endEditing(true)
    }
   
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        let router = RegisterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Configuration
    private func configure() {
        
        registerButton.layer.cornerRadius = self.view.frame.size.height * 0.03
        registerButton.clipsToBounds = true
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK KEYBOARD NOTIFICATION
    @objc func keyboardWillShow(notification:NSNotification) {
        
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.logoTopConstraint.constant = 0
        })
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame.origin.y -= 30
        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let textFiledFrame = self.view.convert(currentTextField.frame, from:currentTextField.superview)
        
        if keyboardFrame.intersects(textFiledFrame)  {
            
            let changeInHeight = keyboardFrame.origin.y - (textFiledFrame.origin.y + textFiledFrame.size.height)
            UIView.animate(withDuration: animationDurarion, animations: {
                self.logoTopConstraint.constant += changeInHeight
            })
        }
    }
    
    //MARK: Tap on Register
    
    @IBAction func didTouchOnRegister(_ sender: Any) {
        
        interactor?.loginWithData(request: Register.Login.Request(), loginData: Register.Login.LoginDetails(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? ""))
    }
    
    // MARK: Display logic
    
    func displayAlert(loginFailure: Register.LoginFailure.ViewModel) {
        
        let alert = UIAlertController(title: "Alert", message: loginFailure.alertString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        }))
        self.present(alert, animated: true, completion: {  })
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentTextField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        else {
        textField.resignFirstResponder()
        }
        return true
    }
}