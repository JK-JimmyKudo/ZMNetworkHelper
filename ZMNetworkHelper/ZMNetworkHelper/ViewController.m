//
//  ViewController.m
//  ZMNetworkHelper
//
//  Created by power on 2019/6/18.
//  Copyright © 2019 Henan XinKangqiao. All rights reserved.
//

#import "ViewController.h"
#import "YHNetworkHelper.h"
#import "ZMNetworkHelper-Swift.h"
#import "WYFileModel.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,strong) UIButton *getBtn;
@property (nonatomic,strong) UIButton *postBtn;
@property (nonatomic,strong) UIButton *postImageBtn;
@property (nonatomic,strong) UIButton *postDownloadBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.getBtn = [[UIButton alloc] init];
    [self.getBtn setTitle:@"get请求" forState:UIControlStateNormal];
    self.getBtn.backgroundColor = [UIColor redColor];
    [self.getBtn addTarget:self action:@selector(GetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getBtn];
    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(100);
    }];
    
    
    self.postBtn = [[UIButton alloc] init];
    [self.postBtn setTitle:@"post请求" forState:UIControlStateNormal];
    [self.postBtn addTarget:self action:@selector(PostBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.postBtn.backgroundColor = [UIColor blueColor];

    [self.view addSubview:self.postBtn];
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.getBtn.mas_bottom).offset(10);
    }];
    
    
    self.postImageBtn = [[UIButton alloc] init];
    [self.postImageBtn setTitle:@"上传图片请求" forState:UIControlStateNormal];
    [self.postImageBtn addTarget:self action:@selector(PostImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.postImageBtn.backgroundColor = [UIColor yellowColor];

    [self.view addSubview:self.postImageBtn];
    [self.postImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.postBtn.mas_bottom).offset(10);
    }];
    
    
    
    self.postDownloadBtn = [[UIButton alloc] init];
    [self.postDownloadBtn setTitle:@"下载请求" forState:UIControlStateNormal];
    [self.postDownloadBtn addTarget:self action:@selector(PostDownloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.postDownloadBtn.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:self.postDownloadBtn];
    [self.postDownloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.postImageBtn.mas_bottom).offset(10);
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
    
}

-(void)GetBtnClick:(UIButton *)getBtn{
    
    
    
}

-(void)PostBtnClick:(UIButton *)postBtn{
    NSDictionary *dic = @{@"city":@"北京市",
                          @"cityCode":@"110100",
                          @"pageIndex":[NSString stringWithFormat:@"%@",@"0"],
                          @"pageSize":@"10"};
    
    NSString *url = @"http://10.1.236.163:8080/bchz-web-server/app/IcAdChannelInfo/appIndexInfo";
    
    [YHNetworkHelper  requestPOSTWithRequestURL:url parameters:dic success:^(id responseObject) {
    
        
        NSLog(@" ===  responseObject ==  %@",responseObject);
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)PostImageBtnClick:(UIButton *)postImageBtn{
    
}

-(void)PostDownloadBtnClick:(UIButton *)postDownloadBtn{
    
}


@end
