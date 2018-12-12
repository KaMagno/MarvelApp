//
//  AlertRouter.swift
//  MarvelApp
//
//  Created by Kaique Magno Dos Santos on 24/04/18.
//  Copyright © 2018 Kaique Magno. All rights reserved.
//

import UIKit

class AlertRouter: NSObject {
    
    private(set) var presenter:AlertPresenter!
    
    init(message:String, buttonTitle:String) {
        //Instancing Variables
        
        super.init()
        
        //
        let storyboard = UIStoryboard(name: "AlertViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AlertViewController_Message")
        
        //Instancing View
        guard let view = viewController as? AlertViewController else {
            Logger.logError(in: self, message: "Could not cast \(viewController) as AlertViewController")
            return
        }
        
        //Instancing Interactor
        let interactor = AlertInteractor(message: message, buttonTitle: buttonTitle)
        //Instancing Presenter
        self.presenter = AlertPresenter(router: self, interactor: interactor, view: view)
        
    }
    
    // MARK: - Functions
    func dismiss(){
        self.presenter.view.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Static Functions
    static func showAlert(with message:String, buttonTitle:String = "Okay", sender:UIViewController? = nil) {
        let router = AlertRouter(message: message, buttonTitle: buttonTitle)
        
        DispatchQueue.main.async {
            if let sender = sender {
                sender.present(router.presenter.view, animated: true, completion: nil)
            }else{
                guard let mainWindows = UIApplication.shared.delegate?.window,
                    let rootViewController = mainWindows?.rootViewController else {
                    Logger.logError(in: self, message: "Could not get RootViewController")
                    return
                }
                rootViewController.present(router.presenter.view, animated: true, completion: nil)
            }
            
        }
    }
    
}
