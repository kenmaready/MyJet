//
//  ViewController.swift
//  MyJet
//
//  Created by Ken Maready on 8/13/22.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var jets = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        // Create a new scene
        let jetScene1 = SCNScene(named: "art.scnassets/ship.scn")!
        if let jetNode1 = jetScene1.rootNode.childNode(withName: "ship", recursively: true) {
            jetNode1.position = SCNVector3(x: -0.5, y: 0.5, z: -2.0)
            sceneView.scene.rootNode.addChildNode(jetNode1)
            jets.append(jetNode1)
        }
        
        let jetScene2 = SCNScene(named: "art.scnassets/ship.scn")!
        if let jetNode2 = jetScene2.rootNode.childNode(withName: "ship", recursively: true) {
            jetNode2.position = SCNVector3(x: 0.3, y: 0.1, z: -6.0)
            sceneView.scene.rootNode.addChildNode(jetNode2)
            jets.append(jetNode2)
        }
        
        let jetScene3 = SCNScene(named: "art.scnassets/ship.scn")!
        if let jetNode3 = jetScene3.rootNode.childNode(withName: "ship", recursively: true) {
            jetNode3.position = SCNVector3(x: 0.8, y: 0.4, z: -1.3)
            sceneView.scene.rootNode.addChildNode(jetNode3)
            jets.append(jetNode3)
        }
        
        
        let sunMaterial = SCNMaterial()
        sunMaterial.diffuse.contents = UIImage(named: "art.scnassets/sun.jpeg")
        let sun = SCNSphere(radius: 0.8)
        sun.materials = [sunMaterial]
        let sunNode = SCNNode()
        sunNode.position = SCNVector3(x: 0.4, y: 1.4, z: -4.9)
        sunNode.geometry = sun
        sceneView.scene.rootNode.addChildNode(sunNode)
        
        // jet2 flyover:
        let soundSource = SCNAudioSource(fileNamed: "JetPassOver.mp3")
        let jetPassOverSound = SCNAction.playAudio(soundSource!, waitForCompletion: true)
        jets[1].runAction(jetPassOverSound)
        jets[1].runAction(SCNAction.moveBy(x: 0.2, y: 0.1, z: 9.0, duration: 5.0))
        jets[1].runAction(SCNAction.rotateBy(x:0.0, y:0.0, z: CGFloat(-Float.pi*0.5), duration: 5.0))
        
        sunNode.runAction(SCNAction.rotate(by: CGFloat(Float.pi * 6.0), around: SCNVector3(x: 0.03, y: 0.9, z: 0.0), duration: 40.0))
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
