//
//  QrImageView.swift
//  SampleApp Watch App
//
//  Created by Mobilions iOS on 09/09/24.
//

import SwiftUI

struct QrImageView: View {
    
    var screenSize: CGSize = .zero
    var qrImage: UIImage?
                         
    var body: some View {
        VStack(spacing: 10) {
            Image("hovercode 1")
                .resizable()
                .scaledToFit()
                .overlay {
                    if let qrImage = qrImage {
                        Image(uiImage: qrImage)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .frame(width: abs(screenSize.width / 1.4), height: abs(screenSize.width / 1.4))
                    }
                }
                .frame(maxWidth: abs(screenSize.width / 1.1), maxHeight: abs(screenSize.width / 1.1))
        }
    }
}
