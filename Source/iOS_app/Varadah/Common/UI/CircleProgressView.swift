import UIKit


public class CircleProgressView: UIView {
    var progress: Double = 0.0
    let degreePerPoint = 360.0 / 100.0
    let twoSeventyDegrees = 270.0
    var startAngleAdjustment = -90.0
    let animateDuration = 0.75
    var arcWidth: CGFloat = 12
    var homeScreen: Bool = true
    var trackBackgroundColor: UIColor = UIColor.whiteColor()
    var trackFillColor: UIColor = UIColor(red: 14/255, green: 169/255, blue: 206/255, alpha: 1.0)
    var progressLine: CAShapeLayer?

    func calculateRadius() -> CGFloat {
        var radius: CGFloat = ((bounds.width +
            bounds.height)/ViewControllerConstants.CircleProgressView.kRadiusDenominator)
        if self.homeScreen {
            radius = UIScreen.mainScreen().bounds.width == 320 ? 50 : 68
            if  UIScreen.mainScreen().bounds.width == 414 {
                radius = 75
            }
        }
        return radius
    }
    func clearPreviousDrawn() {
        if let _ = self.viewWithTag(100) {
            self.viewWithTag(100)?.removeFromSuperview()
        }
        self.progressLine?.removeFromSuperlayer()
        self.layer.removeAllAnimations()
    }
    func updateUI() {
        self.clearPreviousDrawn()
        self.setNeedsDisplay()
        self.animateProgress()
    }
    func animateProgress() {
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.15 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.animateDial()
        }
    }
    func getProgressEndPoint(center: CGPoint, radius: CGFloat, endAngle: CGFloat) -> CGPoint {
        return CGPointMake((cos(endAngle) * radius) + center.x, (sin(endAngle) *
            radius) + center.y)
    }
    func createShapeLayer(path: UIBezierPath, fillColor: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        layer.strokeColor = fillColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.lineWidth = self.arcWidth
        layer.lineCap = kCALineCapSquare
        return layer
    }
    func createAnimation() -> CABasicAnimation {
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.duration = self.animateDuration
        animate.fromValue = 0.0
        animate.toValue = 1.0
        return animate
    }
    func animateDial() {
        // set up some values to use in the curve
        let progressAngle = (self.degreePerPoint*self.progress)+self.startAngleAdjustment
        let startAngle = CGFloat(self.startAngleAdjustment * M_PI/180)
        let endAngle = CGFloat(progressAngle * M_PI/180)
        let center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        let radius: CGFloat = self.calculateRadius()
        
        // create the front bezier path
        let progressPath = UIBezierPath()
        progressPath.addArcWithCenter(center, radius: radius, startAngle: startAngle,
            endAngle: endAngle, clockwise: true)
        let frontProgressLine = self.createShapeLayer(progressPath,
            fillColor: trackFillColor.CGColor)
        self.progressLine = frontProgressLine
        self.layer.addSublayer(frontProgressLine)
        let progressAnimation = self.createAnimation()
        frontProgressLine.addAnimation(progressAnimation, forKey: "frontProgressAnimation")
        
        //  Indicator point image view
        let pointerImageHeight: CGFloat = 18
        let ImagePointer: UIImageView = UIImageView(image: UIImage(
            named: "circle_progress_indicator"))
        let progressEndPoint = self.getProgressEndPoint(center, radius: radius,
            endAngle: endAngle)
        ImagePointer.frame = CGRect(x: (progressEndPoint.x-(pointerImageHeight/2)),
            y: (progressEndPoint.y-(pointerImageHeight/2)),
            width: pointerImageHeight, height: pointerImageHeight)
        ImagePointer.tag = 100
        self.addSubview(ImagePointer)
        
        // create a new animation for pointer
        let animateIndicator = CAKeyframeAnimation(keyPath: "position")
        animateIndicator.path = progressPath.CGPath
        animateIndicator.calculationMode = kCAAnimationPaced
        animateIndicator.rotationMode = kCAAnimationRotateAuto
        animateIndicator.repeatCount = 1
        animateIndicator.duration = self.animateDuration
        animateIndicator.delegate = self
        ImagePointer.layer.addAnimation(animateIndicator, forKey: "animate position along path")
    }
    func drawDial(rect: CGRect) {
        let dialStartAngle = CGFloat(self.startAngleAdjustment * M_PI/180)
        let dialEndAngle = CGFloat(self.twoSeventyDegrees * M_PI/180)
        let center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let radius: CGFloat = self.calculateRadius()
        let path = UIBezierPath(arcCenter: center, radius: radius,
            startAngle: dialStartAngle, endAngle: dialEndAngle, clockwise: true)
        // Draw Background Circle
        path.lineWidth = self.arcWidth
        trackBackgroundColor.setStroke()
        path.stroke()
    }
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.drawDial(rect)
    }
}
