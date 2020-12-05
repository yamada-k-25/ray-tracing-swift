//
//  ContentView.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                OutputImage.renderTest()
                OutputImage.skyImage()
                Sphere.testRender()
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
