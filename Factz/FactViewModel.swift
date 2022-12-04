//
//  FactViewModel.swift
//  Factz
//
//  Created by Elliot Knight on 04/12/2022.
//

import Foundation

final class FactViewModel: ObservableObject {
	@Published var fact: String? = nil

	func fetchFact() throws {
		let factURL = "https://numbersapi.p.rapidapi.com/6/21/date/?rapidapi-key=272c22cc63msh3b43f346044bf33p1068aajsne078e6aff743"
		if let url = URL(string: factURL) {
			do {
				let contents = try String(contentsOf: url)
				self.fact = contents
			} catch {
				throw error
			}
		}
	}
}



