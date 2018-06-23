//
//  WriteView.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class WriteView: NSTextView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.isAutomaticSpellingCorrectionEnabled = false
        // Drawing code here.
    }
    
}