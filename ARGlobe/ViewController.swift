//
//  ViewController.swift
//  ARGlobe
//
//  Created by kevin on 1/27/18.
//  Copyright © 2018 yooniverse. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.session.run(config)
        sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let sunNode = createPlanet(radius: 0.3, position: SCNVector3(0,0,-1), diffuseContent: #imageLiteral(resourceName: "Sun"), specularContent: nil, emissionContent: nil)
        rotate360Y(node: sunNode, duration: 20)
        
        let earthParentNode = createPlanet(radius: 0, position: SCNVector3(0,0,-1), diffuseContent: nil, specularContent: nil, emissionContent: nil)
        rotate360Y(node: earthParentNode, duration: 9)
        
        let venusParentNode = createPlanet(radius: 0, position: SCNVector3(0,0,-1), diffuseContent: nil, specularContent: nil, emissionContent: nil)
        rotate360Y(node: venusParentNode, duration: 12)

        let earthNode = createPlanet(radius: 0.1, position:  SCNVector3(1.2,0,0), diffuseContent: #imageLiteral(resourceName: "EarthD"), specularContent: nil, emissionContent: #imageLiteral(resourceName: "EarthClouds"))
        let venus = createPlanet(radius: 0.1, position: SCNVector3(0.6,0,0), diffuseContent: #imageLiteral(resourceName: "VenusD"), specularContent: nil, emissionContent: #imageLiteral(resourceName: "VenusE"))
        
        let earthsMoonParent = createPlanet(radius: 0, position: SCNVector3(1.2,0,0), diffuseContent: nil, specularContent: nil, emissionContent: nil)
        rotate360Y(node: earthsMoonParent, duration: 1)
        
        let earthsMoon = createPlanet(radius: 0.02, position: SCNVector3(0.2,0,0), diffuseContent: #imageLiteral(resourceName: "Moon"), specularContent: nil, emissionContent: nil)
        
        earthsMoonParent.addChildNode(earthsMoon)
        
        venusParentNode.addChildNode(venus)
        earthParentNode.addChildNode(earthNode)
        earthParentNode.addChildNode(earthsMoonParent)
        sceneView.scene.rootNode.addChildNode(earthParentNode)
        sceneView.scene.rootNode.addChildNode(venusParentNode)
        sceneView.scene.rootNode.addChildNode(sunNode)
    }
    
    func createPlanet(radius: CGFloat, position: SCNVector3,
                diffuseContent: UIImage?, specularContent: UIImage?, emissionContent: UIImage?) -> SCNNode {
        let planet = SCNNode(geometry: SCNSphere(radius: radius))
        planet.position = position
        planet.geometry?.firstMaterial?.diffuse.contents = diffuseContent
        planet.geometry?.firstMaterial?.specular.contents = specularContent
        planet.geometry?.firstMaterial?.emission.contents = emissionContent
        
        return planet
    }
    
    func rotate360Y(node: SCNNode, duration: TimeInterval) -> Void {
        let nodeAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: duration)
        let nodeActionForever = SCNAction.repeatForever(nodeAction)
        node.runAction(nodeActionForever)
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
