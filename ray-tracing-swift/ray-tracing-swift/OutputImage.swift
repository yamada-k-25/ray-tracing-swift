//
//  OutputImage.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/05.
//  https://raytracing.github.io/books/RayTracingInOneWeekend.html#outputanimage/theppmimageformat

import Foundation
import SwiftUI
import SceneKit

extension SCNVector3 {
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    static func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(left.x - right.x, left.y - right.y, left.z - right.z)
    }
    
    static func / (left: SCNVector3, right: Double) -> SCNVector3 {
        return SCNVector3(Double(left.x)/right, Double(left.y)/right, Double(left.z)/right)
    }
    
    static func * (left: SCNVector3, right: Double) -> SCNVector3 {
        return SCNVector3(Double(left.x)*right, Double(left.y)*right, Double(left.z)*right)
    }
    
    static func * (left: Double, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(Double(right.x)*left, Double(right.y)*left, Double(right.z)*left)
    }
    
    static func dot(_ left: SCNVector3, _ right: SCNVector3) -> Double {
        return Double(left.x * right.x + left.y * right.y + left.z * right.z)
    }
}

class Sphere {
    static func hitSphere(center: SCNVector3, radius: Double, ray: Ray) -> Bool {
        let originCenter: SCNVector3 = ray.origin + center
        let a = SCNVector3.dot(ray.direction, ray.direction)
        let b = 2.0 * SCNVector3.dot(originCenter, ray.direction)
        let c = SCNVector3.dot(originCenter, originCenter) - radius * radius
        let discriminant = b*b - 4*a*c
        return discriminant > 0
    }
}

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
        OutputImage.outputImage(imageString: imageString, fileName: "output.ppm")
    }
    
    static func writeColor(fileName: String, color: SCNVector3) {
        let imageRed = Int(255.999 * color.x)
        let imageGreen = Int(255.999 * color.y)
        let imageBlue = Int(255.999 * color.z)
    }
    
    static func skyImage() {
        // Image
        let aspect_ratio = 16.0 / 9.0
        let imageWidth: Int = 400
        let imageHeight: Int = Int(Double(imageWidth)/aspect_ratio)
        
        // Camera
        let viewPortHeight = 2.0
        let viewPortWidth = aspect_ratio * viewPortHeight
        let focalLength = 1.0
        
        let origin = SCNVector3(0, 0, 0)
        let horizontal = SCNVector3(viewPortWidth, 0, 0)
        let vertical = SCNVector3(0, viewPortHeight, 0)
        let lowerLeftCorner = origin - horizontal/2 - vertical/2 - SCNVector3(0, 0, focalLength)
        
        // Render
        var imageString: String = ""
        imageString = "P3\n\(imageWidth) \(imageHeight)\n255\n"
        for h in (0..<imageHeight).reversed() {
            for w in 0..<imageWidth {
                let u = Double(w)/Double(imageWidth-1)
                let v = Double(h)/Double(imageHeight-1)
                
                let ray = Ray(origin: origin, direction: lowerLeftCorner + u*horizontal + v*vertical - origin)
                let color = Ray.rayColor(ray: ray)
                let imageRed = Int(255.999 * color.x)
                let imageGreen = Int(255.999 * color.y)
                let imageBlue = Int(255.999 * color.z)
                imageString.append("\(imageRed) \(imageGreen) \(imageBlue)\n")
            }
        }
        outputImage(imageString: imageString, fileName: "skye-ouput.ppm")
    }
    
    static func outputImage(imageString: String, fileName: String) {
        let contentData = imageString.data(using: .utf8)!
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //appendingPathComponentでURL型の最後に文字列を連結できる
        let path_file_name = documentPath.appendingPathComponent(fileName)
        print(path_file_name)
        do {
            try contentData.write(to: path_file_name)
            print("成功")
        } catch {
            print("失敗")
        }
    }
}

struct OutputImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Image("ouput.ppm", bundle: nil)
                .frame(width: 300, height: 300, alignment: .center)
        }
    }
}
