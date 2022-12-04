//
//  FactView.swift
//  Factz
//
//  Created by Elliot Knight on 04/12/2022.
//

import SwiftUI

struct FactView: View {
	@EnvironmentObject var factVM: FactViewModel
	var body: some View {
		VStack {
			if let fact = factVM.fact {
				Text(fact)
					.multilineTextAlignment(.center)
			}
		}
		.padding()
		.onAppear {
			Task {
				do {
					try factVM.fetchFact()
				} catch {
					throw error
				}
			}
		}
	}
}

struct FactView_Previews: PreviewProvider {
	static var previews: some View {
		FactView()
			.environmentObject(FactViewModel())
	}
}
