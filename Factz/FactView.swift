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
			if factVM.fact == nil {
				ProgressView()
			} else {
				if let fact = factVM.fact {
					Text(fact)
						.multilineTextAlignment(.center)
				}
			}
		}
		.padding()
		.onAppear {
			factVM.getFact()
		}
	}
}

struct FactView_Previews: PreviewProvider {
	static var previews: some View {
		FactView()
			.environmentObject(FactViewModel())
	}
}
