//
//  HomeView.swift
//  ExpenseEase
//
//  Created by Kanishk Vijaywargiya on 16/04/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image("banner02")
                .ignoresSafeArea()
            
            Spacer()
            
            Text("Home")
                .font(.largeTitle.bold())
                .textForground()
            
            Spacer()
        }
        .darkBackground()
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
