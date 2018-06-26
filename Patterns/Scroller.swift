//
//  Scroller.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/27.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class Scroller: NSScroller {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.controlSize = NSControl.ControlSize(rawValue: 200)!
		self.isHidden = false
		
    }
}
