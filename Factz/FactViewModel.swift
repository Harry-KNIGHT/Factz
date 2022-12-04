//
//  FactViewModel.swift
//  Factz
//
//  Created by Elliot Knight on 04/12/2022.
//

import Foundation

final public class FactViewModel: ObservableObject {
	@Published var fact: String? = nil

	public func getFact() {
		Task {
			do {
				fact = try await FactApi.fetchFact()
			} catch {
				throw error
			}
		}
	}
}
