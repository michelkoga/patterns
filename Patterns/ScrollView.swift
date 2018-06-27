//
//  ScrollView.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/27.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ScrollView: NSScrollView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
		self.hasHorizontalScroller = true
		self.horizontalScrollElasticity = .automatic
		self.horizontalScrollElasticity = .automatic
		self.autohidesScrollers = true
		
    }
    
}
