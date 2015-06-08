//
//  ViewController.swift
//  picker
//
//  Created by guitarrkurt on 02/06/15.
//  Copyright (c) 2015 guitarrkurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //var pickerData = [String]()
    var pickerData = NSMutableArray()
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textFile: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func botonAgregar(sender: AnyObject) {
        //Consigue la cadena
        var nuevo:String = textFile.text;
        
        //label.text = nuevo //borrar la label
        
       
        //Consigue la ruta
        let path2 = NSBundle.mainBundle().pathForResource("fruits", ofType: "plist")
        
        //Almace lo que tenga la ruta en un MutableArray
        pickerData = NSMutableArray(contentsOfFile: path2!)!
        
        //Inserta el nuevo elemento en el MutableArray
        pickerData.insertObject(nuevo, atIndex: pickerData.count)
        
        //Escribe al archivo con tal ruta
        pickerData.writeToFile(path2!, atomically: true)
        
        
        
        self.picker.dataSource = self
        self.picker.delegate = self

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let path = NSBundle.mainBundle().pathForResource("fruits", ofType: "plist")
        pickerData = NSMutableArray(contentsOfFile: path!)!
        
    
    //pickerData = ["Melon 🍊", "Sandia 🍉", "Pera 🍐", "Manzana 🍅", "Uva 🍇"]
    
        
        
    self.picker.dataSource = self
    self.picker.delegate = self
    
    }
    
    //Numero de componentes que hay en el pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Numero de elementos que tiene mi variable
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //El titulo que va a tener cada uno de los renglones
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        //return pickerData[row]
        
        return pickerData[row] as! String
    }
    //Que hago si ya seleccionaron un renglon
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Si lo selecciona enviamos una alerta
        let alert = UIAlertView()
        alert.title = "Selecccion"
        //alert.message = pickerData[row]
        
        alert.message = (pickerData[row] as! String)
        
        
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData: AnyObject = pickerData[row]
    
        
        //color  and center the label's background
        let hue = CGFloat(row)/CGFloat(pickerData.count)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        pickerLabel.textAlignment = .Center
        
        
        let myTitle = NSAttributedString(string: titleData as! String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        
        
        
        
        
        return pickerLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

