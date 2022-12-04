//
//  FactAPI.swift
//  Factz
//
//  Created by Elliot Knight on 04/12/2022.
//

import Foundation

struct FactApi {
	enum ApiError: Error { case outOfBounds, badResponse, urlNotFound }

	static func fetchFact() async throws -> String {
		let factURL = "https://numbersapi.p.rapidapi.com/6/21/date/?rapidapi-key=272c22cc63msh3b43f346044bf33p1068aajsne078e6aff743"

		guard let url = URL(string: factURL) else { throw ApiError.urlNotFound }

		let (_ , response) = try await URLSession.shared.data(from: url)

		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw ApiError.outOfBounds }

		do {
			return try String(contentsOf: url)
		} catch {
			throw error
		}
	}
}
