//
//  LockerManagementViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LockerManagementViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let lockerManagementViewModel = LockerManagementViewModel()
    //타이틀
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "사물함 생성"
        label.textColor = .pointColor
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    //학과 사물함
    private let departlabel : UILabel = {
        let text = UILabel()
        text.text = "시각디자인학과"
        text.textColor = .black
        text.textAlignment = .left
        text.font = UIFont.boldSystemFont(ofSize: 30)
        return text
    }()
    //예약 시작
    private let reservStart : UILabel = {
        let label = UILabel()
        label.text = "예약 시작 시각"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    //예약 시작 피커
    private let startPicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 10
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor.gray.cgColor
        return picker
    }()
    //예약 종료
    private let reservEnd : UILabel = {
        let label = UILabel()
        label.text = "예약 종료 시각"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    //예약 종료 피커
    private let endPicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = .white
        picker.layer.cornerRadius = 10
        picker.layer.borderWidth = 1
        picker.layer.borderColor = UIColor.gray.cgColor
        return picker
    }()
    //사물함 크기
    //가로
    private let rowtext : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.cornerRadius = 10
        text.layer.borderColor  = UIColor.pointColor.cgColor
        text.layer.borderWidth = 1
        text.placeholder = "행"
        text.textColor = .black
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    //곱
    private let mulicon : UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "X"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    //세로
    private let columntext : UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        text.layer.cornerRadius = 10
        text.layer.borderColor  = UIColor.pointColor.cgColor
        text.layer.borderWidth = 1
        text.placeholder = "열"
        text.textAlignment = .center
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 20)
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
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension LockerManagementViewController {
    private func setLayout() {
        self.view.addSubview(titlelabel)
        self.view.addSubview(departlabel)
        
        self.view.addSubview(reservStart)
        self.view.addSubview(startPicker)
        self.view.addSubview(reservEnd)
        self.view.addSubview(endPicker)
        
        self.view.addSubview(rowtext)
        self.view.addSubview(mulicon)
        self.view.addSubview(columntext)
        
        self.view.addSubview(makeBtn)
        
        titlelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        departlabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.top.equalTo(titlelabel.snp.bottom).offset(10)
        }
        reservStart.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(departlabel.snp.bottom).offset(50)
            make.height.equalTo(30)
        }
        startPicker.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(reservStart.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        reservEnd.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(startPicker.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        endPicker.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(reservEnd.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        rowtext.snp.makeConstraints { make in
            make.top.equalTo(endPicker.snp.bottom).offset(100)
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.leading.equalToSuperview().offset(50)
        }
        columntext.snp.makeConstraints { make in
            make.top.equalTo(endPicker.snp.bottom).offset(100)
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.trailing.equalToSuperview().offset(-50)
        }
        mulicon.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(endPicker.snp.bottom).offset(120)
            make.leading.equalTo(rowtext.snp.trailing).offset(10)
            make.trailing.equalTo(columntext.snp.leading).offset(-10)
        }
        makeBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
}
//MARK: - 바인딩
extension LockerManagementViewController {
    private func setBinding() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let startReservationTime = dateFormatter.string(from: startPicker.date)
        let endReservationTime = dateFormatter.string(from: endPicker.date)
        makeBtn.rx.tap
            .subscribe(onNext: { _ in
                self.lockerManagementViewModel.inputTrigger.onNext(CreateLockerServiceModel(endReservationTime: endReservationTime, lockerName: "AI로봇학과 사물함", numberIncreaseDirection: "DOWN", startReservationTime: startReservationTime, totalColumn: self.columntext.text!, totalRow: self.rowtext.text!,userTiers: ["APPLICANT"]))
            })
            .disposed(by: disposeBag)
        lockerManagementViewModel.outputResult
            .subscribe(onNext: { result in
                if result.status == 200 {
                    self.Alert()
                }else{
                    print("createLocker - error")
                }
            })
            .disposed(by: disposeBag)
        lockerManagementViewModel.errorOccured.subscribe { error in
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        .disposed(by: disposeBag)
    }
    private func Alert() {
        let Alert = UIAlertController(title: nil, message: "사물함 생성이 완료되었습니다.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "확인", style: .default){ _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        Alert.addAction(OK)
        present(Alert, animated: true)
    }
}
