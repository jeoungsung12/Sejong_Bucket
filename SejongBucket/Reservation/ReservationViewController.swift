//
//  ReservationViewController.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ReservationViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let reservationViewModel = ReservationViewModel()
    //로딩인디케이터
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .gray
        return view
    }()
    //학과 타이틀
    private let departLabel : UILabel = {
        let label = UILabel()
        label.text = "시각디자인학과"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    //사물함 설명
    private let lockerLabel : UILabel = {
        let label = UILabel()
        label.text = "센터 b107 사물함"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    //예약가능 시간
    private let reservLabel : UILabel = {
        let label = UILabel()
        label.text = "2023.09.08(10:00) ~ 2023.09.10(18:00)"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.backgroundColor = .white
        return label
    }()
    //리프레시 버튼
    private let refreshBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        btn.tintColor = .pointColor
        return btn
    }()
    //예약 확인 버튼
    private let reservBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("예약", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 20
        btn.backgroundColor = .pointColor
        return btn
    }()
    //사물함 전체
    private let lockerScrollView : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.isScrollEnabled = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setBinding()
        setLayout()
    }
}
//MARK: - 레이아웃
extension ReservationViewController {
    private func setLayout() {
        print("레이아웃")
        self.view.addSubview(departLabel)
        self.view.addSubview(lockerLabel)
        self.view.addSubview(reservLabel)
        self.view.addSubview(refreshBtn)
        self.view.addSubview(loadingIndicator)
//        test()
        self.view.addSubview(lockerScrollView)
        self.view.addSubview(reservBtn)
        departLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(self.view.frame.height / 8.5)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        lockerLabel.snp.makeConstraints { make in
            make.top.equalTo(departLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        reservLabel.snp.makeConstraints { make in
            make.top.equalTo(lockerLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        refreshBtn.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.leading.equalTo(reservLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(lockerLabel.snp.bottom).offset(25)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.top.equalTo(refreshBtn.snp.bottom).offset((50))
            make.leading.trailing.equalToSuperview().inset(0)
        }
        lockerScrollView.snp.makeConstraints { make in
            make.top.equalTo(loadingIndicator.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalToSuperview().dividedBy(2.3)
        }
        reservBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 7)
            make.height.equalTo(60)
        }
        self.loadingIndicator.startAnimating()
    }
    private func test() {
        let Btn = UIButton()
        Btn.backgroundColor = .black
        lockerScrollView.addSubview(Btn)
        Btn.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(0)
        }
        DispatchQueue.main.async{
            self.loadingIndicator.stopAnimating()
        }
    }
    private func displayLockers(_ lockersInfo: [LockerInfo]) {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        var index = 0
        for lockerInfo in lockersInfo {
            let horizontalStack = UIStackView()
            horizontalStack.axis = .horizontal
            horizontalStack.spacing = 10
            
            for lockerDetail in lockerInfo.lockerDetail {
                let lockerButton = UIButton(type: .system)
                let lockerTitle = "\(lockerDetail.row_num)-\(lockerDetail.column_num)"
                lockerButton.setTitle(lockerTitle, for: .normal)
                lockerButton.backgroundColor = lockerDetail.status == "NON_RESERVED" ? .red : .lightGray
                lockerButton.tag = lockerDetail.id
                lockerButton.layer.cornerRadius = 10
                lockerButton.snp.makeConstraints { make in make.width.height.equalTo(60) }
                lockerButton.setTitleColor(.black, for: .normal)
                horizontalStack.addArrangedSubview(lockerButton)
            }
            print("사물함 갯수 \(index)")
            index += 1
            verticalStack.addArrangedSubview(horizontalStack)
        }
        lockerScrollView.addSubview(verticalStack)
        verticalStack.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().offset(-10)
            make.trailing.top.equalToSuperview().offset(10)
        }
        DispatchQueue.main.async{
            self.loadingIndicator.stopAnimating()
        }
    }
}
//MARK: - 바인딩
extension ReservationViewController {
    private func setBinding() {
        reservationViewModel.LockerInquiry.onNext(())
        reservationViewModel.LockerResult
            .observe(on: MainScheduler.instance)
            .subscribe { result in
            if let lockerResult = result.element?.result {
                if let lockersInfo = lockerResult.lockersInfo {
                    self.displayLockers(lockersInfo)
                }
            }
        }
        .disposed(by: disposeBag)
    }
}
