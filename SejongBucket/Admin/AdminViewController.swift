//
//  AdminViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AdminViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let adminViewModel = AdminViewModel()
    //타이틀
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "관리자"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    //설명
    private let descriptionlabel : UITextView = {
        let text = UITextView()
        text.text = "학생 관리 페이지에서 학생들에게 권한을 부여할 수 있습니다!\n\n사물함 관리 페이지에서 사물함을 생성할 수 있습니다!"
        text.textColor = .gray
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 15)
        return text
    }()
    //버튼 스택
    private let btnStack : UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .equalCentering
        view.backgroundColor = .white
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension AdminViewController {
    func setLayout() {
        self.view.addSubview(titlelabel)
        self.view.addSubview(descriptionlabel)
        addBtnStack()
        self.view.addSubview(btnStack)
        
        titlelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        descriptionlabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
        btnStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionlabel.snp.bottom).offset(100)
            make.height.equalToSuperview().dividedBy(3)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
    func addBtnStack() {
        let btnlist : [String] = ["학생 관리", "사물함 생성", "학과 관리"]
        btnlist .forEach { btnlabel in
            let btn = UIButton()
            btn.setTitle(btnlabel, for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 10
            btn.layer.borderColor = UIColor.pointColor.cgColor
            btn.layer.borderWidth = 1
            btn.rx.tap.subscribe(onNext: {[weak self] in
                switch btnlabel {
                case "학생 관리" :
                    return (self?.navigationController?.pushViewController(LockerManagementViewController(), animated: true))!
                case "사물함 생성" :
                    return (self?.navigationController?.pushViewController(LockerManagementViewController(), animated: true))!
                case "학과 관리" :
                    if let role = UserDefaults.standard.string(forKey: "role") {
                        if role == "ROLE_MASTER"{
                            return (self?.navigationController?.pushViewController(DepartManagementViewController(), animated: true))!
                        }else{
                            return (self?.Alert())!
                        }
                    }else{ }
                default:
                    return (self?.navigationController?.pushViewController(MainViewController(), animated: true))!
                }
            })
            .disposed(by: disposeBag)
            btnStack.addArrangedSubview(btn)
            btn.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.leading.trailing.equalToSuperview().inset(0)
            }
        }
    }
}
//MARK: - 바인딩
extension AdminViewController {
    func setBinding() {
        
    }
    private func Alert() {
        let Alert = UIAlertController(title: nil, message: "접근 권한이 없습니다.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "확인", style: .default)
        Alert.addAction(OK)
        present(Alert, animated: true)
    }
}
