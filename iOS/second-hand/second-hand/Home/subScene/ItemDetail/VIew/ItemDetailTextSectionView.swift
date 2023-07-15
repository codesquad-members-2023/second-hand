//
//  ItemDetailTextSectionView.swift
//  second-hand
//
//  Created by SONG on 2023/07/15.
//

import UIKit

class ItemDetailTextSectionView: UIScrollView {
    private var sellerInfoView : SellerInfoView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.contentSize = CGSize(width: self.frame.width, height: self.frame.height)
        setSellerInfoConstraints()

    }
    
    func setSellerInfoView(sellerName: String) {
        self.sellerInfoView = SellerInfoView(sellerName: sellerName)
        setSellerInfoConstraints()
    }
    
    
    private func setSellerInfoConstraints() {
        guard let sellerInfoView = sellerInfoView else {
            return
        }
        
        if !self.subviews.contains(sellerInfoView) {
            self.addSubview(sellerInfoView)
        }
 
        sellerInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                sellerInfoView.topAnchor.constraint(equalTo: self.topAnchor),
                sellerInfoView.widthAnchor.constraint(equalToConstant: self.frame.width - 30),
                sellerInfoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 54/491),
                sellerInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ]
        )
        
    }
    
}
