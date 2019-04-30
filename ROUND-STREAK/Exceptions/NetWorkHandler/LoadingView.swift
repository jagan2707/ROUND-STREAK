//
//  LoadingView.swift
//  ROUND-STREAK
//
//  Created by jagadeesh on 30/4/2562 BE.
//  Copyright © 2562 jagadeesh. All rights reserved.

import UIKit

class LoadingView: UIView {
  
  private let spinner = UIActivityIndicatorView(style:.whiteLarge)
  
  override init(frame: CGRect) {
    
    spinner.startAnimating()
    
    super.init(frame: frame)
    
    addSubview(spinner)
    backgroundColor = UIColor.black
    self.alpha = 0.3
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    spinner.center = center
  }
  
}
