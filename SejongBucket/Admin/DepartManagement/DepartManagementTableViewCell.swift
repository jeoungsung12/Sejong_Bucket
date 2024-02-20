//
//  DepartManagementTableViewCell.swift
//  SejongBucket
//
//  Created by 정성윤 on 2024/02/20.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DepartManagementTableViewCell : UITableViewCell {
    static let identifier : String = "DepartManagementTableViewCell"
    //전체 뷰
    private let totalView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.pointColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    //학과
    private let departLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    //이동
    private let detailLabel : UILabel = {
        let label = UILabel()
        label.text = ">"
        label.textColor = .gray
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    private func setupUI() {
        self.contentView.backgroundColor = .white
        self.totalView.addSubview(departLabel)
        self.totalView.addSubview(detailLabel)
        self.contentView.addSubview(totalView)
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
        totalView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.bottom.equalToSuperview().inset(10)
        }
        departLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        detailLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalTo(departLabel.snp.trailing).offset(0)
        }
    }
}
//MARK: - 뷰컨트롤러와 연결
extension DepartManagementTableViewCell {
    func configure(depart : DepartInquiryModel) {
        self.departLabel.text = depart.title
    }
}
