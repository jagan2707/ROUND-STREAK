//
//  BonusViewController.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusDisplayLogic: class {
    func displaySomething(viewModel: Bonus.Something.ViewModel)
}

class BonusViewController: UIViewController, BonusDisplayLogic {
    var interactor: BonusBusinessLogic?
    var router: BonusRoutingLogic?
    var loginRespose: LoginModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BonusInteractor()
        let presenter = BonusPresenter()
        let router = BonusRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Configuration
    private func configure() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        configure()
    }
    
    // MARK: Event handling
    
    func doSomething() {
        let request = Bonus.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    @IBAction func didTouchOnBack() {
        router?.getBackToLogin()
    }
    
    // MARK: Display logic
    
    func displaySomething(viewModel: Bonus.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}


//MARK:UITableViewDataSource
extension BonusViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:BonusCell = (tableView.dequeueReusableCell(withIdentifier: BonusCell.getCellIdentifier()) as! BonusCell?)!
        //self.setUpCell(cell: cell, indexPath: indexPath)
        
//        cell.firstView.layer.masksToBounds = true
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(roundedRect: cell.firstView.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: cell.firstView.frame.size.width/2, height: cell.firstView.frame.size.height/2)).cgPath
//        cell.firstView.layer.mask = maskLayer
        return cell
    }
    
}

//MARK:UITableViewDelegate
extension BonusViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * 0.15;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

}
