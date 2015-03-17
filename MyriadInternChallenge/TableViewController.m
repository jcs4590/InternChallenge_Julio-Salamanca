//
//  TableViewController.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/14/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "TableViewController.h"
#import "Mantle.h"
#import "Kingdom.h"
#import "AFHTTPRequestOperationManager.h"
#import "KingdomMainTableViewCell.h"
#import "KingomeDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TableViewController  ()
@property (strong, nonatomic) __block NSMutableArray * allKingdoms;
@property (strong,nonatomic) NSUserDefaults* userData;
@property NSInteger selectedKingdomID;
@end

@implementation TableViewController



- (void)viewDidLoad {
  self.allKingdoms = [[NSMutableArray alloc] init];
  self.userData = [NSUserDefaults standardUserDefaults];
  [self.userData synchronize];

  self.tableView.separatorInset=UIEdgeInsetsZero;


    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  

  [self getandCreateKingdoms];
  
}



-(void)getandCreateKingdoms{

    //HTTP GET Request from API.
  AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager ];
  
  
  [manager GET:@"https://challenge2015.myriadapps.com/api/v1/kingdoms" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
   
    NSError * error;
    
      //convert json to kindomModel type
    for (int i = 0; i < [responseObject count]; i++) {
      NSDictionary * tempDictionary = (NSDictionary *) [responseObject objectAtIndex:i] ;
      
      Kingdom * tempKingdom = [MTLJSONAdapter modelOfClass:Kingdom.class fromJSONDictionary:tempDictionary error:&error];
        //add kingdom object to array
      [self.allKingdoms addObject:tempKingdom];
        [self.tableView reloadData];
    }

  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      //code here for unsuccesfull
    
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured!." message:@"An error occured while trying to retrieve your information. Please Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
  }];
  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  return  [self.allKingdoms count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  KingdomMainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"kingdomCell" forIndexPath:indexPath] ;
 
  
  
  NSURL* url = [NSURL URLWithString:[[self.allKingdoms objectAtIndex:indexPath.row] imageString]];
  NSURLRequest* request = [NSURLRequest requestWithURL:url];
  
  
  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse * response,
                                             NSData * data,
                                             NSError * error) {
                           if (!error){
                             UIImage * image = [[UIImage alloc] initWithData:data];
                               // do whatever you want with image
                             cell.kingdomImageView.image = image;
                           
                           }
                           
                         }];

  cell.titleLabel.text =  [[self.allKingdoms objectAtIndex:indexPath.row] name];
  
  return cell;
}



- (IBAction)backToLogIN:(id)sender {
  [self.userData removeObjectForKey:@"name"];
  [self.userData removeObjectForKey:@"email"];
  [self performSegueWithIdentifier:@"backToLogIN" sender:self];
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    
    if ([segue.identifier isEqualToString:@"toDetailView"]) {
        KingomeDetailViewController * detailViewController = segue.destinationViewController;
        
        self.selectedKingdomID = [[self.allKingdoms objectAtIndex:[self.tableView indexPathForSelectedRow].row] kingdom_ID];
        detailViewController.selectedKingdomeID = self.selectedKingdomID;
    }
}









@end
