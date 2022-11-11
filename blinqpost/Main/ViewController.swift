//
//  ViewController.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 05/11/2022.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import AVFoundation

class ViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    let viewModel = ViewModel()
    private var bags = DisposeBag()
    
    //MARK: - Top Visible view before scrolling
   lazy var profileInfoHeadView = ProfileCustomHeaderView()
    
    //MARK: - Top hiding View Before Scrolling
    lazy var customSegmentedControl = CustomSegmentedHeader()
    
    //MARK: - Collection view
    lazy var collectionView = UICollectionView.genericCollectionView(direction: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)

        collectionView.register(EmptyHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmptyHeader.identifier)
       
        view.addSubview(collectionView)
        view.addSubview(profileInfoHeadView)
        viewModel.getUserProfile()
        viewModel.getPostData()
        viewModel.getVideoData()
        getUserProfile()
        getCollectionData()
        
//        bindCollection()

    }
    
    func getUserProfile() {
        viewModel.userProfile.subscribe { [weak self] userProfile in
            print("This is from the view controller \(userProfile)")
            self?.profileInfoHeadView.configureHeader(with: userProfile)
        } onError: { error in
            print("An error has occured")
        } onCompleted: {
            print("Ended")
        } onDisposed: {
            Disposables.create { }
        }
    }
    
    func getCollectionData() {
        viewModel.postsData.subscribe { [weak self] data in
            self?.viewModel.collectionData = data
            self?.collectionView.reloadData()
        } onError: { error in
            print(error)
        } onCompleted: {
            print("stop")
        } onDisposed: {
            Disposables.create()
        }

    }
    
    
    
    fileprivate func setupProfileInfoHeaderView() {
        profileInfoHeadView.setViewConstraints(top: view.topAnchor, right: view.trailingAnchor, bottom: nil, left: view.leadingAnchor, paddingTop: 70, paddingLeft: 20, paddingRight: 20, height: 210)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.setViewConstraints(top: view.topAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.transform = .init(translationX: 0,
                                                              y: max(0, 230))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavbar()
//        setupHeaderView()
        setupProfileInfoHeaderView()
        setupCollectionView()
    }
    
    
    fileprivate func setupNavbar() {
//        navigationItem.title = "Testing Title"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.line"), style: .plain, target: self, action: #selector(editTapped))
        let width = view.frame.width
        let bgView = UIView.bgView()
        bgView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        bgView.addSubview(customSegmentedControl)
        customSegmentedControl.frame = bgView.bounds
//        profileHeaderView.pin(to: bgView)
        navigationItem.titleView = bgView
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.profileHeaderView.layer.opacity = 1
//            self.profileHeaderView.isHidden = true
        }
        customSegmentedControl.postButton.addTarget(self, action: #selector(postButtonTapped(_:)), for: .touchUpInside)
        customSegmentedControl.videoButton.addTarget(self, action: #selector(videoButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func editTapped() {
        print("Edit tapped")
        navigationController?.navigationBar.transform = .init(translationX: 0,
                                                              y: 0)
        coordinator?.gotoEditController()
    }
    
    @objc private func postButtonTapped(_ sender: UIButton) {
        print("I am testing this againg")
        customSegmentedControl.showVideoUnderline = false
        customSegmentedControl.showPostUnderLine = true
        viewModel.collectionData = viewModel.posts
        collectionView.reloadData()
//        viewModel.mediaData.on(.next(viewModel.posts))
    }
    
    @objc private func videoButtonTapped(_ sender: UIButton) {
        print("I am testing this againg")
        customSegmentedControl.showVideoUnderline = true
        customSegmentedControl.showPostUnderLine = false
        viewModel.collectionData = viewModel.videos
        collectionView.reloadData()
//        viewModel.mediaData.on(.next(viewModel.videos))
    }
    
//    func bindCollection() {
//        collectionView.rx.setDelegate(self).disposed(by: bags)
//        viewModel.mediaData.bind(to: collectionView.rx.items(cellIdentifier: CollectionCell.identifier, cellType: CollectionCell.self)) { (row, item, cell) in
//            cell.configureCell(with: item)
//        }.disposed(by: bags)
//    }
    
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: viewModel.collectionData[indexPath.row])
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EmptyHeader.identifier, for: indexPath) as? EmptyHeader else {
            return UICollectionReusableView()
        }
        return header
    }

}
extension ViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let magicalArea: CGFloat = 140
        
        let vOffset = -(scrollView.contentOffset.y) + magicalArea
        let alpha: CGFloat = 1 - ((scrollView.contentOffset.y * 2 / magicalArea) )
        if vOffset < 95 {
            navigationController?.navigationBar.transform = .init(translationX: 0,
                                                                  y: 0)
            profileInfoHeadView.alpha = 0
        } else {
            navigationController?.navigationBar.transform = .init(translationX: 0,
                                                                  y: max(0, vOffset))
            profileInfoHeadView.alpha = alpha
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width - 40, height: 235)
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .ignoresSafeArea()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return ViewController()
        }
    }
    
}

