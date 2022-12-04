//
//  FactzApp.swift
//  Factz
//
//  Created by Elliot Knight on 04/12/2022.
//

import SwiftUI

@main
struct FactzApp: App {
	@StateObject var factVM = FactViewModel()
    var body: some Scene {
        WindowGroup {
            FactView()
				.environmentObject(factVM)
        }
    }
}
