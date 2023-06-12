//
//  ViewController.swift
//  CenteredCompositionalLayout
//
//  Created by Jinwoo Kim on 6/9/23.
//

import UIKit
import Combine

@MainActor
final class ViewController: UIViewController {
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
  private var cancellable: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupDataSource()

    var snapshot: NSDiffableDataSourceSnapshot<Int, String> = .init()
    snapshot.appendSections([.zero])
    snapshot.appendItems(["1", "12", "123", "1234", "1442233", "34891890", "8230980", "18011", "98190803", "48190389048", "3jlkjdl;ja;j;d", "3jldnlkaj;ijdsho;an;owi", "slkdhehboi;shnodn", "u3901", "daljlekno;sado", "d;ajeoiahnd;ie", "20984-981-984-21", "dm;lam;am", "1213", "dje;ojs;", "dj;lejls;j;de", "3;jlwhndkmel;", "djle;js;jekj3", "d;ljlk3jljw3;j;w3", "232412", "d;ke;lsk;lke;ls", "do;je;sjl;me;", "s5d5e4s5d4e3", "dm;lsm;lmel;sm;le", "dmlsnens;des;", "dm;s;lmd;mlen.lkds", "dl;sejio83hipsdn", "del;es,k;elk'lke'", "dmel;jms;lj3i8yw83", "pu903jpomj3ojm3o"], toSection: .zero)
    dataSource.apply(snapshot)
  }

  private func setupCollectionView() {
    let configuration: UICollectionViewCompositionalLayoutConfiguration = .init()
    configuration.scrollDirection = .vertical

    let layout: UICollectionViewCompositionalLayout = .init(
      sectionProvider: { [weak self] sectionIndex, environment in
        let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1000))
        let group: NSCollectionLayoutGroup = .flow(layoutSize: groupSize, alignment: .center, horizontalSpacing: 10.0, verticalSpacing: 10.0, section: sectionIndex, collectionView: self?.collectionView)
//        group.contentInsets = .init(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0)
        let section: NSCollectionLayoutSection = .init(group: group)
        return section
    },
      configuration: configuration
    )

    let collectionView: UICollectionView = .init(frame: view.bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground

//    cancellable = collectionView.publisher(for: \.bounds, options: [.new])
//      .sink(receiveValue: { _ in
//        collectionView.collectionViewLayout.invalidateLayout()
//      })
    view.addSubview(collectionView)

    self.collectionView = collectionView
  }

  private func setupDataSource() {
    let cellRegistration: UICollectionView.CellRegistration<DynamicCollectionViewCell, String> = createCellRegistration()
    let dataSource: UICollectionViewDiffableDataSource<Int, String> = .init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
      let cell: DynamicCollectionViewCell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
      return cell
    }
    self.dataSource = dataSource
  }

  private func createCellRegistration() -> UICollectionView.CellRegistration<DynamicCollectionViewCell, String> {
    .init { cell, indexPath, itemIdentifier in
      let contentConfiguration: ContentConfiguration = .init(text: itemIdentifier)
      cell.contentConfiguration = contentConfiguration
    }
  }
}
