//
//  BonusViewController.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 28/4/2562 BE.
//  Copyright (c) 2562 jagadeesh. All rights reserved.
//

import UIKit

protocol BonusDisplayLogic: class {
    
func displayListOfRoundStreak(viewModel: Bonus.RoundStreak.ViewModel)
func displayAlert(loginFailure: Bonus.RoundStreakFailure)
}

class BonusViewController: UIViewController, BonusDisplayLogic {
    
    var interactor: BonusBusinessLogic?
    var router: BonusRoutingLogic?
    var loginRespose: LoginModel?
    var consecutiveRoundCount: Int!
    var roundStrikeList = [Int]()
    
    @IBOutlet weak var roundStrikeTable: UITableView!
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
        consecutiveRoundCount = loginRespose?.consecutiveRoundCount ?? 0
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getBonusList()
        
    }
    
    // MARK: Event handling
    
    func getBonusList() {
        
        if let accessToken = loginRespose?.accessToken {
        let request = Bonus.RoundStreak.Request.Url()
        let header = Bonus.RoundStreak.Request.Header(accessToken: accessToken)
        interactor?.getListOfRounds(request: request, header: header)
        }
    }
    
    @IBAction func didTouchOnBack() {
        router?.getBackToLogin()
    }
    
    //MARK: Setup TableView Cell
    
    func setUpCell(cell: BonusCell, indexPath: IndexPath) {
        
        let additionValue = (indexPath.row * 5)
        
        let numLabelArray = [cell.numFirst,cell.numSecond,cell.numThird,cell.numFour,cell.numFive]
        
        var blockValue = 1
        
        for (index, label) in numLabelArray.enumerated() {
            
            let indexNum = index+1
            blockValue = additionValue + indexNum
            label?.text = "\(blockValue)"
            
            let imgView = cell.contentView.viewWithTag(100+index) as! UIImageView
            let numberLabel = cell.contentView.viewWithTag(200+index) as! UILabel
            
            if blockValue <= consecutiveRoundCount {
                //heighlet the block
                imgView.alpha = 1.0
                imgView.image = UIImage(named: "bg_streak_info_pink.png")
                
                numberLabel.text = "\(blockValue)"
                numberLabel.textColor = UIColor(red: 255.0/255.0, green: 223.0/255.0, blue: 0.0/255.0, alpha: 1)
            } else {
                //unheighlet the block
                
                imgView.alpha = 0.75
                imgView.image = nil
                
                numberLabel.text = "\(blockValue)"
                numberLabel.textColor = UIColor.lightText
            }
        }
        
        cell.bonusNum.text = "+\(roundStrikeList[indexPath.row])"
        if blockValue <= consecutiveRoundCount {
            
            cell.bgGiftView.image = UIImage(named: "ic_streak_heart_l_50.png")
            cell.bonusNum.isHidden = true
            cell.bgGiftTopView.isHidden = false
        }
        else {
            
            cell.bgGiftView.image = UIImage(named: "ic_streak_heart_l.png")
            cell.bonusNum.isHidden = false
            cell.bgGiftTopView.isHidden = true
        }
   
        if indexPath.row == roundStrikeList.count-1 {
            
            cell.bgGiftView.image = UIImage(named: "ic_streak_chest.png")
            cell.bonusNum.isHidden = true
            cell.bgGiftTopView.isHidden = true
        }
    }
    
    // MARK: Display logic
    
    func displayListOfRoundStreak(viewModel: Bonus.RoundStreak.ViewModel) {
        let responseData = viewModel.content
        if responseData.count > 0 {
        roundStrikeList = responseData.sorted(by: <)
        }
        print(roundStrikeList)
        DispatchQueue.main.async {
            self.roundStrikeTable.reloadData()
        }
    }
    
    
    func displayAlert(loginFailure: Bonus.RoundStreakFailure) {
        
        let alert = UIAlertController(title: "Alert", message: loginFailure.alertString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        }))
        self.present(alert, animated: true, completion: {  })
    }
}


//MARK:UITableViewDataSource
extension BonusViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return roundStrikeList.count;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:BonusCell = (tableView.dequeueReusableCell(withIdentifier: BonusCell.getCellIdentifier()) as! BonusCell?)!
        self.setUpCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

//MARK:UITableViewDelegate
extension BonusViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width * 0.22;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }

}
