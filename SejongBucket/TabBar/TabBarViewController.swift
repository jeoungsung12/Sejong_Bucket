//
//  TabBarViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

class TabBarViewController : UITabBarController {
    private let disposeBag = DisposeBag()
    private let tabBarViewModel = TabBarViewModel()
    private let setting : UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: TabBarViewController.self, action: nil)
        btn.tintColor = .pointColor
        return btn
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setViewControllers([self], animated: animated)
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .pointColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .pointColor
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.layer.shadowColor = UIColor.pointColor.cgColor
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.tabBar.layer.shadowRadius = 1
        self.navigationItem.rightBarButtonItem = setting
        self.title = ""
        setTabBar()
        setBinding()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.hidesBackButton = false
    }
    func setTabBar() {
        let mainVC = MainViewController()
        let mainTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "mainTab"), tag: 0)
        mainVC.tabBarItem = mainTabBarItem
        
        let reservVC = ReservationViewController()
        let reservTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "lockerTab"), tag: 1)
        reservVC.tabBarItem = reservTabBarItem
        
        let feedBackVC = FeedBackViewController()
        let feedBackTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "feedbackTab"), tag: 2)
        feedBackVC.tabBarItem = feedBackTabBarItem
        
        if UserDefaults.standard.string(forKey: "role") == "ROLE_MASTER" || UserDefaults.standard.string(forKey: "role") == "ROLE_ADMIN" {
            let adminVC = AdminViewController()
            let adminTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "adminTab"), tag: 3)
            adminVC.tabBarItem = adminTabBarItem
            
            self.viewControllers = [mainVC, reservVC, feedBackVC, adminVC]
        }else{
            self.viewControllers = [mainVC, reservVC, feedBackVC]
        }
    }
}
//MARK: - 탭바 설정
extension TabBarViewController {
    func setBinding() {
        self.rx.didSelect
            .subscribe(onNext: { [weak self] viewController in
                if let index = self?.viewControllers?.firstIndex(of: viewController) {
                    self?.tabBarViewModel.inputTrigger.onNext(index)
                }
            })
            .disposed(by: disposeBag)
        tabBarViewModel.outputResult
            .drive(onNext: { title in
                print("Selected tab title : \(title)")
            })
            .disposed(by: disposeBag)
        setting.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.alertForLogout()
            })
            .disposed(by: disposeBag)
        tabBarViewModel.logoutResult
            .subscribe(onNext: {[weak self] logout in
                if logout.status == 200 {
                    KeychainWrapper.standard.removeAllKeys()
                    self?.navigationController?.pushViewController(LoginViewController(), animated: true)
                }
            })
            .disposed(by: self.disposeBag)
//        tabBarViewModel.errorOccured.subscribe { error in
//            self.navigationController?.pushViewController(LoginViewController(), animated: true)
//        }
//        .disposed(by: disposeBag)
//        tabBarViewModel.reissueError.subscribe { error in
//            if error == false{
//                self.navigationController?.pushViewController(LoginViewController(), animated: true)
//            }
//        }
//        .disposed(by: disposeBag)
    }
    private func alertForLogout() {
        let Alert = UIAlertController(title: "로그아웃", message: nil, preferredStyle: .alert)
        let OK = UIAlertAction(title: "확인", style: .default){ _ in
            self.tabBarViewModel.settingTrigger.onNext(())
        }
        let Cancle = UIAlertAction(title: "취소", style: .destructive)
        Alert.addAction(OK)
        Alert.addAction(Cancle)
        present(Alert, animated: true)
    }
}
