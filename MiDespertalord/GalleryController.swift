//
//  GalleryController.swift
//  MiDespertalord
//
//  Created by Edgardo Victorino Marin on 10/21/19.
//  Copyright © 2019 NRTEC DESARROLLOS TECNOLOGICOS. All rights reserved.
//

import UIKit

class GalleryController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollImagenes: UIScrollView!
    var mainImagenes:[UIImage] = [UIImage]()
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var lblImagen: UILabel!
    @IBOutlet weak var lblNameImagen: UILabel!
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var lblfecha: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "es_MX")
        
        
        setupCards()
        backgroundImage.image = mainImagenes[0]
        lblImagen.text = "\(Int(1.0))"
        lblNameImagen.text = "Imagen \(Int(1.0))"
        
        dateFormatter.dateFormat = "EE dd MMM yyyy"
        let currentDate = dateFormatter.string(from: Date())
        lblfecha.text = currentDate
    }
    
    public func setupCards(){
        scrollImagenes!.delegate = self
        let slides:[Slide] = createSlides()
        setupSlideScrollView(slides: slides)
    }
    
    func createSlides() -> [Slide]{
        var auxSlides:[Slide] = [Slide]()
        
        for i in 1...76{
            let strImagen = "\(i).png"
            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            
            mainImagenes.append(UIImage(named: strImagen)!)
            slide1.imagen.image = UIImage(named: strImagen)
            
            auxSlides.append(slide1)
            
        }
        
        return auxSlides
    }
    
    func setupSlideScrollView(slides:[Slide]){
        /*scrollImagenes.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
         scrollImagenes.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)*/
        scrollImagenes.contentInsetAdjustmentBehavior = .never
        scrollImagenes.frame = CGRect(x: 0, y: 0, width: scrollImagenes.frame.width, height: scrollImagenes.frame.height)
        scrollImagenes.contentSize = CGSize(width: (scrollImagenes.frame.width * (CGFloat(slides.count) + 1)) - ((CGFloat(slides.count) + 1) * 20), height: 1)
        scrollImagenes.isPagingEnabled = true
        
        var counter:Int = 0
        
        for i in 0 ..< slides.count {
            //slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            if (i != 0){
                counter += Int(scrollImagenes.frame.width)
            }
            
            slides[i].frame = CGRect(x: CGFloat(counter), y: 0, width: scrollImagenes.frame.width, height: scrollImagenes.frame.height)
            scrollImagenes.addSubview(slides[i])
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/scrollImagenes.frame.width)
        
        backgroundImage.image = mainImagenes[Int(pageIndex)]
        lblImagen.text = "\(Int(pageIndex + 1.0))"
        lblNameImagen.text = "Imagen \(Int(pageIndex + 1.0))"
        
    }
    
    

}
