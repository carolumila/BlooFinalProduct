//
//  BasicInfo.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

struct BasicInfo: View {
    
    @Binding var rootIsActive : Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var varStore: VarStore
    
    @State var numHives = "0"
    @State var orchardAge = 0
    
    @State var showingAlert = false
    @State var SEBBvisitationrate = "0" // expected range 0-6
    
    var ages = ["Young (2-4 yr)", "Prime (5-9 yr)"]
    
    @State var totalAcres = "0"
    
    var body: some View {
            VStack {
                
                Image("Bloo_Logo3")
                    .resizable()
                    .frame(width: 100, height: 82, alignment: .center)
                    .padding(.top, 25)
                Spacer()
                Text("First, we'll need some basic information about your farm to get started.")
                    .font(Font.custom("Helvetica Neue Bold", size: 20))
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                
                ScrollView {
                
                // MARK: form
                    VStack {
                        HStack {
                            Text("Enter the number of honey bee hives per acre on your farm.")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                                .lineLimit(100)
                            TextField("0", text: $numHives, onCommit: {self.updateVars()})
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("What is the age of your orchard?")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            Spacer()
                            Picker("Select the age of your orchard", selection: $orchardAge) {
                                
                                ForEach(ages, id: \.self) { age in
                                    if age == "Young (2-4 yr)" {
                                        Text(age).tag(1)
                                    } else if age == "Prime (5-9 yr)" {
                                        Text(age).tag(0)
                                    }
                                }
                            }
                            .onChange(of: orchardAge) { tag in
                                self.updateVars()
                            }
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("Southeastern blueberry bee visitation rate")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            Button() {
                                showingAlert =  true
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Instructions").font(Font.custom("Helvetica Neue Bold", size: 25)), message: Text("1. Select 3 bushes\n2. For 5 minutes count all Southeastern blueberry bees\n3. Repeat for 2 rows per variety\n").font(Font.custom("Helvetica Neue Regular", size: 15)), dismissButton: .default(Text("Got it!").font(Font.custom("Helvetica Neue Regular", size: 15))))
                            }
                            TextField("0-6", text: $SEBBvisitationrate, onCommit: {self.updateVars()})
                                .keyboardType(.decimalPad)
                                .frame(alignment: .trailing)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        
                        Divider()
                        
                        HStack {
                            Text("What is the total acreage on your farm?")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .frame(width: 150, alignment: .leading)
                            TextField("0", text: $totalAcres, onCommit: {self.updateVars()})
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                                .textFieldStyle(.roundedBorder)
                            Text("acres")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                        }
                        .padding()
                                
                        
                    } // form
                    .background()
                    .cornerRadius(10)
                    .padding()
                }// scrollview
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
                        NavigationLink (destination: Costs(rootIsActive: self.$rootIsActive).environmentObject(self.varStore)) {
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
                numHives = String(self.varStore.numOfHives)
                orchardAge = Int(self.varStore.AGE)
                SEBBvisitationrate = String(self.varStore.SEBB)
                totalAcres = String(self.varStore.totalAcres)
            }
    }
    
    func updateVars() {
        // store vars
        self.varStore.numOfHives = Double(numHives)!
        self.varStore.AGE = Double(orchardAge)
        self.varStore.SEBB = Double(SEBBvisitationrate)!
        self.varStore.totalAcres = Double(totalAcres)!
        
        print("numOfHives: \(self.varStore.numOfHives)")
        print("AGE: \(self.varStore.AGE)")
        print("SEBBvisitationrate: \(self.varStore.SEBB)")
        print("totalAcres: \(self.varStore.totalAcres)\n")
    }
}
