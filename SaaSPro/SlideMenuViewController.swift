//
//  SlideMenuViewController.swift
//  SaaSPro
//


import Foundation

class SlideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    
    
    var selectedMenuAction : String?
    
    let menuList = Constants.LEFT_SLIDE_MENU_TITLES
    let menuIcons = Constants.LEFT_SLIDE_MENU_ICONS
    let textCellIndefiter = "MenuCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.clearColor();
        
    }
    override func viewDidAppear(animated: Bool) {
        self.selectedMenuAction = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIndefiter, forIndexPath: indexPath) as! LeftSlideMenuCellView
        let row = indexPath.row
        cell.menuTitle.text = menuList[row]
        cell.backgroundColor = UIColor.clearColor()
        cell.menuIcon.image = UIImage(named: menuIcons[row])
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! UINavigationController
        let vc2 = vc.topViewController as! MainPageViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! LeftSlideMenuCellView
        selectedMenuAction = cell.menuTitle.text as String?
        vc2.navigateAction = selectedMenuAction
        
    }
    
}