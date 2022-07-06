//
//  HomeViewController.swift
//  PokedexViper
//
//  Created by Maury on 25/06/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Views
    @IBOutlet weak var colletionView: UICollectionView!
    
    private var loadingView: LoadingView?
    
    //MARK: - Properties
    private var presenter: HomePresenterProtocol
    
    //MARK: - Inits
    init(_ presenter: HomePresenterProtocol) {
        
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cycle life
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.delegate = self
        
        presenter.fetchPokemon(offset: nil)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        colletionView.collectionViewLayout = layout
        colletionView.register(.init(nibName: PokemonCell.identifier, bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)
        
        colletionView.dataSource = presenter.dataSource
        colletionView.delegate = presenter.dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: - HomePresenterDelegate
extension HomeViewController: HomePresenterDelegate {
    func showLoading() {
        
        let loading = LoadingView()
        view.addSubview(loading)
        loading.anchorTo(parentView: view)
        loading.showLoading()
        self.loadingView = loading
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            
            self.loadingView?.isHidden = true
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
    
    func reloadData() {
        
        DispatchQueue.main.async {
            
            self.colletionView.reloadData()
        }
    }
    
    func reloadDataColletionView(indexPath: IndexPath) {
        
        DispatchQueue.main.async { //Llamar hilo principal
            
            self.colletionView.reloadItems(at: [indexPath])
        }
    }
    
    func showError(title: String, message: String) {
        
    }
    
    
    
}
