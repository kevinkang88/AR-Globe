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
        let earthNode = SCNNode(geometry: SCNSphere(radius: 0.3))
        earthNode.position = SCNVector3(0,1,1)
        earthNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "EarthD")
        earthNode.geometry?.firstMaterial?.specular.contents = UIImage(named: "EarthSpec")
        earthNode.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "EarthClouds")
        sceneView.scene.rootNode.addChildNode(earthNode)
        
        let sunNode = SCNNode(geometry: SCNSphere(radius: 0.4))
        sunNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        sunNode.position = SCNVector3(0,0.3,0.3)
        
        let earthAction = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        let earthActionLoop = SCNAction.repeatForever(earthAction)
        earthNode.runAction(earthActionLoop)
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    
}
