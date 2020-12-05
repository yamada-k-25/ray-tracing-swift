//
//  OutputImage.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/05.
//  https://raytracing.github.io/books/RayTracingInOneWeekend.html#outputanimage/theppmimageformat

import Foundation
import SwiftUI
import SceneKit

class OutputImage {
    static func renderTest() {
        let imageWidth: Int = 256
        let imageHeight: Int = 256
        
        var imageString: String = ""
        imageString = "P3\n\(imageWidth) \(imageHeight)\n255\n"
        for w in 0..<imageHeight {
            for h in 0..<imageWidth {
                let red = Double(w)/Double(imageWidth-1)
                let green = Double(h)/Double(imageHeight-1)
                let blue: Double = 0.25
                
                let imageRed = Int(255.999 * red)
                let imageGreen = Int(255.999 * green)
                let imageBlue = Int(255.999 * blue)
                
                imageString.append("\(imageRed) \(imageGreen) \(imageBlue)\n")
            }
        }
        let contentData = imageString.data(using: .utf8)!
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    //appendingPathComponentでURL型の最後に文字列を連結できる
                    let path_file_name = documentPath.appendingPathComponent("output.ppm")
                    print(path_file_name)
                do {
                    try contentData.write(to: path_file_name)
                    print("成功")
                } catch {
                    print("失敗")
                }
    }
}
