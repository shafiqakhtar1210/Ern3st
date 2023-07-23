import UIKit
import MetalKit
import Tg3dMobileScanSDK_iOS
import SceneKit
import ZIPFoundation
import DWAnimatedLabel
import AVFoundation
import AVKit

class ViewController: BaseViewController {
    @IBOutlet weak var scanTitleLabel: UILabel!
    @IBOutlet weak var userNameTitle: UILabel!
    var showProfilePageFromReg = false
    
    @IBOutlet weak var genderLabel: ToggleLabel!
    
   
    @IBOutlet weak var delScanBtn: UIButton!
    @IBOutlet weak var collarLabel: CustomLabel!
    @IBOutlet weak var hipLabel: CustomLabel!
    @IBOutlet weak var chestLabel: CustomLabel!
    @IBOutlet weak var armLengthLabel: CustomLabel!
    @IBOutlet weak var collarTitle: CustomLabel!
    @IBOutlet weak var hipCircumTitle: CustomLabel!
    @IBOutlet weak var chestTitle: CustomLabel!
    @IBOutlet weak var armLengthTitle: CustomLabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var weightTitle: UILabel!
    @IBOutlet weak var heightTitle: CustomLabel!
    @IBOutlet weak var genderTitleLabel: UILabel!
    @IBOutlet weak var scansLeftTitle: UILabel!
    @IBOutlet weak var lastScanDateTitle: UILabel!
    @IBOutlet weak var scanDateLabel: CustomLabel!
    @IBOutlet weak var leftThighImgVw: UIImageView!
    @IBOutlet weak var fullUserNameLabel: CustomLabel!
    @IBOutlet weak var emailLabel: CustomLabel!
    
    @IBOutlet weak var passwordLabel: CustomLabel!
    @IBOutlet weak var loginTitleLabel: CustomLabel!
    @IBOutlet weak var measurementsDetailView: UIView!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
  
    @IBOutlet weak var m_button: UIButton!
    
    @IBOutlet weak var f_button: UIButton!
    
   
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var userNickLabel: CustomLabel!
    
    @IBOutlet weak var userNameLabel: CustomLabel!
    var apiManager = ApiNetworkManager()
    
    @IBOutlet weak var labelsView: UIView!
    
    @IBOutlet weak var dashboardContainerView: UIView!
  
    @IBOutlet weak var startScanButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageContainer: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var uploadLabel: CustomLabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var uploadDetailLabel: CustomLabel!
    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var takeMeasurementButton: UIButton!
    
    @IBOutlet weak var viewScanButton: UIButton!
    @IBOutlet weak var numberOfScanLabel: CustomLabel!
    
    @IBOutlet weak var delButton: UIButton!
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var previewView: MTKView!
    
    @IBOutlet weak var goToScanButton: UIButton!
    
    @IBOutlet weak var previewVideoView: MTKView!
    @IBOutlet weak var uploadButton: UIButton!
    
    @IBOutlet weak var weightInput: UITextField!
    @IBOutlet weak var reviewAccountInput: UITextField!
    @IBOutlet weak var reviewPasswordInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var heightInput: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    var anotherTid: String!
    var scan: Scan!
    var showMesurements = false
    var gender: String = ""
    let smallVideoPlayerViewController = AVPlayerViewController()
    let apiKey: String = "jpbDi9zrB1zXXpWLnMCdUm2ay3EXxz0rfeIt" // your apikey
    let scannerId: String = "​N3bxK2R" // your scanner ID
    let sessionKey: String = "WC5fWj4JSQw71GrgjkTgSI5T1CMFhgpGUGgt" // your session key
    
    var sdk: TG3DMobileScan?
    var userProfile: UserProfile?
    var lastScanRecord: ScanRecord?
    var currentSegue: String = ""
    var isScanning: Bool = false
    var tid: String = ""
    var previewVidelUrl: URL?
    var player: AVPlayer?
    var registerEmail: String = ""
    var registerPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
       
       
        
        let borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.7).cgColor
        self.accountInput?.layer.borderWidth = 1
        self.accountInput?.layer.cornerRadius = 3.0
        self.accountInput?.layer.borderColor = borderColor
        self.passwordInput?.layer.borderWidth = 1
        self.passwordInput?.layer.cornerRadius = 3.0
        self.passwordInput?.layer.borderColor = borderColor
        self.reviewPasswordInput?.layer.borderWidth = 1
        self.reviewPasswordInput?.layer.cornerRadius = 3.0
        self.reviewPasswordInput?.layer.borderColor = borderColor
        self.usernameInput?.layer.borderWidth = 1
        self.usernameInput?.layer.cornerRadius = 3.0
        self.usernameInput?.layer.borderColor = borderColor
        self.heightInput?.layer.borderWidth = 1
        self.heightInput?.layer.cornerRadius = 3.0
        self.heightInput?.layer.borderColor = borderColor
        if self.sdk == nil {
            self.sdk = TG3DMobileScan(apiKey: self.apiKey)
            self.sdk!.currentRegion() { (rc, baseUrl) in
                if rc == 0 {
                    self.sdk!.setup(baseUrl: baseUrl)
                }
            }
        }
     
        if self.currentSegue == "showMainPage" || self.currentSegue == "showMainPage2" || self.currentSegue == "showMainPage3" {
          
          
           
            if self.currentSegue == "showMainPage" || self.currentSegue == "showMainPage2"{
                print("we got here in the upper block")
                if self.lastScanRecord != nil {
                    print("we got here in main page")
                    self.tid = self.lastScanRecord!.tid!
                    let dateStr = self.lastScanRecord!.updatedAt!
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let date = dateFormatter.date(from: dateStr)
                    
                }
            }
            else if self.currentSegue == "showMainPage3"{
                if self.scan != nil {
                    self.tid = self.scan.scan_tid
                    let dateStr = self.scan.scan_date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    let date = dateFormatter.date(from: dateStr)
                    
                }
                
            }
           // apiManager.editOrder(orderId: GlobalUserData.orderId)
            
            let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
            collarTitle.underlineWithCustomFont(text: "COLLAR", font: font, underlineStyle: .single)
            armLengthTitle.underlineWithCustomFont(text: "ARM LENGTH", font: font, underlineStyle: .single)
            hipCircumTitle.underlineWithCustomFont(text: "HIP CIRCUMFERENCE", font: font, underlineStyle: .single)
            chestTitle.underlineWithCustomFont(text: "CHEST", font: font, underlineStyle: .single)
            
            
           
           
            
            
                
               
            self.sdk?.doGetAutoMeasurements(tid: self.tid){data,response in
                print("data and response in measurements")
                var chestCircum = "0 "
                var armLength = "0"
                var collarCircum = "0"
                var lowHipCircum = "0"
                DispatchQueue.main.async {
                    self.scanTitleLabel.isHidden = false
                    self.scanTitleLabel.underlineWithCustomFont(text: "NO SCANS YET", font: font, underlineStyle: .single)                                   }
                
                if  let dict = response?["measurement"] as? [String: Any]{
                    DispatchQueue.main.async {
                        self.scanDateLabel.isHidden = true
                                       }
                    
                    
                    print(dict)
                    if let dict2 = dict["Chest Circumference"] as? [String: Any]{
                        let str = String(String(describing: dict2["value"]!))
                        chestCircum = String(str.prefix(4))
                        
                        if let dict3 = dict["Left Arm Length"] as? [String: Any]{
                            let str = String(String(describing: dict3["value"]!))
                            armLength = String(str.prefix(4))
                            
                            
                        }
                        if let dict4 = dict["Collar Circumference"] as? [String: Any]{
                            let str = String(String(describing: dict4["value"]!))
                            collarCircum = String(str.prefix(4))
                            
                        }
                        if let dict5 = dict["Low Hip Circumference"] as? [String: Any]{
                            let str = String(String(describing: dict5["value"]!))
                            lowHipCircum = String(str.prefix(4))
                            
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.chestLabel.underlineWithCustomFont(text: chestCircum + " CM", font: font, underlineStyle: .single)
                    self.armLengthLabel.underlineWithCustomFont(text: armLength + " CM", font: font, underlineStyle: .single)
                    self.collarLabel.underlineWithCustomFont(text: collarCircum + " CM", font: font, underlineStyle: .single)
                    self.hipLabel.underlineWithCustomFont(text: collarCircum + " CM", font: font, underlineStyle: .single)                  }
                

                
            }
            
            
                self.sdk!.getObj(tid: self.tid) { (rc, url) in
                    print(String(format: "getObj(), rc = %d", rc))
                    print(String(format: "Obj URL: %@", url!))
                    
                    // download zipped obj and show with viewer
                    // get path of directory
                    guard let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                       
                        return
                    }
                    
                    let fileManager = FileManager()
                    
                    // create file url
                    let fileUrl = directory.appendingPathComponent("model.zip")
                    try? fileManager.removeItem(at: fileUrl)
                    
                    // starts download
                    let session = URLSession(configuration: .default)
                    var request = try! URLRequest(url: URL(string: url!)!)
                    request.httpMethod = "GET"
                    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                        if let tempLocalUrl = tempLocalUrl, error == nil {
                            // Success
                            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                                print("Success: \(statusCode)")
                            }
                            
                            do {
                                try FileManager.default.copyItem(at: tempLocalUrl, to: fileUrl)
                                print("downloaded..")
                                
                                var destinationURL = fileManager.temporaryDirectory
                                destinationURL.appendPathComponent("models")
                                try? fileManager.removeItem(at: destinationURL)
                                
                                try fileManager.unzipItem(at: fileUrl, to: destinationURL)
                                let files = try FileManager.default.contentsOfDirectory(at: destinationURL,
                                                                                        includingPropertiesForKeys: nil,
                                                                                        options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants, .skipsPackageDescendants])
                                print(files)
                                if files.count > 0 {
                                    print(files[0])
                                    guard let scene = try? SCNScene(url: files[0]) else {
                                        print("failed to load obj.")
                                        return
                                    }
                                    let cameraNode = SCNNode()
                                    cameraNode.camera = SCNCamera()
                                    cameraNode.camera!.zNear = 1
                                    cameraNode.camera!.zFar = 3000
                                    cameraNode.position = SCNVector3(x: 0, y: 1000, z: 2000) // unit is mm
                                    scene.rootNode.addChildNode(cameraNode)
                                    self.sceneView.autoenablesDefaultLighting = true
                                   
                                    self.sceneView.allowsCameraControl = true
                                    self.sceneView.backgroundColor = UIColor.gray
                                    self.sceneView.cameraControlConfiguration.allowsTranslation = false
                                    self.sceneView.scene = scene
                                    print("3D ok.")
                                }
                                try? fileManager.removeItem(at: fileUrl)
                                
                            } catch (let writeError) {
                                print(writeError)
                                print("error writing file")
                            }
                            
                        } else {
                            print("Failure: %@", error?.localizedDescription);
                        }
                    }
                    task.resume()
                }
            
        }
        if self.currentSegue == "showScanPage" {
            var userHeight = self.userProfile!.height
            // NOTE: User height is required, it impacts scan result!
            //       Please make sure the user height is correct.
            if userHeight <= 0 {
                userHeight = 180
            }
            self.sdk!.initMobileScan(scannerId: self.scannerId,
                                     sessionKey: self.sessionKey,
                                     userHeight: userHeight) { (rc, tid) in
                if rc != 0 {
                    // NOTE: Mobile scan is limited to 3 scans per month per user,
                    // handle if rc = 40306: 'Number of scans over limit'
                    if rc == 40306 {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: String(format: "Error Number of scans over limit", rc),
                                                                    message: "You can only take 3 scans in a month.You are exceeding this limit",
                                                                    preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default){
                                _ in
                                self.performSegue(withIdentifier: "backMainPage", sender: nil)
                                
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)

                            // back to main page
                            self.startScanButton.isEnabled = false
                           
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: String(format: "Error code: %d", rc),
                                                                    message: "Failed to init mobile scan",
                                                                    preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default){
                                _ in
                                self.performSegue(withIdentifier: "backMainPage", sender: self)
                            }
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)

                            // back to main page
                            self.startScanButton.isEnabled = false
                          
                        }
                    }
                    return
                }
                self.tid = tid!
                print(String(format: "initMobileScan(), rc = %d, tid: %@", rc, tid!))
                self.previewView.depthStencilPixelFormat = .invalid
                self.sdk!.prepareForRecord(preview: self.previewView) { (rc) in
                    print(String(format: "prepareForRecord(), rc = %d", rc))
                }
            }
        }
        if self.currentSegue == "showPreviewVideo" {
            self.player = AVPlayer(url: self.previewVidelUrl!)
            DispatchQueue.main.async(execute: {() -> Void in
                let playerLayer = AVPlayerLayer(player: self.player!)
                playerLayer.frame = self.previewVideoView.bounds
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                playerLayer.zPosition = 1
                self.previewVideoView.layer.addSublayer(playerLayer)
                self.player?.seek(to: CMTime.zero)
                self.player?.play()
            })
        }
        if self.currentSegue == "showProfilePage" || self.currentSegue == "showProfilePage2" || self.currentSegue == "backMainPage" || self.currentSegue == "showProfilePageFromReg" || self.currentSegue == "showProfileFromScan"{
            if self.currentSegue == "showProfilePageFromReg"{
                self.showProfilePageFromReg = true
            }
            let font = UIFont(name: "PanamaMonospace-Regular", size: 20)!
            userTitle.underlineWithCustomFont(text: "USER NAME", font: font, underlineStyle: .single)
            lastScanDateTitle.underlineWithCustomFont(text: "LAST SCAN", font: font, underlineStyle: .single)
            scansLeftTitle.underlineWithCustomFont(text: "SCANS LEFT", font: font, underlineStyle: .single)
            //genderTitleLabel.underlineWithCustomFont(text: "SEX", font: font, underlineStyle: .single)
            heightTitle.underlineWithCustomFont(text: "HEIGHT", font: font, underlineStyle: .single)
            weightTitle.underlineWithCustomFont(text: "WEIGHT", font: font, underlineStyle: .single)
            if self.currentSegue == "showProfilePageFromReg"{
                let userProfile = GlobalUserData.userProfile
                let userName = userProfile.name
                fullUserNameLabel.text = userName
                userNameLabel.text = userName
                scanDateLabel.text = "No Scan Yet"
                numberOfScanLabel.text = "3"
                let height = userProfile.height
                heightLabel.text = String(describing: height)
                
               
                let gender = userProfile.gender
                    if gender == 0{
                        genderLabel.text = "No Gender"
                    }
                   else if gender == 1{
                        genderLabel.text = "Male"
                    }
                    else if gender == 2{
                         genderLabel.text = "Female"
                     }
                else{
                    genderLabel.text = "Not Given"
                }
                 let weight = userProfile.weight
                    if weight == -1{
                        weightLabel.text = "0"
                    }
                    else{
                        weightLabel.text = String(describing: weight)
                        
                    }
                return
                    
            
               
                
            }
           
          
            //delButton.centerVerticallyWithPadding(padding: 8)
            //viewScanButton.centerVerticallyWithPadding(padding: 10)
           // takeMeasurementButton.centerVerticallyWithPadding(padding: 10)
            
            var dateStr: String = ""
            if self.lastScanRecord != nil{
                
                dateStr = self.lastScanRecord!.updatedAt!
            }
            else{
                dateStr = "No Scan "
                
            }
           
            
            let firstTen = String(dateStr.prefix(10))
           
            let userName = self.userProfile?.name
            fullUserNameLabel.text = userName
            userNameLabel.text = userName
            scanDateLabel.text = firstTen
            numberOfScanLabel.text = "3"
            if let height = self.userProfile?.height{
                heightLabel.text = String(describing: height)
            }
            else{
                heightLabel.text = "Not Given"
            }
            if let gender = self.userProfile?.gender{
                if gender == 0{
                    genderLabel.text = "No Gender"
                }
               else if gender == 1{
                    genderLabel.text = "Male"
                }
                else if gender == 2{
                     genderLabel.text = "Female"
                 }            }
            else{
                genderLabel.text = "Not Given"
            }
            if let weight = self.userProfile?.weight{
                if weight == -1{
                    weightLabel.text = "0"
                }
                else{
                    weightLabel.text = String(describing: weight)
                    
                }
                
            }
            else{
                weightLabel.text = "Not Given"
            }
        
        }
      
        if self.currentSegue == "showRegisterPage" {
            // Set the image for the unselected state
           

            // Set other buttons in a similar manner

           

            reviewAccountInput.delegate = self
            reviewPasswordInput.delegate = self
            usernameInput.delegate = self
            heightInput.delegate = self
            weightInput.delegate = self
            self.reviewAccountInput.text = self.registerEmail
            self.reviewPasswordInput.text = self.registerPassword
            
        }
        if self.currentSegue == "showLoginPage" || self.currentSegue == "backToLoginPage" || self.currentSegue == "showLoginPageFromDel"{
            print("got here in showLoginPage again")
          
            let font = UIFont(name: "PanamaMonospace-Regular", size: 25)!
           
            emailLabel.underlineWithCustomFont(text: "EMAIL", font: font, underlineStyle: .single)
            passwordLabel.underlineWithCustomFont(text: "PASSWORD", font: font, underlineStyle: .single)
            loginTitleLabel.underlineWithCustomFont(text: "PLEASE PROVIDE YOUR DETAILS TO LOG IN", font: font, underlineStyle: .single)
            signinButton.underlineTextWithCustomFont(text: "SIGN IN", font: font, underlineStyle: .single)
            registerBtn.underlineTextWithCustomFont(text: "REGISTER WITH EMAIL", font: font, underlineStyle: .single)
           
            accountInput.delegate = self
            passwordInput.delegate = self
          
            
        }
        if self.currentSegue == "showUploadFinishedPage" {
            UIView.animate(withDuration: 0.6,
                           animations: { [self] in
                    self.uploadImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.uploadLabel.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                self.uploadDetailLabel.alpha = 0.0
                self.backButton.alpha = 0.0
                      },
                completion: { _ in
                UIView.animate(withDuration: 1.0) { [self] in
                        self.uploadImage.transform = CGAffineTransform.identity
                    self.uploadLabel.transform = CGAffineTransform.identity
                    self.uploadDetailLabel.alpha = 1.0
                    self.backButton.alpha = 1.0
                   
                    
                    }
                })
            
            
        }
    }
    @IBAction func getAutoMesurements(_ sender: Any) {
        let my_tid = "307a20a8-35e3-44ef-805a-c3d56e6c1e4d"
        self.sdk?.doGetAutoMeasurements(tid:my_tid){
            rc, dict in
            print("getting scan mesurements ")
            print(rc)
            print("\(dict)")
        }
    }
    
    @IBAction func genderSelected(_ sender: Any) {
        let button = sender as! UIButton
        let tag = button.tag
        m_button.isSelected = false
        f_button.isSelected = false
        m_button.setImage(UIImage(named: "unchecked"), for: .normal)
        f_button.setImage(UIImage(named: "unchecked"), for: .normal)            // Deselect other buttons in a similar manner
            
            // Select the tapped button
        button.isSelected = true
        button.setImage(UIImage(named: "checked"), for: .selected)
        if tag == 1{
            gender = "male"
            print(gender)
           
            
            
        }
        if tag == 2{
            gender = "female"
            print(gender)
          
           
            
        }
    }
    
  
    
    
    @IBAction func stopApp(_ sender: Any) {
        showAlert()
        
    }
    func showAlert() {
        let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to quit the app?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Handle cancel action if needed
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Perform actions to stop the app
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func viewScans(_ sender: Any) {
        self.addActivityIndicator()
        self.sdk?.doGetUserScans(completion: {data,response in
            print("data and response in view scans")
            print(data)
            if let parsedJson = response?["records"] as? [[String: Any]]{
                for dict in parsedJson{
                    let date = String(describing:  dict["created_at"]!)
                    let dateStr = String(date.prefix(10))
                    let tid = String(describing:  dict["tid"]!)
                    let scan = Scan(scan_date: dateStr, scan_tid: tid)
                    GlobalUserData.scans.append(scan)
                }
                
                
            }
           
            
            DispatchQueue.main.async {
                self.removeActivityIndicator()
                self.performSegue(withIdentifier: "ShowScansTable", sender: nil)
            }
           
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass data between storyboards
        
        if let destinationViewController = segue.destination as? ViewController {
            destinationViewController.sdk = self.sdk
            destinationViewController.userProfile = self.userProfile
            destinationViewController.lastScanRecord = self.lastScanRecord
            destinationViewController.previewVidelUrl = self.previewVidelUrl
            destinationViewController.registerEmail = self.registerEmail
            destinationViewController.registerPassword = self.registerPassword
            destinationViewController.currentSegue = segue.identifier!
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated : Bool) {
        
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        let url = "https://api.tg3ds.com/api/v1/users/me?apikey=jpbDi9zrB1zXXpWLnMCdUm2ay3EXxz0rfeIt"
        do {
            try self.sdk?.doHttpDelete(url: url, completion: {
                data, response, error in
                
                
                
               
            })
            // Use the result
        } catch let error {
            print("error occured")
        }

        
        
        
    }
    
    
    
    @IBAction func onClick(_ sender: Any) {
       
        let email: String = accountInput.text ?? ""
        let password: String = passwordInput.text ?? ""
        self.signinButton.isEnabled = false
        DispatchQueue.main.async {
            self.sdk!.signin(username: email,
                             password: password) { (rc) in
                print(String(format: "signin(), rc = %d", rc))
                if rc == 0 {
                   
                    self.sdk!.getUserProfile() { (rc, userProfile) in
                        
                        
                        self.userProfile = userProfile
                        GlobalUserData.userProfile = userProfile!
                        print("user profile in sign in \(self.userProfile == nil)")
                        self.sdk!.listScanRecords(offset: 0, limit: 3) { (rc, total, records) in
                            print(String(format: "listScanRecords(), rc = %d", rc))
                            if records.count > 0 {
                                self.lastScanRecord = records[0]
                                GlobalUserData.lastScanRecord = self.lastScanRecord!
                            }
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "showProfilePage", sender: self)
                                self.signinButton.isEnabled = true
                            }
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                       
                        let alertController = UIAlertController(title: "Failed to login",
                                                                message: String(format: "Error code: %d", rc),
                                                                preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        self.signinButton.isEnabled = true
                    }
                }
            }
        }
    }
    
    @IBAction func nextBtnOnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "showScanPage", sender: self)
    }
    
    @IBAction func scanButtonOnClick(_ sender: Any) {
        if self.isScanning == false {
            var countdown = 3;
            var scanCountdown = 10;
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                
                if countdown > 0 {
                    self.startScanButton.setTitle(String(format: "%d", countdown), for: .normal)
                    countdown -= 1
                } else {
                    if scanCountdown == 10 {
                        self.sdk!.startRecordingBody()
                        DispatchQueue.main.async {
                            self.isScanning = true
                        }
                    }
                    if scanCountdown > 0 {
                        self.startScanButton.setTitle(String(format:"Stop(%d)", scanCountdown), for: .normal)
                        scanCountdown -= 1
                    } else {
                        timer.invalidate() // stop timer
                        DispatchQueue.main.async {
                            self.isScanning = false
                            self.sdk!.stopRecording() { (rc, url) in
                                if rc == 0 {
                                  print(String(format: "stopRecording, rc = %d, url: %@", rc, url!.absoluteString))
                                    self.previewVidelUrl = url!
                                    DispatchQueue.main.async {
                                        self.performSegue(withIdentifier: "showPreviewVideo", sender: self)
                                    }
                                } else {
                                    print(String(format: "stopRecording, rc = %d", rc))
                                    DispatchQueue.main.async {
                                        let alertController = UIAlertController(title: String(format: "Error code: %d", rc),
                                                                                message: "Scan failed, please check the error code.",
                                                                                preferredStyle: .alert)
                                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        
                                        // back to main page
                                        self.startScanButton.setTitle("Start", for: .normal)
                                        self.startScanButton.isEnabled = true
                                        self.performSegue(withIdentifier: "backMainPage", sender: self)
                                    }
                                }
                            }
                        }
                    }
                }
            } // timer
            
        } else {
            DispatchQueue.main.async {
                self.isScanning = false
                self.startScanButton.setTitle("Uploading", for: .normal)
                self.startScanButton.isEnabled = false
                
                self.sdk!.stopRecording() { (rc, url) in
                    if rc == 0 {
                        print(String(format: "stopRecording, rc = %d, url: %@", rc, url!.absoluteString))
                        self.previewVidelUrl = url!
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showPreviewVideo", sender: self)
                        }
                    } else {
                        print(String(format: "stopRecording, rc = %d", rc))
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: String(format: "Error code: %d", rc),
                                                                    message: "Scan failed, please check the error code.",
                                                                    preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            // back to main page
                            self.startScanButton.setTitle("Start", for: .normal)
                            self.startScanButton.isEnabled = true
                            self.performSegue(withIdentifier: "backMainPage", sender: self)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func startUploadOnClick(_ sender: Any) {
        self.uploadButton.setTitle("Uploading", for: .normal)
        self.uploadButton.isEnabled = false
        self.sdk!.uploadScans(progress: { (progress, totalSize) in
            print(String(format: "progress: %f (total: %d)", progress, totalSize))
        }, completion: { (rc, _) in
            print("uploadScans completed, rc = %d", rc)
            DispatchQueue.main.async {
                self.uploadButton.setTitle("Upload", for: .normal)
                self.uploadButton.isEnabled = true
                self.performSegue(withIdentifier: "showUploadFinishedPage", sender: self)
            }
        })
    }
    
    @IBAction func backToMainPageOnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "finishedAndBackMainPage", sender: self)
    }
    
    @IBAction func goRegisterOnClick(_ sender: Any) {
        let username: String = accountInput.text ?? ""
        let password: String = passwordInput.text ?? ""
       
        if username.count == 0 {
            let alertController = UIAlertController(title: "Username can not be null",
                                                    message: "Please input email to register account.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        // /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        let emailCheckingRegex = try! NSRegularExpression(pattern: "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$")
        if emailCheckingRegex.firstMatch(in: username, options: [], range: NSRange(location: 0, length: username.count)) == nil {
            let alertController = UIAlertController(title: "Username is not an email",
                                                    message: "Please check the format.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if password.count < 6 {
            let alertController = UIAlertController(title: "Password is too short",
                                                    message: "Please input password at least 6 characters.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        self.sdk!.checkAccount(username: username) { (rc, available) in
            DispatchQueue.main.async {
                if rc < 0 {
                    let alertController = UIAlertController(title: String(format: "Error code: %d", rc),
                                                            message: "Failed to check account",
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                if !available {
                    let alertController = UIAlertController(title: "Account had been used",
                                                            message: "Please try another account.",
                                                            preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                self.registerEmail = username
                self.registerPassword = password
                self.performSegue(withIdentifier: "showRegisterPage", sender: self)
            }
        }
    }
    
    @IBAction func registerOnClick(_ sender: Any) {
        let email: String = self.registerEmail
        let password: String = self.reviewPasswordInput.text ?? ""
        let name: String = self.usernameInput.text ?? ""
        let height: Int = Int(self.heightInput.text ?? "0") ?? 0
        let weight: String = weightInput.text ?? ""
        let gender: String = genderLabel.text ?? ""
        if password.count < 6 {
            let alertController = UIAlertController(title: "Password is too short",
                                                    message: "Please input password at least 6 characters.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if height < 120 || height > 250 {
            let alertController = UIAlertController(title: "Invalid user height",
                                                    message: "Please input user height in cm between 120 ~ 250.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if weight.isEmpty  {
            let alertController = UIAlertController(title: "No Weight Given",
                                                    message: "Please input your weightt in kg between 30 ~ 450.",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if let weightInt = Int(weight){
            if weightInt < 30 || weightInt > 450{
                let alertController = UIAlertController(title: "Invalid Weight",
                                                        message: "Please input your weightt in kg between 30 ~ 450.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
        }
        if gender.isEmpty{
           
                let alertController = UIAlertController(title: "No Gender Chosen",
                                                        message: "Please choose a gender",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            
            
        }
        
        self.registerButton.isEnabled = false
        
        // register => signin => update user profile
        self.sdk!.registerByEmail(email: email, password: password) { (rc, username) in
            if rc < 0 {
                let alertController = UIAlertController(title: String(format: "Error code: %d", rc),
                                                        message: "Failed to register account",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.registerButton.isEnabled = true
                return
            }
            self.sdk!.signin(username: email,
                             password: password) { (rc) in
                print(String(format: "signin(), rc = %d", rc))
                if rc == 0 {
                    
                    self.userProfile = UserProfile()
                    self.userProfile!.name = name
                    self.userProfile!.height = height
                    if let weightInInt = Int(weight){
                        self.userProfile!.weight = weightInInt
                    }
                    if self.gender == "MALE"{
                        self.userProfile!.gender = 1
                    }
                    else if self.gender == "FEMALE"{
                        self.userProfile!.gender = 2
                        
                    }
                    print("user profile in inner most \(self.userProfile)")
                    GlobalUserData.userProfile = self.userProfile!
                        
                    self.sdk!.updateUserProfile(profile: self.userProfile!) { (rc) in
                        print(String(format: "updateUserProfile(), rc = %d", rc))
                        DispatchQueue.main.async {
                            self.registerButton.isEnabled = true
                            self.performSegue(withIdentifier: "showProfilePageFromReg", sender: self)
                        }
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Failed to login",
                                                                message: String(format: "Error code: %d", rc),
                                                                preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        self.performSegue(withIdentifier: "backToLoginPage", sender: self)
                        self.registerButton.isEnabled = true
                    }
                }
            }
        }
    }
    func displayVideo(){
        let label = DWAnimatedLabel(frame: CGRect(x: 8, y: 44, width: UIScreen.main.bounds.size.width, height: 100))
        label.textColor = .black
        label.animationType = .shine
        
        
        
        label.font = UIFont(name:"GaramondLight-Italic",size:20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Your Scan has been completed and building on cloud.Please wait several minutes and refresh the scan result."
       
            
       
       
        
        
       
        
       
        
             //   let mainBundle = Bundle.main
                
           

              

              let videoName = "photographer"

              let videoPath = Bundle.main.path(forResource: videoName, ofType: "mp4")
               let videoUrl = URL(fileURLWithPath:videoPath!)
              smallVideoPlayerViewController.showsPlaybackControls = false
              print("small video player \(smallVideoPlayerViewController == nil)")
              let avPlayer = AVPlayer(url: videoUrl)
              
              smallVideoPlayerViewController.player = avPlayer

              
              smallVideoPlayerViewController.contentOverlayView?.addSubview(label)
             
               label.startAnimation(duration: 8, nil)
        smallVideoPlayerViewController.view.frame = self.view.bounds
        self.view.addSubview(smallVideoPlayerViewController.view)
        self.addChild(smallVideoPlayerViewController)
        smallVideoPlayerViewController.didMove(toParent: self)
        smallVideoPlayerViewController.player?.play()
    }

   
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}
