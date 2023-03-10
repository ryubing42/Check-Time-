//
//  ToolView.swift
//  Cookie-Health
//
//  
//

import UIKit

class ToolView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        self.configView()
    }
    
    private func configView() {
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.6
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.6
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
