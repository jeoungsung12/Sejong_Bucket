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
        setLayout()
        setBinding()
    }
}
//MARK: - 레이아웃
extension ReservationViewController {
    private func setLayout() {
        self.view.addSubview(departLabel)
        self.view.addSubview(lockerLabel)
        self.view.addSubview(reservLabel)
        self.view.addSubview(refreshBtn)
        let lockers : [[Locker]] = createDummyLockers(rows: 8, columns: 8)
        displayLockers(lockers)
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
        lockerScrollView.snp.makeConstraints { make in
            make.top.equalTo(reservLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalToSuperview().dividedBy(2.3)
        }
        reservBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-self.view.frame.height / 7)
            make.height.equalTo(60)
        }
    }
    private func displayLockers(_ lockers: [[Locker]]){
        //행
        let VerticalStack = UIStackView()
        VerticalStack.axis = .vertical
        VerticalStack.spacing = 10
        for (_, row) in lockers.enumerated() {
            //열
            let HorizontalStack = UIStackView()
            HorizontalStack.axis = .horizontal
            HorizontalStack.spacing = 10
            for (_, locker) in row.enumerated() {
                let lockerButton = UIButton(type: .system)
                lockerButton.setTitle("\(locker.row + 1)-\(locker.column + 1)", for: .normal)
                lockerButton.backgroundColor = locker.isReserved ? .keyColor : .lightGray
                lockerButton.tag = locker.id
                lockerButton.layer.cornerRadius = 10
                lockerButton.snp.makeConstraints { make in make.width.height.equalTo(60) }
                lockerButton.setTitleColor(.black, for: .normal)
                HorizontalStack.addArrangedSubview(lockerButton)
            }
            VerticalStack.addArrangedSubview(HorizontalStack)
        }
        lockerScrollView.addSubview(VerticalStack)
        VerticalStack.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().offset(-10)
            make.trailing.top.equalToSuperview().offset(10)
        }
    }
    // 더미 데이터로 묶은 사물함 배열 생성 함수 >> 아이디, 예약 가져오기
    private func createDummyLockers(rows: Int, columns: Int) -> [[Locker]] {
        var lockers = [[Locker]]()
        var lockerId = 1
        for row in 0..<rows {
            var rowLockers = [Locker]()
            for column in 0..<columns {
                let locker = Locker(id: lockerId, row: row, column: column, isReserved: false)
                rowLockers.append(locker)
                lockerId += 1
            }
            lockers.append(rowLockers)
        }
        return lockers
    }
}
//MARK: - 바인딩
extension ReservationViewController {
    private func setBinding() {
        
    }
}
