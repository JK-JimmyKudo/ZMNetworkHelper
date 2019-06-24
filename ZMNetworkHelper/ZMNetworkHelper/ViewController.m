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
#import "WYFileModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    NSString *url = @"http://10.1.236.163:8080/bchz-web-server/app/IcAdChannelInfo/appIndexPosition";
    
    NSDictionary *dic = @{
                          @"city":@"北京市"
                          };
    
    [[ZMNetworkHelper sharedInstance] requestPOSTWithRequestURL:url parameters:dic success:^(id responseObject) {
        
//        NSLog(@"responseObject ==  %@",responseObject);
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", @"http://10.1.236.163:8080/bchz-web-server", @"/app/IcUserInfo/uploadImgFile"];
    
    UIImage *image = [UIImage imageNamed:@"pic_zwwl"];
    NSData *fileData = UIImageJPEGRepresentation(image, 0.05);

    WYFileModel *model = [[WYFileModel alloc] init];
    model.fileName = @"picture";
    model.fileData = fileData;
    model.fileImage = image;
    model.mimeType = @"image/jpeg";
    model.folderName = @"BeiChen.jpg";
    
    
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    [[ZMNetworkHelper sharedInstance]requestPOSTWithRequestURL:requestURL parameters:par fileModel:model progress:^(NSProgress * _Nullable progress) {
        
    } success:^(id  _Nullable responseObject) {
       
        NSLog(@"responseObject ==  %@",responseObject);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
    
    
    
    // Do any additional setup after loading the view.
}


@end
