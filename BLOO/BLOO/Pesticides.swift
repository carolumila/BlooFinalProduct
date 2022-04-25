//
//  Pesticides.swift
//  BLOO
//
//  Created by Caroline Umila on 4/19/22.
//

import SwiftUI

struct Pesticides: View {
    
    @Binding var rootIsActive : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var varStore: VarStore
    
    @State var usesPesticides = 0
    
    /// for table - based on https://stackoverflow.com/questions/71132520/how-do-i-create-an-editable-table-in-swiftui
    struct Pesticide: Identifiable {
        let name: String
        let applicationRate: String
        let id = UUID()
    }
    
    var pesticides = [
        Pesticide(name: "Diazinon", applicationRate: "0.50 gallons"),
        Pesticide(name: "Delegate", applicationRate: "3-6 oz"),
        Pesticide(name: "Assail", applicationRate: "4.5-5.3 oz"),
        Pesticide(name: "Sivanto", applicationRate: "12-14 oz"),
        Pesticide(name: "Movento", applicationRate: "10 oz"),
        Pesticide(name: "Entrust (organic)", applicationRate: "4-6 oz")
    ]
    
    @State var costPerAcrePerApp: [String] = [
        "25.00",
        "45.00",
        "35.00",
        "50.00",
        "60.00",
        "60.00"
    ]
    @State var numOfApp: [String] = Array(repeating: "1", count: 6)
    @State var totalCostPerAcre: [Double] = Array(repeating: 0.00 , count: 6)
    
    let columns = Array(repeating: GridItem(.flexible(minimum: 20)), count: 4)
    
    var body: some View {
        VStack {
            Image("Bloo_Logo3")
                .resizable()
                .frame(width: 100, height: 82, alignment: .center)
                .padding(.top, 25)
            Text("Finally, we'll need some information regarding the kinds of pesticides used on your farm.")
                .font(Font.custom("Helvetica Neue Bold", size: 20))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
            Spacer()
            
            // MARK: form
            ScrollView {
                VStack {
                    Text("Do you use pesticides?")
                        .font(Font.custom("Helvetica Neue Regular", size: 15))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(5)
                        .padding(.top, 10)
    
                    Picker(selection: $usesPesticides, label: Text("Do you use Pesticides?")) {
                        Text("Yes")
                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                            .tag(1)
                        Text("No")
                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                            .tag(0)
                    }
                    .pickerStyle(.segmented)
                    .padding()
    
                    if usesPesticides == 1 {
                        Divider()
                        VStack {
                            Group {
                                Text("Please change the")
                                Text("cost per acre per application").underline().fontWeight(.semibold)
                                Text("and the")
                                Text("number of applications").underline().fontWeight(.semibold)
                                Text(" below as appropriate:")
                            }
                            .font(.caption)
                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                            .lineLimit(nil)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(0)
    
                            LazyVGrid(columns: columns) {
                                // first headline row
                                Text("Pesticide").underline()
                                Text("Application rate per acre").underline()
                                Text("Cost per acre per application").underline()
                                Text("No. of applications").underline()
//                                Text("Total cost per acre").underline()
                                // rows
                                ForEach(0..<6) { row in
                                    Text(pesticides[row].name)
                                    Text(pesticides[row].applicationRate)
                                    HStack {
                                        Text("$")
                                        TextField("0", text: $costPerAcrePerApp[row], onCommit: {self.updateTable()})
                                            .frame(alignment: .trailing)
                                            .keyboardType(.decimalPad)
                                    }
                                    .background(Color("LightGreen"))
                                    .cornerRadius(5)

                                    TextField(String(format: "$%.2", numOfApp[row]), text: $numOfApp[row], onCommit: {self.updateTable()})
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.decimalPad)
                                        .background(Color("LightGreen"))
                                        .cornerRadius(5)
                                    
//                                    Text("\(String(format: "$%.2", totalCostPerAcre[row]))")
//                                        .onAppear() {
//                                            print("row: \(totalCostPerAcre[row])")
//                                        }
                                } // ForEach
                            } // LazyVGrid
                            .font(.caption2)
                            .padding()
                        } // VStack
                    } // if
                }// VStack
                .background()
                
                .cornerRadius(10)
                .padding()
                
            } // scrollView
            .frame(maxHeight: 400)
            .cornerRadius(10)
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
                    NavigationLink (destination: Returns(shouldPopToRootView: self.$rootIsActive).environmentObject(self.varStore)) {
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
                        self.updateTable()
                        self.updateVars()
                    }
                }
                .padding(.bottom, 25)
            } // button group
        
        } // VStack
        .background(Color("LightPurp"))
        .foregroundColor(Color("DarkPurp"))
        .navigationBarBackButtonHidden(true)
        .background(ignoresSafeAreaEdges: .all)
        .navigationBarHidden(true)
        .onAppear() {
            self.updateTable()
        }
    } // body
    
    func updateVars() {
        // update total costs
        let hiveRentalCost = self.varStore.costPerHive * self.varStore.numOfHives
        var insecticideCost = 36.75
        for amount in totalCostPerAcre {
            insecticideCost += amount
        }
        
        let totalProductionCosts = hiveRentalCost + self.varStore.fertilizerCost + self.varStore.irrigationCost + self.varStore.budgetFixedCosts + self.varStore.budgetVariableCosts + insecticideCost
        
        self.varStore.totalProductionCosts = totalProductionCosts
        
        print("hiveRentalCost: \(hiveRentalCost)")
        print("insecticideCost: \(insecticideCost)")
        print("fertilizerCost: \(self.varStore.fertilizerCost)")
        print("irrigationCost: \(self.varStore.irrigationCost)")
        print("budgetFixedCosts: \(self.varStore.budgetFixedCosts)")
        print("budgetVariablecosts: \(self.varStore.budgetVariableCosts)")
        
        print("totalProductionCosts: \(self.varStore.totalProductionCosts)")
        
        // check if there are pests
        var PEST = 0.0
        if (self.varStore.PEST == 1.0) && (usesPesticides == 1) {
            PEST = 1.0
        }
        // calculate yield
        var yield = 6952.41
        yield += 62.71 * self.varStore.numOfHives
        yield -= 3534.19 * self.varStore.AGE
        yield += 779.34 * self.varStore.SEBB
        yield -= 472.45 * self.varStore.TLOW
        yield -= 825.8 * self.varStore.TMED
        yield -= 1179.16 * self.varStore.THIGH
        yield -= 801.44 * self.varStore.GLOW
        yield -= 1885.86 * self.varStore.GMED
        yield -= 3335.81 * self.varStore.GHIGH
        yield -= 468.31 * (self.varStore.SEBB * PEST)
        
        self.varStore.yield = yield
        
        print("yield: \(self.varStore.yield)\n")
        
    }
    
    func updateTable() {
        //update table
        var costPerAcre = 0.0
        var numberOfApplications = 0.0
        let indicies = [0,1,2,3,4,5]
        print("costPerAcrePerApp: \(costPerAcrePerApp)")
        print("numOfApp: \(numOfApp)")
        
        for index in indicies {
            costPerAcre = Double(costPerAcrePerApp[index])!
            numberOfApplications =  Double(numOfApp[index])!
            totalCostPerAcre[index] = (costPerAcre * numberOfApplications)
        }
        
        print("totalCostPerAcre: \(totalCostPerAcre)")
    }
}
