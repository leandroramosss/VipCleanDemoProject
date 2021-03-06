//
//  MainPageViewController.swift
//  VIPLogin
//
//  Created by Leandro Ramos on 11/1/20.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainPageDisplayLogic: class
{
  func displaySomething(viewModel: MainPage.Something.ViewModel)
}

class MainPageViewController: UIViewController, MainPageDisplayLogic
{
  var interactor: MainPageBusinessLogic?
  var router: (NSObjectProtocol & MainPageRoutingLogic & MainPageDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MainPageInteractor()
    let presenter = MainPagePresenter()
    let router = MainPageRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    view.backgroundColor = .blue
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = MainPage.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: MainPage.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
