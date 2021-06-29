//
//  TiktaktoeVC.swift
//  Tiktactoe
//
//  Created by MacBook Pro on 29/06/21.
//

import UIKit

class TiktaktoeVC: UIViewController {

    private var state = [2,2,2,2, //0 1 2 3
                         2,2,2,2, //4 5 6 7
                         2,2,2,2, //8 9 10 11
                         2,2,2,2] //12 13 14 15
    public var player1 = 0,player2 = 0
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5 ,6 ,7], [8 ,9 ,10 ,11],[12 ,13 ,14 ,15], [0, 4, 8 ,12], [1, 5, 6, 7], [2, 6, 10, 14], [12, 13, 14, 15], [0, 5, 10, 15], [3, 6, 9, 12]]
    
    private var flag = false
    
    private let BG: UIImageView = {
        
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.image = UIImage(named: "BGXO")
        
        return myImageView
        
    }()
    
    private let Player1:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 1"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        
        return myLabel
    }()
    private let VS:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "VS"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        return myLabel
    }()
    
    private let Player2:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Player 2"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 20)
        return myLabel
    }()

    private let player1_score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isEditable = false
        textView.font = .boldSystemFont(ofSize: 18)
        return textView
    }()
    
    private let player2_score : UITextView = {
        
        let textView = UITextView()
        textView.text = ""
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.font = .boldSystemFont(ofSize: 18)
        textView.textColor = .white
        
        return textView
    }()
    
    private let TicTakToe:UILabel = {
        
        let myLabel = UILabel()
        myLabel.text = "Tic-Tak-Toe"
        myLabel.textColor = .red
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .clear
        myLabel.font = .boldSystemFont(ofSize: 30)
        return myLabel
    }()
    
    private let mycollectionview : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionview
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mycollectionview.backgroundView = BG
        //self.view.backgroundColor = .white
        view.addSubview(BG)
        view.addSubview(mycollectionview)
        view.addSubview(Player1)
        view.addSubview(VS)
        view.addSubview(Player2)
        player1_score.text = String(player1)
        player2_score.text = String(player2)
        view.addSubview(player1_score)
        view.addSubview(player2_score)
        view.addSubview(TicTakToe)
        setupcollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //BG.frame = CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        Player1.frame = CGRect(x: 20, y: 10, width: 100, height: 50)
        VS.frame = CGRect(x: 180, y: 10, width: 30, height: 50)
        Player2.frame = CGRect(x: 260, y: 10, width: 100, height: 50)
        player1_score.frame = CGRect(x: 20, y: Player1.bottom + 5, width: 100, height: 50)
        player2_score.frame = CGRect(x: 260, y: Player2.bottom + 5, width: 100, height: 50)
        TicTakToe.frame = CGRect(x: 0, y: view.height - 80, width: view.width, height: 40)
        mycollectionview.frame = view.bounds
        
    }


}
extension TiktaktoeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    private func setupcollectionView()
    {
        mycollectionview.register(TicTakToeCollViewCell.self, forCellWithReuseIdentifier: "TicTakToeCollViewCell")
        mycollectionview.delegate = self
        mycollectionview.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TicTakToeCollViewCell", for: indexPath) as! TicTakToeCollViewCell
        cell.setupcell(with: state[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if flag{//inssertion of X and 0
                state.insert(0, at: indexPath.row)
                
            }
            else{
                state.insert(1, at: indexPath.row)
                
            }
            flag = !flag
            collectionView.reloadData()
            checkwinner()
        }
    }
    private func checkwinner()
    {
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game Over", message: "Draw", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations{
            if state[i[0]] == state[i[1]] && state[i[1]] == state[i[2]] && state[i[2]] == state[i[3]] && state[i[0]] != 2 {
                announcewinner(player: state[i[0]] == 0 ? "0" : "X")
                break
            }
        }
    }
    private func announcewinner(player:String){
        if player == "X"
        {
            player1+=1
            player1_score.text = String(player1)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 1 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            player2+=1
            player2_score.text = String(player2)
            
            let alert = UIAlertController(title: "Game Over", message: "Player 2 won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resettiktactoe()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    private func resettiktactoe()
    {
       state = [2,2,2,2,
                2,2,2,2,
                2,2,2,2,
                2,2,2,2]
        
        flag = false
        mycollectionview.reloadData()
    }
    
}
