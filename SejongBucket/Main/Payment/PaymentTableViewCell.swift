//
//  PaymentTableViewCell.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

class PaymentTableViewCell : UITableViewCell {
    static let identifier : String = "PaymentTableViewCell"
    //MARK: - UserInfo
    private let titlelabel : UILabel = {
        let label = UILabel()
        label.text = "학생회비 납부"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .white
        return label
    }()
    private let requestBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("납부 확인 요청", for: .normal)
        btn.setTitleColor(.pointColor, for: .normal)
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.backgroundColor = .shadowColor
        return btn
    }()
    private let bankText : UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.text = "-"
        view.textAlignment = .left
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    private let descriptionText : UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.text = "학생회비를 납부하셨다면 ‘납부 확인 요청'을 눌러주세요.\n요청 건에 대하여 확인 후 승인됩니다."
        view.textAlignment = .left
        view.textColor = .gray
        view.font = UIFont.boldSystemFont(ofSize: 12)
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
        self.contentView.addSubview(requestBtn)
        self.contentView.addSubview(bankText)
        self.contentView.addSubview(descriptionText)
        
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.height.equalTo(200)
        }
        titlelabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(30)
            make.height.equalTo(40)
            make.width.equalToSuperview().dividedBy(2)
        }
        requestBtn.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(30)
            make.leading.equalTo(titlelabel.snp.trailing).offset(10)
            make.height.equalTo(40)
        }
        bankText.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        descriptionText.snp.makeConstraints { make in
            make.top.equalTo(bankText.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(-0)
        }
    }
    func configure(account : AccountModel) {
        guard let bank = account.result?.bank,
              let accountNum = account.result?.accountNum,
              let ownerName = account.result?.ownerName else {
            return
        }
        
        let totalString = "\(bank)\n\(accountNum) \(ownerName)"
        self.bankText.text = totalString
    }
}
