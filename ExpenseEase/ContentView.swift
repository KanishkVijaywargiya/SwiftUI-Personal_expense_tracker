//
//  ContentView.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 15/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authManager = AuthenticationManager()
    
    var body: some View {
        SliderScreen().environmentObject(authManager)
//        InstaQRCodeUI()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
