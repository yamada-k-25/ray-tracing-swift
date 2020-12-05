//
//  SCNVector+.swift
//  ray-tracing-swift
//
//  Created by Yamada.K on 2020/12/06.
//

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
