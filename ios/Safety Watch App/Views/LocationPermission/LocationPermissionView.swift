//
//  LocationPermissionView.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 06/09/24.
//

import SwiftUI

struct LocationPermissionView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var viewModel = WatchConnector()
    
    var body: some View {
        NavigationView {
            ScrollView {
//                if viewModel.displayRemoveAlert {
//                    HStack() {}
//                        .onAppear(perform: {
//                            presentationMode.wrappedValue.dismiss()
//                        })
//                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        Text("To enable location access, follow these steps on your iPhone:")
                            .font(.headline)
                            .padding(.top)
                            .foregroundColor(.black)
                        
                        Text("1. Open Settings on your iPhone.")
                            .foregroundColor(.black)
                        Text("2. Tap Privacy > Location Services.")
                            .foregroundColor(.black)
                        Text("3. Ensure Location Services is on.")
                            .foregroundColor(.black)
                        Text("4. Make sure 'Location Services' is turned on.")
                            .foregroundColor(.black)
                        Text("5. Find your app")
                            .foregroundColor(.black)
                        Text("6. Set it to 'While Using the App' or 'Always'.")
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding()
                    .background(.white)
//                }
                
            }
            .background(.white)
        }
    }
}

#Preview {
    LocationPermissionView()
}
