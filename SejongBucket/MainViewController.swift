//
//  ViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SwiftKeychainWrapper
class MainViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let mainViewModel = MainViewModel()
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.allowsSelection = false
        view.isScrollEnabled = false
        view.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
        view.register(LockerInfoTableViewCell.self, forCellReuseIdentifier: LockerInfoTableViewCell.identifier)
        view.register(PaymentTableViewCell.self, forCellReuseIdentifier: PaymentTableViewCell.identifier)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - Layout
extension MainViewController {
    func setLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(self.view.frame.height / 10)
        }
    }
}
//MARK: - TableView
extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as? UserInfoTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LockerInfoTableViewCell.identifier, for: indexPath) as? LockerInfoTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.identifier, for: indexPath) as? PaymentTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
//MARK: - Binding
extension MainViewController {
    private func setBinding() {
        mainViewModel.UserInfoInput.onNext(())
        mainViewModel.UserInfoResult.subscribe(onNext: { userInfo in
            if userInfo.status == 200 {
                if let userInfoCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UserInfoTableViewCell {
                    userInfoCell.configure(userInfo: userInfo)
                }
                if let lockerInfoCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? LockerInfoTableViewCell {
                    lockerInfoCell.configure(userInfo: userInfo)
                }
            }else{print("requestUserInfo - Error")}
        })
        .disposed(by: disposeBag)
        mainViewModel.AccountInput.onNext(())
        mainViewModel.AccountResult.subscribe(onNext: { Account in
            if Account.status == 200 {
                if let paymentInfoCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PaymentTableViewCell {
                    paymentInfoCell.configure(account: Account)
                }
            }else{print("requestAccount - Error")}
        })
        .disposed(by: disposeBag)
        mainViewModel.errorOccured.subscribe(onNext: { _ in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
        .disposed(by: disposeBag)
    }
}
