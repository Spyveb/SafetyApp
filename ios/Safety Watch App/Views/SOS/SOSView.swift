//
//  SOSView.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 05/09/24.
//

import SwiftUI
import WatchConnectivity
import EFQRCode

struct SOSView: View {
    
    // MARK: - Variables
    @Environment(\.customValue) var customValue
    @ObservedObject var viewModel = WatchConnector()
    @ObservedObject var locationManager = LocationManager()
    @State var showAlert = false
    @State var userName = ""
    @State var screenSize = CGSize()
    @State var defaultAlert: AlertType = .UserInfo(action: {})
    @State var isUndoTapped = false
    @State var isSosSuccessful = false
    @State var isDisplayLoader = false
    @State var isTokenValid = false
    @State var qrImage: UIImage?
    @State var qrString: String = ""
    @State private var navigateToEnableLocationView = false
    
    // MARK: - View Starts
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                Color.white.ignoresSafeArea()
                
                // Get screen size using geometry reader
                GeometryReader { size in
                    HStack() {}
                        .frame(width: 0, height: 0)
                        .onAppear {
                            debugPrint("Remove :: False")
                            screenSize = size.size
                            debugPrint("top :: \(size.safeAreaInsets)")
                        }
                }
                
                if viewModel.displayRemoveAlert {
                    HStack() {}
                        .frame(width: 0, height: 0)
                        .onAppear {
                            viewModel.displayRemoveAlert = false
                            defaultAlert = .RemoveDevice(action: {})
                            showAlert = true
                            isDisplayLoader = false
                            debugPrint("Remove :: True")
                        }
                } else {
                    HStack() {}
                        .frame(width: 0, height: 0)
                        .onAppear {
                            debugPrint("Remove :: false")
                        }
                }
                
                // Navigation Link
                NavigationLink("", destination: LocationPermissionView(), isActive: $navigateToEnableLocationView)
                    .background(.red)
                    .frame(width: 0, height: 0)
                
                // Check token is empty or not
                if viewModel.userData?.userToken != nil  {
                    
                    VStack {
                        if isTokenValid {
                            ZStack(alignment: .center) {
                                /// SOS Button
                                Button(action: {
                                    locationManager.requestLocationAuthorization { status in
                                        switch status {
                                        case .notDetermined:
                                            debugPrint("Location status: \(status)")
                                            defaultAlert = .Location(action: {
                                                navigateToEnableLocationView = true
                                            })
                                            showAlert = true
                                        case .restricted, .denied:
                                            debugPrint("Location status: \(status)")
                                            defaultAlert = .Location(action: {
                                                navigateToEnableLocationView = true
                                            })
                                            showAlert = true
                                        case .authorizedAlways, .authorizedWhenInUse:
                                            locationManager.startLocationUpdates()
                                            defaultAlert = .UndoSOS(action: {isUndoTapped = true})
                                            showAlert = true
                                            sosAction()
                                        @unknown default:
                                            debugPrint("Unknown location status: \(status)")
                                        }
                                    }
                                }) {
                                    Text("SOS")
                                        .frame(width: abs(screenSize.width / 1.2), height: abs(screenSize.width / 1.2))
                                        .foregroundColor(Color.white)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .font(.system(size: 40))
                                }
                                .frame(width: abs(screenSize.width / 1.2), height: abs(screenSize.width / 1.2))
                                .background(Color.yellow)
                                .cornerRadius(abs(screenSize.width / 2.4))
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            // MARK: - Fetching Data View
                            ZStack(alignment: .center) {
                                VStack() {
                                    ProgressView()
                                        .tint(.black)
                                        .progressViewStyle(.circular)
                                        .overlay {
                                            VStack {
                                                Text("Fetching Data...")
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(nil)
                                                    .font(.system(size: 15))
                                                    .foregroundStyle(.black)
                                                Spacer()
                                                    .frame(height: 50)
                                            }
                                        }
                                }
                            }
                            .onAppear(perform: {
                                // MARK: - Token Check API Call
                                validToken()
                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .onAppear {
                        locationManager.requestLocationAuthorization { status in
                            if status == .authorizedWhenInUse || status == .authorizedAlways {
                                locationManager.startLocationUpdates()
                                debugPrint(locationManager.location as Any)
                            } else {
                                defaultAlert = .Location(action: {
                                    locationManager.requestLocationAuthorization { status in
                                        if status == .authorizedWhenInUse || status == .authorizedAlways {
                                            validToken()
                                        } else {
                                            navigateToEnableLocationView = true
                                        }
                                    }
                                })
                                showAlert = true
                                debugPrint("Location access not granted.")
                            }
                        }
                    }
                } else {
                    
                    // MARK: - QR image view
                    if isDisplayLoader {
                        ZStack(alignment: .center) {
                            QrImageView(screenSize: screenSize, qrImage: qrImage)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        
                        // MARK: - Btn My QR view
                        ZStack(alignment: .center) {
                            VStack(spacing: 20) {
                                Text("Tap 'MY QR' to display the code, open your Distress app, scan the QR code, and pair with your phone.")
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                                
                                
                                Button(action: {
                                    isDisplayLoader = true
                                }) {
                                    Text("My QR")
                                        .foregroundColor(Color.white)
                                        .background(Color.red)
                                        .font(.system(size: 15))
                                }
                                .frame(width: 90, height: 35)
                                .background(Color.red)
                                .cornerRadius(8)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .padding(0)
            
            // MARK: - On Appear
            .onAppear {
                
                qrString = generateRandomString()
                
                debugPrint("Qr String :: \(qrString)")
                debugPrint("Viewmodel String :: \(viewModel.validateQrString)")
                
                if let getqrImage = generateQRCode(from: qrString) {
                    qrImage = getqrImage
                }
                
                if fetchUserInfo() != nil {
                    if let fetchData = fetchUserInfo() {
                        viewModel.userData = fetchData
                        userName = viewModel.userData?.userName ?? ""
                    }
                }
            }
            
            // MARK: - Display Alert
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(defaultAlert.title),
                    message: Text(defaultAlert.message),
                    dismissButton: .default(Text(defaultAlert.actionName), action: {
                        DispatchQueue.main.async {
                            defaultAlert.performAction()
                            if isSosSuccessful {
                                showAlert = false
                            }
                        }
                    })
                )
            }
        }
        .padding(0)
    }
}

#Preview {
    SOSView()
}
