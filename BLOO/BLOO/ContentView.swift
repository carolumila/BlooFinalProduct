//
//  ContentView.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

struct ContentView: View {
    
    init () {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }

    @State var isActive : Bool = false
    @EnvironmentObject var varStore: VarStore
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("Bloo_Logo3")
                    .resizable()
                    .frame(width: 200, height: 164, alignment: .center)
                Text("Welcome to Bloo! This a tool to help you manage your blueberry farm's production. You input information about your farm and this app estimates your returns and profits while also taking into consideration the effects of pollinators present and pesticides used. Press the start button to begin.")
                    .font(Font.custom("Helvetica Neue Regular", size: 25))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.body)
                    .padding()
                
                Spacer()
                
                NavigationLink(destination: BasicInfo(rootIsActive: self.$isActive).environmentObject(self.varStore), isActive: self.$isActive) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 25)
                            .foregroundColor(Color("DarkPurp"))
                        Text("Start")
                            .fontWeight(.bold)
                            .font(.headline)
                        .foregroundColor(.white)
                    }
                }
                .isDetailLink(false)
                .padding()
                
                Spacer()
                
            }
            .background(Color("LightPurp"))
            .foregroundColor(Color("DarkPurp"))
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .onAppear() {
                self.varStore.numOfHives = 3.0
                self.varStore.AGE = 0
                self.varStore.SEBB = 0
                
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
             
                self.varStore.PEST = 0
                self.varStore.totalAcres = 0.0
                
                self.varStore.budgetFixedCosts = 100.00
                self.varStore.budgetVariableCosts = 100.00
                
                self.varStore.costPerHive = 0.00
                self.varStore.fertilizerCost = 0.00
                self.varStore.irrigationCost = 0.00
                self.varStore.insecticideCost = 0.00
                
                self.varStore.totalProductionCosts = 0.00
                self.varStore.yield = 0.0
                self.varStore.pricePerLb = 0.00
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(VarStore())
    }
}
