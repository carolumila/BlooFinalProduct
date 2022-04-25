//
//  Returns.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

struct Returns: View {
    
    @Binding var shouldPopToRootView : Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var varStore: VarStore
    
    @State var pricePerLb = ""
    @State var yield: Double = 0.0
    @State var totalAcres: Double = 0.0
    @State var totalProductionCosts: Double = 0.0
    
    @State var grossReturns = 0.0
    @State var netProfitPerAcre = 0.0
    @State var bfNetProfit = 0.0
    
    @State var isDisabled = true
    
    var body: some View {
        
        VStack {
            Text("And you're all done!")
                .font(Font.custom("Rockwell Bold", size: 25))
                .font(.title)
                .padding(.bottom, 5)
                .padding(.top, 20)
            Text("Input the price per lb for your berries and press return on the keyboard to view your estimated returns and profits.")
                .font(Font.custom("Helvetica Neue Regular", size: 15))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.horizontal)
            Spacer()
            ScrollView {
                // MARK: form
                VStack {
                    VStack {
                        Text("Gross Returns per Acre")
                            .font(Font.custom("Helvetica Neue Bold", size: 20))
                            .underline()
                            .padding([.leading,.trailing,.top])
                        HStack {
                            Text("Price per lb")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("$")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding(.trailing, 0)
                            TextField("0", text: $pricePerLb, onCommit: {
                                self.calculate()
                                self.varStore.pricePerLb = Double(pricePerLb)!
                            })
                                .frame(alignment: .leading)
                                .keyboardType(.numbersAndPunctuation)
                                .disabled(isDisabled)
                        }
                        
                        HStack {
                            Text("Estimated Yield (lb)")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("\(yield, specifier: "%.0f")")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding()
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .background(Color("DarkPurp"))
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Gross Returns")
                                .font(Font.custom("Helvetica Neue Bold", size: 18))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("\(grossReturns, specifier: "$%.2f")")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding()
                        }
                    }
                    .background(Color("LightPurp"))
                    .cornerRadius(5)
                    .padding([.horizontal,.top])
                    
                    VStack {
                        Text("Profit")
                            .font(Font.custom("Helvetica Neue Bold", size: 20))
                            .underline()
                            .padding([.leading,.trailing,.top])
                        HStack {
                            Text("Net Profit per Acre")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("\(netProfitPerAcre, specifier: "$%.2f")")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding()
                        }
                    
                        HStack {
                            Text("Total blueberry acreage")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("\(totalAcres, specifier: "%.0f acres")")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding()
                        }
                    
                        Divider()
                            .frame(height: 1)
                            .background(Color("DarkPurp"))
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Blueberry farm net profit")
                                .font(Font.custom("Helvetica Neue Bold", size: 18))
                                .frame(minWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("\(bfNetProfit, specifier: "$%.2f")")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .padding()
                        }
                    }
                    .background(Color("LightPurp"))
                    .cornerRadius(5)
                    .padding([.horizontal,.bottom])
                    
                } // form
                .background()
                .cornerRadius(10)
                .padding()
            }// scrollview
            .onAppear() {
                let seconds = 3.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    // Put your code which should be executed with a delay here
                    print(self.varStore.yield)
                    print(self.varStore.totalAcres)
                    self.yield = self.varStore.yield
                    self.totalProductionCosts = self.varStore.totalProductionCosts
                    self.totalAcres = self.varStore.totalAcres
                    
                    self.calculate()
                    
                    isDisabled = false
                }
                
                
            }
            
        // MARK: buttons
            Text("Thanks for using Bloo!")
                .font(Font.custom("Helvetica Neue Bold", size: 15))
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
                    Button (action: {self.shouldPopToRootView = false}) {
                         ZStack {
                             RoundedRectangle(cornerRadius: 5)
                                 .frame(width: 120, height: 25)
                                 .foregroundColor(Color("DarkPurp"))
                             Text("Start Over")
                                 .font(Font.custom("Helvetica Neue Bold", size: 15))
                                 .fontWeight(.bold)
                                 .font(.headline)
                                 .foregroundColor(.white)
                         }
                     }
                    .padding([.leading,.trailing,.top])
                }
                .padding(.bottom, 25)
            }
        } // Vstack
        .background(Color("LightPurp"))
        .foregroundColor(Color("DarkPurp"))
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear() {
            pricePerLb = String(self.varStore.pricePerLb)
        }
    }
    
    func calculate() {
        grossReturns = Double(pricePerLb)! * yield
        netProfitPerAcre = grossReturns - totalProductionCosts
        bfNetProfit = netProfitPerAcre * totalAcres
        
        
        print("grossReturns: \(grossReturns)")
        print("netProfitPerAcre: \(netProfitPerAcre)")
        print("bfNetProfit: \(bfNetProfit)\n")
    }
}
