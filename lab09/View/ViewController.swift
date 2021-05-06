//
//  ViewController.swift
//  lab09
//
//  Created by mbtec22 on 5/6/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var pokeListPicker: UIPickerView!
    @IBOutlet weak var pokeTextField: UITextField!
    
    var viewPokeModel = ViewModelPokemon()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPicker()
        bind()
        setUpTextField()
    }
    
    func setUpPicker() {
        pokeListPicker.delegate = self
        pokeListPicker.dataSource = self
        viewPokeModel.getListPokemon()
    }
    
    func setUpTextField() {
        pokeTextField.delegate = self
        pokeTextField.inputView = pokeListPicker
    }
    
    func bind() {
        viewPokeModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                [self] in self?.pokeListPicker.isHidden = true
            }
        }
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewPokeModel.dataArrayPokemonList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return viewPokeModel.dataArrayPokemonList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokeTextField.text = viewPokeModel.dataArrayPokemonList[row].name
        pokeListPicker.isHidden = true
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pokeListPicker.isHidden = false
        return false
    }
    
}
