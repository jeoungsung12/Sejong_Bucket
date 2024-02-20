//
//  AddDepartViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AddDepartViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let addDeparttViewModel = AddDepartViewModel()
    
    //타이틀
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "대표학과 생성"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    //이미지
    private let logoimage : UIImageView = {
        let view = UIImageView(image: UIImage(named: "LogoShadow"))
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    //학과이름
    private let departText : UITextField = {
        let text = UITextField()
        text.placeholder = "학과 이름"
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 15)
        text.layer.borderColor = UIColor.keyColor.cgColor
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 10
        return text
    }()
    //생성 버튼
    private let makeBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("만들기", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .pointColor
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension AddDepartViewController {
    func setLayout() {
        self.view.addSubview(titlelabel)
        self.view.addSubview(logoimage)
        self.view.addSubview(departText)
        self.view.addSubview(makeBtn)
        titlelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        logoimage.snp.makeConstraints { make in
            make.center.equalToSuperview().offset(-60)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview().inset(0)
        }
        departText.snp.makeConstraints { make in
            make.top.equalTo(logoimage.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        makeBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}
//MARK: - 바인딩
extension AddDepartViewController {
    func setBinding() {
        makeBtn.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.addDeparttViewModel.nameInputTrigger.onNext((self?.departText.text)!)
            })
            .disposed(by: disposeBag)
        addDeparttViewModel.outputResult
            .subscribe(onNext: { [weak self] result in
                print("통신 결과 \(result)")
                if result.status == 200 {
                    self?.moveToDepartManagement()
                }
            })
            .disposed(by: disposeBag)
    }
    private func moveToDepartManagement() {
        let departManagementVC = DepartManagementViewController()
        navigationController?.pushViewController(departManagementVC, animated: true)
        navigationController?.viewControllers.removeAll(where: { $0 is AddDepartViewController })
    }
}
