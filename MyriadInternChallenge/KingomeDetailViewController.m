//
//  KingomeDetailViewController.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/15/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "KingomeDetailViewController.h"
#import "Mantle.h"
#import "AFHTTPRequestOperationManager.h"
#import "Kingdom.h"
#import "QuestTableViewCell.h"


@interface KingomeDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *populationLabel;
@property (strong, nonatomic) IBOutlet UILabel *climateLabel;
@property (strong, nonatomic)  __block Kingdom * kingdom;
@property (weak, nonatomic) IBOutlet UITableView *questTableView;
@property (strong, nonatomic) IBOutlet UIImageView *kindomImageView;

@end

@implementation KingomeDetailViewController

- (void)viewDidLoad {

  
    [self.climateLabel sizeToFit];
    [super viewDidLoad];
  self.questTableView.layer.borderWidth = 10.0;


    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"https://challenge2015.myriadapps.com/api/v1/kingdoms/%zd",self.selectedKingdomeID]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary * tempDictionary = (NSDictionary *)responseObject;
        
        NSError * error;
        
        //convert json to kindomModel type
        self.kingdom = [MTLJSONAdapter modelOfClass:Kingdom.class fromJSONDictionary:tempDictionary error:&error];
        self.populationLabel.text = [NSString stringWithFormat:@"%lu",(long)[self.kingdom population]];
        self.climateLabel.text = [self.kingdom climate];
      
      NSURL* url = [NSURL URLWithString:[self.kingdom imageString]];
      NSURLRequest* request = [NSURLRequest requestWithURL:url];
      
        //download image
      [NSURLConnection sendAsynchronousRequest:request
                                         queue:[NSOperationQueue mainQueue]
                             completionHandler:^(NSURLResponse * response,
                                                 NSData * data,
                                                 NSError * error) {
                               if (!error){
                                 UIImage* image = [[UIImage alloc] initWithData:data];
                                 self.kindomImageView.image = image;
                               }
                               
                             }];
      

      self.navigationItem.title = [self.kingdom name];

      
        [self.questTableView reloadData];


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured!." message:@"An error occured while trying to retrieve information. Please Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alertView show];
      
      
    }];
    
    
    
    // Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSURL* url = nil;
  NSURLRequest* request = nil;
  
  
  QuestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"questCell" forIndexPath:indexPath];
  cell.giverImageView.layer.cornerRadius = cell.giverImageView.frame.size.width / 2;
  cell.giverImageView.clipsToBounds = YES;
  
  Quest * quest = [MTLJSONAdapter modelOfClass:Quest.class fromJSONDictionary:[[self.kingdom quest] objectAtIndex:indexPath.row] error:NULL];

  cell.giverLabelview.text = [[quest giver] name];

  
    // if no description use placeholder.
  if ([[quest questDescription] isEqualToString:@""]) {
    cell.descriptionLabelView.text = @"No Description Available";

  }
  else{
  cell.descriptionLabelView.text = [quest questDescription];
  }
  cell.questNameLabelView.text = [quest name];
  
  
    // if no quest image use placeholder
  if ([[quest questImageString] isEqualToString:@""]) {
    cell.noQuestImagelabel.hidden = NO;
  }else{
    
      //download image
     url = [NSURL URLWithString:[quest questImageString] ];
    request = [NSURLRequest requestWithURL:url];

    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                             if (!error){
                               UIImage * image = [[UIImage alloc] initWithData:data];
                               cell.questImageView.image = image;
                             }
                             
                           }];

    cell.noQuestImagelabel.hidden = YES;
  }
	
  
 
  url = [NSURL URLWithString:[[quest giver] image]];
  request = [NSURLRequest requestWithURL:url];

  [NSURLConnection sendAsynchronousRequest:request
                                     queue:[NSOperationQueue mainQueue]
                         completionHandler:^(NSURLResponse * response,
                                             NSData * data,
                                             NSError * error) {
                           if (!error){
                             UIImage * image = [[UIImage alloc] initWithData:data];
                               // do whatever you want with image
                             cell.giverImageView.image = image;
                             
                           }
                           
                         }];
  

    
    return cell;

}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

  return [[self.kingdom quest]count];

}


@end
