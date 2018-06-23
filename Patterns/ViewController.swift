//
//  ViewController.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet var textView: NSTextView!
	@IBOutlet var resultView: ResultView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textView.string = "aoe(“a”,”b”,”c”),(“d”,”e”,”f”)"
		NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
			self.keyDown(with: $0)
			return $0
		}
		// Do any additional setup after loading the view.
	}
	
	override func keyUp(with event: NSEvent) {
		let blocks = Parser.findParenthesis(string: textView.string)
		if blocks != [] {
			parseText()
		} else {
			resultView.string = textView.string
		}
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	func parseText() {
		let text = textView.string
		let blocks = Parser.findParenthesis(string: text)
		let arrays = Parser.separatebyCommas(array: blocks)
		// Rearrange array
		var pairArray = [String]()
		var rearrangedArray = [[String]]()
		for index1 in 0..<arrays[0].count {
			for index2 in 0..<arrays.count {
				pairArray.append(arrays[index2][index1])
			}
			rearrangedArray.append(pairArray)
			pairArray.removeAll()
		}
		// Redo code:
		let count = arrays[0].count
		var codeText = ""
		for index in 0..<count {
			// Replacing parenthesis:
			let text = Parser.replaceParenthesisWithStrings(string: textView.string, regexpArray: rearrangedArray[index])
			codeText.append("\(text)\n")
		}
		resultView.string = codeText
	}

}

