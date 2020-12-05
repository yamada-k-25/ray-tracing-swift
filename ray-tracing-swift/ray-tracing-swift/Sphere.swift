//
//  Sphere.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/06.
//

import SceneKit

class Sphere {
    static func hitSphere(center: SCNVector3, radius: Double, ray: Ray) -> Bool {
        let originCenter: SCNVector3 = ray.origin + center
        let a = SCNVector3.dot(ray.direction, ray.direction)
        let b = 2.0 * SCNVector3.dot(originCenter, ray.direction)
        let c = SCNVector3.dot(originCenter, originCenter) - radius * radius
        let discriminant = b*b - 4*a*c
        return discriminant > 0
    }
    
    static func color(ray: Ray) -> SCNVector3 {
        if hitSphere(center: SCNVector3(0, 0, -1), radius: 0.5, ray: ray) {
            return SCNVector3(1, 0, 0)
        }
        let unitDirection = Ray.unit(ray.direction)
        let t: Double = 0.5*Double(unitDirection.y + 1.0)
        return Double(1.0-t)*SCNVector3(1.0, 1.0, 1.0) + t*SCNVector3(0.5, 0.7, 1.0)
    }
    
    static func testRender() {
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
                let color = Sphere.color(ray: ray)
                let imageRed = Int(255.999 * color.x)
                let imageGreen = Int(255.999 * color.y)
                let imageBlue = Int(255.999 * color.z)
                imageString.append("\(imageRed) \(imageGreen) \(imageBlue)\n")
            }
        }
        OutputImage.outputImage(imageString: imageString, fileName: "sphere.ppm")
    }
}
