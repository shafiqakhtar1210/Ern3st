//
//  ContentView.swift
//  Ern3st
//
//  Created by Muhammad Ali on 31/07/2023.
//

import SwiftUI
struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        Button("MyViewController") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            RepresentableSplashView()
                .ignoresSafeArea()
            
        }
        
    }
}
