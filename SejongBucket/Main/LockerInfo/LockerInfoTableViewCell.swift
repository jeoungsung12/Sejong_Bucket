//
//  LockerInfoTableViewCell.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

class LockerInfoTableViewCell : UITableViewCell {
    static let identifier : String = "LockerInfoTableViewCell"
    //MARK: - UserInfo
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "사물함 정보"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    //이름,학과,학생회비 타이틀 스택
    private let titleStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    //이름,학과,학생회비 내용 스택
    private let descriptionStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setLayout()
    }
    private func setLayout() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(titlelabel)
        addTitleStack()
        self.contentView.addSubview(titleStack)
        addDescriptionStack()
        self.contentView.addSubview(descriptionStack)
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(200)
        }
        titlelabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(30)
            make.height.equalTo(30)
        }
        titleStack.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(40)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(60)
        }
        descriptionStack.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(40)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(titleStack.snp.trailing).offset(10)
        }
    }
    private func addTitleStack() {
        let list = ["위치", "번호", "사용기간"]
        list.forEach { title in
            let label = UILabel()
            label.backgroundColor = .white
            label.text = title
            label.textColor = .gray
            label.font = UIFont.boldSystemFont(ofSize: 15)
            titleStack.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(0)
            }
        }
    }
    private func addDescriptionStack() {
        let list = ["-", "-", "-"]
        list.forEach { title in
            let label = UILabel()
            label.backgroundColor = .white
            label.text = title
            label.font = UIFont.boldSystemFont(ofSize: 15)
            descriptionStack.addArrangedSubview(label)
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(0)
            }
        }
    }
    func configure(userInfo : UserInfoModel) {
        for (index, subview) in descriptionStack.arrangedSubviews.enumerated() {
            guard let label = subview as? UILabel else {
                continue
            }
            switch index {
            case 0:
                label.text = userInfo.result?.reservedLockerName
            case 1:
                label.text = userInfo.result?.reservedLockerDetailNum
            case 2:
//                label.text = userInfo.result?.reservedLockerDetailId
                label.textColor = (userInfo.result?.userTier == "미납") ? .pointColor : .black
            default:
                break
            }
        }
    }
}
