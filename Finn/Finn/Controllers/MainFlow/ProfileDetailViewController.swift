//
//  ProfileDetailViewController.swift
//  Finn
//
//  Created by 김성종 on 2018. 4. 3..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {
  
  //MARK:- data property
  var userProfile: UserProfile!
  
  //MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

//MARK:- IBActions
extension ProfileDetailViewController {
  @IBAction func rewindFromEditView(_ sender: UIStoryboardSegue) {
  }
}
