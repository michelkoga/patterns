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
		//let font = NSFont(name: "Courier new", size: 12)
		//self.font = font
		//self.textStorage?.addAttribute(NSAttributedStringKey.font, value: font ?? "", range: NSRange(location: 0, length: self.string.count))
		
		//Make it Horizontaly Scrollable
		self.maxSize = NSMakeSize(.greatestFiniteMagnitude,.greatestFiniteMagnitude)
		self.isHorizontallyResizable = true
		self.textContainer?.widthTracksTextView = false
		self.textContainer?.containerSize = NSMakeSize(.greatestFiniteMagnitude,.greatestFiniteMagnitude)
	}
}
