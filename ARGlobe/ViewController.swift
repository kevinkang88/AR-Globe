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
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let earthNode = createPlanet(radius: 0.1, position:  SCNVector3(1.2,0,0), diffuseContent: #imageLiteral(resourceName: "EarthD"), specularContent: nil, emissionContent: #imageLiteral(resourceName: "EarthClouds"))
        let sunNode = createPlanet(radius: 0.3, position: SCNVector3(0,0,-1), diffuseContent: #imageLiteral(resourceName: "Sun"), specularContent: nil, emissionContent: nil)
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(350.degreesToRadians), z: 0, duration: 8)
        let foreverRotateY = SCNAction.repeatForever(action)
        sunNode.runAction(foreverRotateY)
        
        let venus = createPlanet(radius: 0.1, position: SCNVector3(0.6,0,0), diffuseContent: #imageLiteral(resourceName: "VenusD"), specularContent: nil, emissionContent: #imageLiteral(resourceName: "VenusE"))
        sunNode.addChildNode(venus)
        sunNode.addChildNode(earthNode)
        sceneView.scene.rootNode.addChildNode(sunNode)
    }
    
    func createPlanet(radius: CGFloat, position: SCNVector3,
                diffuseContent: UIImage, specularContent: UIImage?, emissionContent: UIImage?) -> SCNNode {
        let planet = SCNNode(geometry: SCNSphere(radius: radius))
        planet.position = position
        planet.geometry?.firstMaterial?.diffuse.contents = diffuseContent
        planet.geometry?.firstMaterial?.specular.contents = specularContent
        planet.geometry?.firstMaterial?.emission.contents = emissionContent
        
        return planet
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
}
