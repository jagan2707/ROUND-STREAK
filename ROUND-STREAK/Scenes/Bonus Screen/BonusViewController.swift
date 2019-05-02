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
func displayAlert(dataFailure: Bonus.RoundStreakFailure)
}

class BonusViewController: UIViewController, BonusDisplayLogic {
    
    var interactor: BonusBusinessLogic?
    var router: BonusRoutingLogic?
    var loginRespose: Register.Login.ViewModel.DisplayedData?
    var consecutiveRoundCount: Int = 0
    var roundStrikeList = [Int]()
    var loadingView: LoadingView?
    @IBOutlet weak var roundStrikeTable: UITableView!
    @IBOutlet weak var roundCountLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    
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
        if (!Reachability.isConnectedToNetwork()){
            self.showNetworkAlert()
            return
        }
        addActivityIndicator()
        if let accessToken = loginRespose?.accessToken {
        let request = Bonus.RoundStreak.Request(accessToken: accessToken)
        interactor?.getListOfRounds(request: request)
        }
    }
    
    @IBAction func didTouchOnBack() {
        router?.getBackToLogin()
    }
    
    //MARK: Setup TableView Cell
    
   private func setUpCell(cell: BonusCell, indexPath: IndexPath) {
        let additionValue = (indexPath.row * 5)
        var blockValue = 1
        for index in 0...4 {
            let indexNum = index+1
            blockValue = additionValue + indexNum
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
        cell.bonusNum.textColor = .white
        if blockValue <= consecutiveRoundCount {
            //Received
            cell.bgGiftView.image = UIImage(named: "ic_streak_heart_l_50.png")
            cell.bonusNum.isHidden = false
            cell.bonusNum.textColor = .lightText
            cell.bgGiftTopView.isHidden = false
        } else {
            // Not Received Showing heart icon with count
            cell.bgGiftView.image = UIImage(named: "ic_streak_heart_l.png")
            cell.bonusNum.isHidden = false
            cell.bgGiftTopView.isHidden = true
        }
   
        if indexPath.row == roundStrikeList.count-1 {
            // last row showing gift Icon
            cell.bgGiftView.image = UIImage(named: "ic_streak_chest.png")
            cell.bonusNum.isHidden = true
            cell.bgGiftTopView.isHidden = true
        }
    }
    
    private func setUpHeaderCell(cell: HeaderCell) {
        self.setConsequtiveRounds(cell: cell)
    }
    
    private func setConsequtiveRounds(cell: HeaderCell) {
        let text = "You have consecutively played : \(consecutiveRoundCount) rounds"
        let range = (text as NSString).range(of: String(consecutiveRoundCount))
        let attribute = NSMutableAttributedString.init(string: text)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 232.0/250.0, green: 200/250.0, blue: 0/250.0, alpha: 1.0) , range:range)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20.0), range: range)
        cell.consecutiveRoundLabel.attributedText = attribute
    }
    
    //MARK: Loader
    private func addActivityIndicator() {
        loadingView = LoadingView(frame:(self.view.bounds))
        self.view.addSubview(loadingView!)
    }
    
    private func removeActivityIndicator() {
        loadingView?.removeFromSuperview()
    }
    
    // MARK: Display logic
    func displayListOfRoundStreak(viewModel: Bonus.RoundStreak.ViewModel) {
        let responseData = Array(Set(viewModel.content))
        if responseData.count > 0 {
        roundStrikeList = responseData.sorted(by: <)
        }
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            self.roundStrikeTable.reloadData()
        }
    }
    
    func displayAlert(dataFailure: Bonus.RoundStreakFailure) {
        DispatchQueue.main.async {
            self.removeActivityIndicator()
            let alert = UIAlertController(title: "Round Streak", message: dataFailure.alertString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            }))
            self.present(alert, animated: true, completion: {  })
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


//MARK:UITableViewDataSource
extension BonusViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else {
            return roundStrikeList.count
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
     
        if indexPath.section == 1 {
        let cell:BonusCell = (tableView.dequeueReusableCell(withIdentifier: BonusCell.getCellIdentifier()) as! BonusCell?)!
        self.setUpCell(cell: cell, indexPath: indexPath)
            return cell
        } else {
            
            let cell:HeaderCell = (tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell?)!
            self.setUpHeaderCell(cell: cell)
            return cell
        }
            
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

//MARK:UITableViewDelegate
extension BonusViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
        return self.view.frame.size.width * 0.25;
        } else {
            return 235
        }
    }
}
