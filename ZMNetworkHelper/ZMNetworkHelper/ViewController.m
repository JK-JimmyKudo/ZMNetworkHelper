//
//  ViewController.m
//  ZMNetworkHelper
//
//  Created by power on 2019/6/18.
//  Copyright © 2019 Henan XinKangqiao. All rights reserved.
//

#import "ViewController.h"
#import "ZYNetworkHelper.h"
#import "ZMNetworkHelper-Swift.h"
#import "WYFileModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    HHHViewController *hh = [[HHHViewController alloc] init];
    [self.view addSubview:hh.view];
    
    
    NSDictionary *dic = @{@"city":@"北京市",
                          @"cityCode":@"110100",
                          @"pageIndex":[NSString stringWithFormat:@"%@",@"0"],
                          @"pageSize":@"10"};
    
    NSString *url = @"http://10.1.236.163:8080/bchz-web-server/app/IcAdChannelInfo/appIndexInfo";
    

    
    [[ZYNetworkHelper sharedInstance] requestPOSTWithRequestURL:url parameters:dic success:^(id responseObject) {
        
//        NSLog(@"responseObject ==  %@",responseObject);
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
//    NSString *requestURL = [NSString stringWithFormat:@"%@%@", @"http://10.1.236.163:8080/bchz-web-server", @"/app/IcUserInfo/uploadImgFile"];
//
//    UIImage *image = [UIImage imageNamed:@"pic_zwwl"];
//    NSData *fileData = UIImageJPEGRepresentation(image, 0.05);
//
//    WYFileModel *model = [[WYFileModel alloc] init];
//    model.fileName = @"picture";
//    model.fileData = fileData;
//    model.fileImage = image;
//    model.mimeType = @"image/jpeg";
//    model.folderName = @"BeiChen.jpg";
//
//
//
//    NSMutableDictionary *par = [NSMutableDictionary dictionary];
//    [[ZMNetworkHelper sharedInstance]requestPOSTWithRequestURL:requestURL parameters:par fileModel:model progress:^(NSProgress * _Nullable progress) {
//
//    } success:^(id  _Nullable responseObject) {
//
//        NSLog(@"responseObject ==  %@",responseObject);
//
//    } failure:^(NSError * _Nullable error) {
//
//    }];
//
    
    
    
    
    // Do any additional setup after loading the view.
    
    /**
     *  题目1：给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那两个整数，并返回他们的数组下标。
     *  你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素
     *  注：此解决方法有问题，会申请大量内存，优化方向为动态hash表即官方解法。
     *  e.g: 给定 nums = [], target = 9
     *       因为 nums[0] + nums[1] = 2 + 7 = 9
     *       所以返回 [0, 1]
     * @param nums
     * @param target
     * @return
     */
    

//    NSArray *nums = @[@"2", @"7", @"11", @"15"];
//    int target = 9+9;
//    
//    int min = 0;
//    int max = 0;
//    int index = 0;
//    for (int i = 0; i < nums.count; i++) {
//        
//        min = [nums[i] intValue];
//        
//        if ((min + max) == target) {
//            NSLog(@" ==  %d == %ld",index,(long)i);
//            break;
//        }else{
//            max = min;
//            index = i;
//            NSLog(@"=== %d === %d",max,min);
//        }
//    }
    
    
    
}


@end
