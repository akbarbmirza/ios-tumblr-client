//
//  PhotosViewController.swift
//  Tumblr Client
//
//  Created by Akbar Mirza on 1/9/17.
//  Copyright © 2017 Akbar Mirza. All rights reserved.
//

import UIKit
//import Foundation // to get Swift Types to work just like NSTypes
import AFNetworking // adds setImageWithURL

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // create an outlet for our tableView
    @IBOutlet weak var tableView: UITableView!
    
    // create a variable stored property to hold the data that will be returned
    // from the network request
    var posts: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the datasource and delegate of the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        // set a static row height to the tableView
        tableView.rowHeight = 240
        
        // make our network request to load data
        // makeNetworkRequest()
        
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        // NOTE: DEBUG CODE
                        // print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        
                        // This is where you will store the returned array of posts in your posts property
                        // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.posts = responseFieldDictionary["posts"] as! [NSDictionary]
                        
                        // NOTE: DEBUG CODE
                        // print("posts: \(self.posts)")
                    }
                }
        });
        task.resume()
        
        // reload table data
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func makeNetworkRequest() {
//        // do nothing
//    }
    
    
    // sets the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of posts that we have
        // NOTE: posts.count is 0 if we didn't retrieve any data
        return posts.count
    }
    
    // sets up an individual cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // instantiate a cell to perform our operations on and cast it as a PhotoCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        
        // pull out a single post from our posts array
        let post = posts[indexPath.row]
        
        print(post)
        
        // get the photos dictionary from the post
        // NOTE: check that photos array is not nil
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary] {
            // photos is NOT nil, go ahead and access element 0
            
            // get the original size image URL
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            
            // convert the imageUrlString to a URL
            // NOTE: check that imageUrl is NOT nil
            if let imageUrl = NSURL(string: imageUrlString!) {
                // URL is NOT nil, go ahead and unwrap it and assign to imageURL
                // set the image view image in our cell
                cell.photoImageView.setImageWith(imageUrl as URL)
            } else {
                // URL is nil
            }
        } else {
            // photos is nil. Good thing we didn't try to unwrap it!
        }
        
        
        // set the text for our cell
        //        cell.textLabel?.text = "This is row\(indexPath.row)"
        // return our updated cell
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

