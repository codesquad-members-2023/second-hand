//
//  ItemDetailBottomSectionView.swift
//  second-hand
//
//  Created by SONG on 2023/07/17.
//

import UIKit

class ItemDetailBottomSectionView: UIView {
    private var likeButton : UIButton? = nil
    private var priceLabel : UILabel? = nil
    private var chattingRoomButton : UIButton? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .systemBackgroundWeak
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setsetLikeButtonConstraints()
        setPriceLabelConstraints()
        setChattingRoomButtonConstraints()
    }
    func setLikeButton(isLike: Bool) {
        self.likeButton = UIButton(type: .system)
        
        switch isLike {
        case true:
            self.likeButton?.tintColor = .red
            self.likeButton?.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        default:
            self.likeButton?.tintColor = .black
            self.likeButton?.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func setsetLikeButtonConstraints() {
        guard let likeButton = likeButton else {
            return
        }
        
        if !self.subviews.contains(likeButton) {
            self.addSubview(likeButton)
        }
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                likeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 28/83),
                likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
                likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
                likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
            ]
        )
    }
    
    func setPriceLabel(price: Int) {
        self.priceLabel = UILabel(frame: .zero)
        self.priceLabel?.text = price.convertToMonetary() + "원"
        self.priceLabel?.font = .systemFont(ofSize: 15.0)
    }
    
    private func setPriceLabelConstraints() {
        guard let priceLabel = priceLabel else {
            return
        }
        
        guard let leadingAnchor = likeButton?.trailingAnchor else {
            return
        }
        
        guard let centerYAnchor = likeButton?.centerYAnchor else {
            return
        }
        
        if !self.subviews.contains(priceLabel) {
            self.addSubview(priceLabel)
        }
        
        guard let text = priceLabel.text else {
            return
        }
        
        let width = CGFloat(text.count * 13)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                priceLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 18/83),
                priceLabel.widthAnchor.constraint(equalToConstant: width),
                priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
                priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    func setChattingRoomButton() {
        
    }
    
    private func setChattingRoomButtonConstraints() {
        
    }
}
