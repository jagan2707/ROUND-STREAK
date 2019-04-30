//
//  RegisterViewController.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 27/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol RegisterDisplayLogic: class {
   func displayAlert(loginFailure: Register.LoginFailure)
   func LoginSuccessWithModel(viewModel: Register.Login.ViewModel)
}

class RegisterViewController: UIViewController, RegisterDisplayLogic {
    var interactor: RegisterBusinessLogic?
    var router: RegisterRoutingLogic?
    var loadingView: LoadingView?
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailView: UIImageView!
    @IBOutlet weak var passwordView: UIImageView!
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
        
        emailView.layer.cornerRadius = self.view.frame.size.height * 0.02//emailView.frame.size.height * 0.3
        emailView.clipsToBounds = true
        
        passwordView.layer.cornerRadius = self.view.frame.size.height * 0.02//passwordView.frame.size.height * 0.3
        passwordView.clipsToBounds = true
        
        emailTextField.text = "candidate@panya.me"
        passwordTextField.text = "becoolatpanya"
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
    
    //MARK: Loader
    private func addActivityIndicator() {
        loadingView = LoadingView(frame:(self.view.bounds))
        self.view.addSubview(loadingView!)
    }
    
    private func removeActivityIndicator() {
        loadingView?.removeFromSuperview()
    }
    
    //MARK: Tap on Register
    
    @IBAction func didTouchOnRegister(_ sender: Any) {
        
        if (!Reachability.isConnectedToNetwork()){
            self.showNetworkAlert()
            return
        }
        login()
    }
    
    private func login() {
        
        addActivityIndicator()
        interactor?.loginWithData(request: Register.Login.Request(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? ""))
    }
    
    // MARK: Display logic
    
    func displayAlert(loginFailure: Register.LoginFailure) {
        
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            let alert = UIAlertController(title: "Email/Password Login", message: loginFailure.alertString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            }))
            self.present(alert, animated: true, completion: {  })
        }
    }
    
    func LoginSuccessWithModel(viewModel: Register.Login.ViewModel) {
        
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            self.router?.routeToBonusScreen(loginModel: viewModel.displayedData)
        }
    }
    
    //MARK: ALERT
    private func showNetworkAlert()  {
        let alert = UIAlertController(title: "No Internet", message: "Please check your device internet connection and try again", preferredStyle: .alert)
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
