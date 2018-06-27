//
//  ResultView.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ResultView: NSTextView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.isEditable = false
		//self.font = NSFont(name: "Courier", size: 14)
    }
    
}
