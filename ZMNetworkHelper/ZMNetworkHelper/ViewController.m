//
//  ViewController.m
//  ZMNetworkHelper
//
//  Created by power on 2019/6/18.
//  Copyright © 2019 Henan XinKangqiao. All rights reserved.
//

#import "ViewController.h"
#import "ZMNetworkHelper.h"
#import "ZMNetworkHelper-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    NSString *url = @"http://10.1.236.163:8080/bchz-web-server/app/IcAdChannelInfo/appIndexPosition";
    
    NSDictionary *dic = @{
                          @"city":@"北京市"
                          };
    
    [ZMNetworkHelper requestPOSTWithRequestURL:url parameters:dic success:^(id responseObject) {
        NSLog(@"responseObject ==  %@",responseObject);
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}


@end
