//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Maury on 24/05/22.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var  titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumgimg: UIImageView!
    
    var stores = [Stroe]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        configureBar()
        
//        let store = Stroe(context: context)
//        store.name = "Best Buy"
//        let store2 = Stroe(context: context)
//        store2.name = "Tesla Dealership"
//        let store3 = Stroe(context: context)
//        store3.name = "Frys Electronics"
//        let store4 = Stroe(context: context)
//        store4.name = "Target"
//        let store5 = Stroe(context: context)
//        store5.name = "Amazon"
//        let store6 = Stroe(context: context)
//        store6.name = "K Mart"
//
//        ad.saveContext()

        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    private func configureBar() {
        
        let titleLabel = UILabel()
        titleLabel.text = "Add/Edit"
        navigationItem.titleView = titleLabel
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButton)) // #selector(functionToSelect)
        trashButton.tintColor = .init(red: 255, green: 150, blue: 150)
        navigationItem.rightBarButtonItem = trashButton
    }
    
    //MARK: - Picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Update when selected Row
    }
    
    //MARK: ---------
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Stroe> = Stroe.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            
        }
    }
    @IBAction func savePress(_ sender: Any) {
        
        var item: Item?
        let picture = Image(context: context)
        picture.image = thumgimg.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
        } else {
            
            item = itemToEdit
        }
        
        item?.toImage = picture
        
        if let title = titleField.text {
            
            item?.title = title
        }
        
        if let price = priceField.text {
            
            item?.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item?.details = details
        }
        
        item?.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            if let imgLoad = item.toImage?.image  {
             
                thumgimg.image = imgLoad as? UIImage
            } else {
                thumgimg.image = UIImage(named: "imagePick")
            }
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectedRow(inComponent: index)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    @objc func deleteButton() {
        
        if let itemEdit = itemToEdit {
            context.delete(itemEdit)
            ad.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Escoger imagenes desde la galeria del celular
    
    @IBAction func addImagButton(_ sender: Any) {
        if let img = imagePicker {
            present(img, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            
            thumgimg.image = img
        }
        
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    //MARK: -----------
}
