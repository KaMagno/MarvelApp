//
//  AlertViewController.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

//TODO: Create Animation to Alert
class AlertViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var outletAlertView: UIView!
    @IBOutlet weak var outletMessageLabel: UILabel!
    @IBOutlet weak var outletConfirmButton: UIButton!
    
    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var presenter:AlertPresenter!
    
    // MARK: - UIViewController
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
        self.presenter.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setupView() {
        self.outletAlertView.clipsToBounds = true
        self.outletAlertView.layer.borderColor = UIColor.black.cgColor
        self.outletAlertView.layer.borderWidth = 2.0
        self.outletAlertView.layer.cornerRadius = 10.0
    }
    
    private func setupGesture() {let tap = UITapGestureRecognizer.init(target: self, action: #selector(AlertViewController.handlerTapGesture(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: Public
    func set(message:String) {
        self.outletMessageLabel.text = message
    }
    
    func set(buttonTitle:String) {
        self.outletConfirmButton.setTitle(buttonTitle, for: .normal)
    }
    
    @objc func handlerTapGesture(_ tapGestureRecognizer:UITapGestureRecognizer) {
        self.presenter.didTapCancel()
    }
    
    // MARK: - IBActions
    @IBAction func tapCancelButton(_ sender: UIButton) {
        self.presenter.didTapCancel()
    }
    @IBAction func tapConfirmButton(_ sender: UIButton) {
        self.presenter.didTapConfirm()
    }
}
