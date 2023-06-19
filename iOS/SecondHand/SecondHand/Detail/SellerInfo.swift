//
//  SellerInfo.swift
//  SecondHand
//
//  Created by Wood on 2023/06/12.
//

import UIKit

class SellerInfo: UIView {
    private var indicatorLabel = UILabel()
    private var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.indicatorLabel.text = "판매자 정보"
        self.nameLabel.lineBreakMode = .byCharWrapping
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutConstraint()
    }
    
    func configure(nameLabel: String) {
        self.nameLabel.text = nameLabel
    }
    
    private func addSubviews() {
        let subViews = [
            indicatorLabel,
            nameLabel
        ]
        
        subViews.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func layoutConstraint() {
        addSubviews()

        NSLayoutConstraint.activate([
            indicatorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            indicatorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        indicatorLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)

        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: indicatorLabel.trailingAnchor, constant: 16)
        ])
    }
}
