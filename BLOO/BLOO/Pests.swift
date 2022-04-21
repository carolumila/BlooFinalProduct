//
//  Pests.swift
//  BLOO
//
//  Created by Caroline Umila on 4/18/22.
//

import SwiftUI

struct Pests: View {
    
    @Binding var rootIsActive : Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    
    @EnvironmentObject var varStore: VarStore
    
    enum pestLevelOptions: String, CaseIterable, Identifiable {
            case zero
            case low
            case medium
            case high

           var id: String { self.rawValue }
    }
    
    /// user input
    @State var selectedPest = "None"
    @State var pestLevel: pestLevelOptions = .zero
    
    var body: some View {
            VStack {
                Image("Bloo_Logo3")
                    .resizable()
                    .frame(width: 100, height: 82, alignment: .center)
                    .padding(.top, 25)
                Text("Next, we'll need some information regarding the kinds of pests and pest levels on your farm.")
                    .font(Font.custom("Helvetica Neue Bold", size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                Spacer()
                
                // MARK: form
                ScrollView {
                    VStack {
                        Text("What kind of pests do you have on your farm?")
                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                            .padding(5)
                            .padding(.top, 10)
                        Picker(selection: $selectedPest, label: Text("Select a pest:").font(Font.custom("Helvetica Neue Regular", size: 15))) {
                            Text("Thrips")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .tag("thrips")
                            Text("Gall Midge")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .tag("Gall Midge")
                            Text("None")
                                .font(Font.custom("Helvetica Neue Regular", size: 15))
                                .tag("None")
                        }
                        .pickerStyle(.segmented)
                        .padding()
                        .onChange(of: selectedPest) { tag in
                            self.updateVars()
                        }
                        
                        if selectedPest == "thrips" {
                            Divider()
                            HStack {
                                Text("Select your Thrip Level")
                                    .font(Font.custom("Helvetica Neue Regular", size: 15))
                                    .frame(minWidth: 150, alignment: .leading)
                                Button() {
                                    showingAlert =  true
                                } label: {
                                    Image(systemName: "questionmark.circle")
                                        .padding(0)
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Instructions").font(Font.custom("Helvetica Neue Bold", size: 25)), message: Text("Count thrips per cluster of 8 flowers\n\nZero: no thrips\nLow: 2 thrips/8 flowers\nMed: 3-6 thrips/8 flowers\nHigh: >6 thrips/8 flowers").font(Font.custom("Helvetica Neue Regular", size: 15)), dismissButton: .default(Text("Got it!").font(Font.custom("Helvetica Neue Regular", size: 15))))
                                }
                                Spacer()
                                Picker("Select your orchard's thrip level", selection: $pestLevel) {
                                    ForEach(pestLevelOptions.allCases) { level in
                                        Text(level.rawValue.capitalized).tag(level)
                                    }
                                }
                                .onChange(of: pestLevel) { tag in
                                    self.updateVars()
                                }
                            }
                            .padding()
                        } else if selectedPest == "Gall Midge" {
                            Divider()
                            HStack {
                                Text("Select your Gall Midge Level")
                                    .font(Font.custom("Helvetica Neue Regular", size: 15))
                                    .frame(minWidth: 150, alignment: .leading)
                                Button() {
                                    showingAlert =  true
                                } label: {
                                    Image(systemName: "questionmark.circle")
                                        .padding(0)
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Instructions").font(Font.custom("Helvetica Neue Bold", size: 25)), message: Text("Count larvae per 50 buds\n\nZero: no larvae\nLow: 1-3 larvare/50 buds\nMed: 4-8 larvae/50 buds\nHigh: >8 larvae/50 buds").font(Font.custom("Helvetica Neue Regular", size: 15)), dismissButton: .default(Text("Got it!")
                                        .font(Font.custom("Helvetica Neue Regular", size: 15))))
                                }
                                Spacer()
                                Picker("Select your orchard's gall midge level", selection: $pestLevel) {
                                    ForEach(pestLevelOptions.allCases) { level in
                                        Text(level.rawValue.capitalized)
                                            .font(Font.custom("Helvetica Neue Regular", size: 15))
                                            .tag(level)
                                    }
                                }
                                .onChange(of: pestLevel) { tag in
                                    self.updateVars()
                                }
                            }
                            .padding()
                            
                        }
                        
                    } // form
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
                        NavigationLink (destination: Pesticides(rootIsActive: self.$rootIsActive).environmentObject(self.varStore)) {
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
                if self.varStore.PEST == 0 {
                    selectedPest = "none"
                    pestLevel = .zero
                } else {
                    if self.varStore.TLOW == 1 {
                        selectedPest = "thrips"
                        pestLevel = .low
                    } else if self.varStore.TMED == 1 {
                        selectedPest = "thrips"
                        pestLevel = .medium
                    } else if self.varStore.THIGH == 1 {
                        selectedPest = "thrips"
                        pestLevel = .high
                    } else if self.varStore.GLOW == 1 {
                        selectedPest = "Gall Midge"
                        pestLevel = .low
                    } else if self.varStore.GMED == 1 {
                        selectedPest = "Gall Midge"
                        pestLevel = .medium
                    } else if self.varStore.GHIGH == 1 {
                        selectedPest = "Gall Midge"
                        pestLevel = .high
                    }
                }
                
            }
    }
    
    func updateVars() {
        
        if selectedPest == "thrips" { // if thrips
            switch pestLevel {
            case .zero:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 0
            case .low:
                self.varStore.TLOW = 1
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 1
            case .medium:
                self.varStore.TLOW = 0
                self.varStore.TMED = 1
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 1
            case .high:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 1
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 1
            }
        } else if selectedPest == "Gall Midge" { // if Gall Midge
            switch pestLevel {
            case .zero:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 0
            case .low:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 1
                self.varStore.GMED = 0
                self.varStore.GHIGH = 0
                self.varStore.PEST = 1
            case .medium:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 1
                self.varStore.GHIGH = 0
                self.varStore.PEST = 1
            case .high:
                self.varStore.TLOW = 0
                self.varStore.TMED = 0
                self.varStore.THIGH = 0
                self.varStore.GLOW = 0
                self.varStore.GMED = 0
                self.varStore.GHIGH = 1
                self.varStore.PEST = 1
            }
        } else {
            self.varStore.TLOW = 0
            self.varStore.TMED = 0
            self.varStore.THIGH = 0
            self.varStore.GLOW = 0
            self.varStore.GMED = 0
            self.varStore.GHIGH = 0
            self.varStore.PEST = 0
        } // if
        
        print("TLOW: \(self.varStore.TLOW)")
        print("TMED: \(self.varStore.TMED)")
        print("THIGH: \(self.varStore.THIGH)")
        print("GLOW: \(self.varStore.GLOW)")
        print("GMED: \(self.varStore.GMED)")
        print("GHIGH: \(self.varStore.GHIGH)\n")
    }
}
