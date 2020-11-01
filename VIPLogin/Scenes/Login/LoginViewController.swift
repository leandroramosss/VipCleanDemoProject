//
//  LoginViewController.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 10/29/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginDisplayLogic: class {
    func getData(viewModel: LoginModel.Fetch.ViewModel)
    func displayErrorAlert(error: String)
    func transitionToMain()
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
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
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBAction func buttonAction(_ sender: Any) {
        doLogin()
    }
    
    func doLogin() {
        let request = LoginModel.Fetch.Request(email: "leandro@mailinator.com", password: "123456")
        interactor?.startLoginRequest(request: request)
    }
    
    func getData(viewModel: LoginModel.Fetch.ViewModel) {
        let token = viewModel.token
        print(token)
    }
    
    func displayErrorAlert(error: String) {
        let alert = UIAlertController(title: "error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitionToMain() {
        self.performSegue(withIdentifier: Constants.Indentifiers.mainPage, sender: self)
    }

}
