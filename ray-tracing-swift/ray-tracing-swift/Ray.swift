//
//  Ray.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/05.
//

import Foundation
import SceneKit

class Ray {
    let origin: SCNVector3
    let direction: SCNVector3
    
    init(origin: SCNVector3, direction: SCNVector3) {
        self.origin = origin
        self.direction = direction
    }
    
    public func at(t: CGFloat) -> SCNVector3 {
        return SCNVector3(
            Float(origin.x + direction.x*t),
            Float(origin.y + direction.y*t),
            Float(origin.z + direction.z*t)
        )
    }
    
    static func unit(_ vector: SCNVector3) -> SCNVector3 {
        let norm = 3
        return vector/Double(norm)
    }
    
    static func rayColor(ray: Ray) -> SCNVector3 {
        let unitDirection: SCNVector3 = Ray.unit(ray.direction)
        let t: Double = Double(0.5*(unitDirection.y + 1.0))
        return SCNVector3(1.0-t + 0.5*t, 1.0-t + 0.7*t, 1.0-t + 1.0*t)
    }
}
