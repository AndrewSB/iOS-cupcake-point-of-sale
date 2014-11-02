//
//  ViewController.m
//  money2020view
//
//  Created by Andrew Breckenridge on 11/1/14.
//  Copyright (c) 2014 asb. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstCounter;
@property (weak, nonatomic) IBOutlet UILabel *secondCounter;
@property (weak, nonatomic) IBOutlet UILabel *thirdCounter;
@property (weak, nonatomic) IBOutlet UILabel *totalCounter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didHitCheckout:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"user[height]": @"height",
                             @"user[weight]": @"weight"};
    [manager POST:@"https://mysite.com/myobject" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
    
- (IBAction)didHitFirst:(id)sender {
    self.firstCounter.text = [NSString stringWithFormat:@"%d", [self.firstCounter.text intValue]+1];
    self.totalCounter.text = [NSString stringWithFormat:@"%.02f", [self.totalCounter.text floatValue]+1.0];
}
- (IBAction)didHitSecond:(id)sender {
    self.secondCounter.text = [NSString stringWithFormat:@"%d", [self.secondCounter.text intValue]+1];
    self.totalCounter.text = [NSString stringWithFormat:@"%.02f", [self.totalCounter.text floatValue]+0.75];
}
- (IBAction)didHitFourth:(id)sender {
    self.thirdCounter.text = [NSString stringWithFormat:@"%d", [self.thirdCounter.text intValue]+1];
    self.totalCounter.text = [NSString stringWithFormat:@"%.02f", [self.totalCounter.text floatValue]+1.25];
}



@end
