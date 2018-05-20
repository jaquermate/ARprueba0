//
//  ViewController.swift
//  ARprueba0
//
//  Created by Jesus M Martínez de Juan on 15/5/18.
//  Copyright © 2018 CHECHU. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension matrix_float4x4 {
    func position() -> SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
}
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitFeature = results.last else { return }
        let hitTransform = hitFeature.worldTransform // <- if higher than beta 1, use just this -> hitFeature.worldTransform
        let position = hitTransform.position()
        let hitVector = SCNVector3Make(position.x, position.y, position.z)
        //createBall(position: hitVector)
        //createBall2()
        createCuboUFV(position: hitVector)
    }
    
    func createBall(position : SCNVector3){
        var ballShape = SCNSphere(radius: 0.01)
        var ballNode = SCNNode(geometry: ballShape)
        ballNode.position = position
        sceneView.scene.rootNode.addChildNode(ballNode)
    }
    var quepasa = Float(-3.00)
    func createBall2(){
        var ballShape = SCNSphere(radius: 0.08)
        var ballNode = SCNNode(geometry: ballShape)
        ballNode.position = SCNVector3Make(quepasa,quepasa,quepasa)
        quepasa = quepasa + 0.5
        sceneView.scene.rootNode.addChildNode(ballNode)
        ballShape.firstMaterial?.diffuse.contents = UIColor.brown
    }
    func createCuboUFV(position: SCNVector3){
        var box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "texture.png")
        box.materials = [material]
        var boxNode = SCNNode(geometry: box)
        boxNode.position = position
        
        sceneView.scene.rootNode.addChildNode(boxNode)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
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
