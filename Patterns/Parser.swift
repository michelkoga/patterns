//
//  Parser.swift
//  Patterns
//
//  Created by 古賀ミッシェル on 2018/06/22.
//  Copyright © 2018 古賀ミッシェル. All rights reserved.
//

import Foundation
class Parser {
	static func matches(for regex: String, in text: String) -> [String] {
		
		do {
			let regex = try NSRegularExpression(pattern: regex)
			let results = regex.matches(in: text,
										range: NSRange(text.startIndex..., in: text))
			return results.map {
				String(text[Range($0.range, in: text)!])
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
	static func findBeforeBlock(string: String) -> String {
		var result = ""
		let matches = self.matches(for: "(.|\n)*<", in: string)
		result = matches.first!
		result.removeLast()
		return result
	}
	static func findAfterBlock(string: String) -> String {
		var result = ""
		let matches = self.matches(for: ">(.|\n)*", in: string)
		result = matches.first!
		result.removeFirst()
		return result
	}
	static func findBlock(string: String) -> String {
		var result = ""
		let matches = self.matches(for: "(\\<(.|\n)*\\>)", in: string)
		let match = matches.first
		if match != nil {
			result = match!
			result.removeFirst()
			result.removeLast()
		}
		return result
	}
	
	static func findParenthesis(string: String) -> [String] {
		var result = [String]()
		let matches = self.matches(for: "\\((.*?)\\)", in: string)
		if !matches.isEmpty {
			for string in matches {
				let strings = string.dropFirst().dropLast()
				result.append(String(strings))
			}
		}
		return result
	}
	
	static func separatebyCommas(array: [String]) -> [[String]] {
		var arrays = [[String]]()
		for string in array {
			let result = string.components(separatedBy: ",")
			arrays.append(result)
		}
		return arrays
	}
	static func findFirstParenthesis(string: String) -> String {
		var result = ""
		let matches = self.matches(for: "\\((.*?)\\)", in: string)
		let match = matches.first
		if match != nil {
			result = match!
		}
		return result
	}
	static func replaceParenthesisWithStrings(string: String, regexpArray: [String]) -> String {
		var text = string
		//var result = ""
		for index in 0..<regexpArray.count {
			// get regex:
			let regex = findFirstParenthesis(string: text)
			// Replace:
			 text = text.replacingOccurrences(of: regex, with: regexpArray[index])
		}
		return text
	}
}
