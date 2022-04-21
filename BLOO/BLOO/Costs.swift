//
//  Costs.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

struct Costs: View {
    
    @Binding var rootIsActive : Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var varStore: VarStore
    
    @State var hiveCost = "0.00"
    @State var fertilizerCost = "0.00"
    @State var irrigationCost = "0.00"
    
    @State var budgetFixedCosts = 2152.75
    @State var budgetVariableCosts = 15947.68
    
    var body: some View {
            VStack {
                Image("Bloo_Logo3")
                    .resizable()
                    .frame(width: 100, height: 82, alignment: .center)
                    .padding(.top, 25)
                Spacer()
                Text("Next, we'll need some information about the costs of running your farm.")
                    .font(Font.custom("Helvetica Neue Bold", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                
                // MARK: form
                ScrollView {
                    VStack {
                        Text("Production Costs Per Acre")
                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                            .fontWeight(.bold)
                            .padding([.leading,.trailing,.top])
                        HStack {
                            Text("What is the cost per hive?")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            Text("$")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding(.trailing, 0)
                            TextField("0.00", text: $hiveCost, onCommit: {self.updateVars()})
                                .frame(alignment: .trailing)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("What is your fertilizer cost per acre?")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            Text("$")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding(.trailing, 0)
                            TextField("0.00", text: $fertilizerCost, onCommit: {self.updateVars()})
                                .frame(alignment: .trailing)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("What is your irrigation cost per acre?")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            Text("$")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding(.trailing, 0)
                            TextField("0.00", text: $irrigationCost, onCommit: {self.updateVars()})
                                .frame(alignment: .trailing)
                                .keyboardType(.decimalPad)
                        }
                        .padding()
                                
                        
                    } // form
                    .background()
                    .cornerRadius(10)
                    .padding()
                } // scrollview
                
                Spacer()
                
                // MARK: buttons
                Group {
                    HStack {
                        Button (action:{
                            presentationMode.wrappedValue.dismiss()
                        }) {
                             ZStack {
                                 RoundedRectangle(cornerRadius: 5)
                                     .frame(width: 125, height: 25)
                                     .foregroundColor(Color("DarkPurp"))
                                 Text("Previous Page")
                                     .font(Font.custom("Helvetica Neue Bold", size: 15))
                                     .fontWeight(.bold)
                                     .font(.headline)
                                     .foregroundColor(.white)
                             }
                         }
                         .padding([.leading,.trailing,.top])
                        NavigationLink (destination: Pests(rootIsActive: self.$rootIsActive).environmentObject(self.varStore)) {
                             ZStack {
                                 RoundedRectangle(cornerRadius: 5)
                                     .frame(width: 120, height: 25)
                                     .foregroundColor(Color("DarkPurp"))
                                 Text("Next Page")
                                     .font(Font.custom("Helvetica Neue Bold", size: 15))
                                     .fontWeight(.bold)
                                     .font(.headline)
                                     .foregroundColor(.white)
                             }
                         }
                        .isDetailLink(false)
                        .padding([.leading,.trailing,.top])
                        .onDisappear() {
                            self.updateVars()
                        }
                    }
                    .padding(.bottom, 25)
                }

            }
            .background(Color("LightPurp"))
            .foregroundColor(Color("DarkPurp"))
            .navigationBarBackButtonHidden(true)
            .background(ignoresSafeAreaEdges: .all)
            .navigationBarHidden(true)
            .onAppear() {
                self.hiveCost = String(self.varStore.costPerHive)
                self.fertilizerCost = String(self.varStore.fertilizerCost)
                self.irrigationCost = String(self.varStore.irrigationCost)
            }
    }
    
    func updateVars() {
        self.varStore.budgetFixedCosts = budgetFixedCosts
        self.varStore.budgetVariableCosts = budgetVariableCosts
        
        if hiveCost != "" {
            self.varStore.costPerHive = Double(hiveCost)!
        }
        if fertilizerCost != "" {
            self.varStore.fertilizerCost = Double(fertilizerCost)!
        }
        if irrigationCost != "" {
            self.varStore.irrigationCost = Double(irrigationCost)!
        }
        
        print("budgetFixedCosts: \(self.varStore.budgetFixedCosts)")
        print("budgetVariableCosts: \(self.varStore.budgetVariableCosts)")
        print("costPerHive: \(self.varStore.costPerHive)")
        print("fertilizerCost: \(self.varStore.fertilizerCost)")
        print("irrigationCost: \(self.varStore.irrigationCost)\n")
    }
}
