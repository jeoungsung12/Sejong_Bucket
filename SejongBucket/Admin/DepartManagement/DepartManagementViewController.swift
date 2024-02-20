//
//  DepartManagementViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DepartManagementViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let departManagementViewModel = DepartManagementViewModel()
    
    //타이틀
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "대표학과 관리"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    //설명
    private let descriptionlabel : UITextView = {
        let text = UITextView()
        text.text = "대표 학과 v"
        text.textColor = .gray
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 10)
        return text
    }()
    //추가버튼
    private let addBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: DepartManagementViewController.self, action: nil)
        btn.tintColor = .pointColor
        return btn
    }()
    //대표학과 테이블뷰
    private let tableView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.register(DepartManagementTableViewCell.self, forCellReuseIdentifier: DepartManagementTableViewCell.identifier)
        return view
    }()
    //백버튼
    private let backBtn : UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "◀  관리자", style: .plain, target: DepartManagementViewController.self, action: nil)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = ""
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension DepartManagementViewController {
    func setLayout() {
        self.navigationItem.leftBarButtonItem = backBtn
        self.navigationItem.rightBarButtonItem = addBtn
        self.view.addSubview(titlelabel)
        self.view.addSubview(descriptionlabel)
        self.view.addSubview(tableView)
        titlelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        descriptionlabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(descriptionlabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}
//MARK: - 바인딩
extension DepartManagementViewController{
    func setBinding() {
        departManagementViewModel.DepartInput.accept(())
        departManagementViewModel.DepartResult
            .bind(to: tableView.rx.items(cellIdentifier: DepartManagementTableViewCell.identifier, cellType: DepartManagementTableViewCell.self)) { index, model, cell in
                cell.configure(depart: model)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        tableView.rx.modelSelected(DepartInquiryModel.self)
            .subscribe(onNext: {[weak self] selectedModel in
                self?.navigationController?.pushViewController(DetailDepartViewController(major : selectedModel), animated: true)
            })
            .disposed(by: disposeBag)
        addBtn.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.navigationController?.pushViewController(AddDepartViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        backBtn.rx.tap
            .subscribe(onNext: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
        departManagementViewModel.errorOccured.subscribe { error in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        .disposed(by: disposeBag)
    }
}
