//
//  HomeViewController.swift
//  QuadradosExplosivos
//
//  Created by Stefanini on 10/10/18.
//  Copyright © 2018 Stefanini. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIDynamicAnimatorDelegate {
    
    private var animator: UIDynamicAnimator?
    private var behavior: SquareBehavior?
    private var square = [UIView]()
    @IBOutlet weak var tabuleiro: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configDinamicAnimation()
    }
    @IBAction func onQuadrado(_ sender: Any) {
        let size = self.randomSize()
        var x = arc4random() % UInt32(tabuleiro.bounds.size.width)
        x = x / UInt32(size.width)
        let pointX = CGPoint(x: CGFloat(x) * size.width, y: 0)
        createSquare(pointX: pointX, size: size)
    }
    
    @IBAction func onTouch(_ sender: UITapGestureRecognizer) {
        
        let size = self.randomSize()
        let location  = sender.location(in: self.tabuleiro)
        createSquare(pointX: location, size: size)
    }
    
    @IBAction func onRemove(_ sender: Any) {
        self.explodir()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weak var timer : Timer?
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { (timer) in
            self.explodir()
        }
    }
    private func explodir() {
        guard square.count > 0 else { return }
        square.forEach({behavior?.removeItem($0)})
        UIView.animate(withDuration: 1,
                       animations: { [unowned self] in
                        for square in self.square {
                            let x = arc4random() % UInt32(self.tabuleiro.bounds.size.width * 5)
                            let aux  = UInt32(self.tabuleiro.bounds.size.width * 2)
                            let newX = CGFloat(x) - CGFloat(aux)
                            
                            let y = self.tabuleiro.bounds.size.height
                            square.center = CGPoint(x: newX, y: -y)
                        }
        }) { [weak self] (interrupted) in
            self?.square.forEach({$0.removeFromSuperview()})
            self?.square.removeAll()
        }
    }
    private func createSquare(pointX point : CGPoint, size: CGSize){
        let frame = CGRect(origin: point, size: size)
        let newSquare = UIView(frame: frame)
        newSquare.backgroundColor = randomColor()
        tabuleiro.addSubview(newSquare)
        behavior?.addItem(newSquare)
        square.append(newSquare)
    }
    
    private func randomSize() -> CGSize {
        var size = randomNumber(value: Double(self.view.frame.size.width), piece: 3)
        while( size < 1 ){
            size = randomNumber(value: Double(self.view.frame.size.width), piece: 3)
        }
        return CGSize(width: size, height: size)
    }
    
    private func randomColor() -> UIColor {
        return UIColor(red: randomNumber(value: 255, piece: 255), green: randomNumber(value: 255, piece: 255), blue: randomNumber(value: 255, piece: 255), alpha: 1)
    }
    
    private func randomNumber(value: Double, piece: Double) -> CGFloat{
        return CGFloat(Double(arc4random() % UInt32(value)) / piece)
    }
    
    func configDinamicAnimation() {
        behavior = SquareBehavior()
        animator = UIDynamicAnimator(referenceView: tabuleiro)
        animator?.delegate = self
        animator?.addBehavior(behavior!)
    }
}


