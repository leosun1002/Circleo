//
//  ScanViewController.m
//  boao
//
//  Created by 孙亮 on 2018/5/23.
//  Copyright © 2018年 yunzhuan. All rights reserved.
//

#import "ScanViewController.h"
#import "XYMScanView.h"
#import "TZImagePickerController.h"

@interface ScanViewController ()<XYMScanViewDelegate,TZImagePickerControllerDelegate>

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUi];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)loadUi{
    XYMScanView *scan = [[XYMScanView alloc] initWithFrame:CGRectMake(0, 0, ksrcwidth, ksrcheight)];
    scan.delegate = self;
    [self.view addSubview:scan];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ksrcwidth/2 - 50, IS_IPHONEX?48:28, 100, 26)];
    label.text = NSLocalizedString(@"扫一扫", nil);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    [scan addSubview:label];
    
    UIButton* btn=[[UIButton alloc] initWithFrame:CGRectMake(10,CGRectGetMidY(label.frame) - 15 , 30, 30)];
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"Back_white"] forState:UIControlStateNormal];
    [scan addSubview:btn];
    
    UIButton* albumBtn=[[UIButton alloc] initWithFrame:CGRectMake(ksrcwidth - 75,CGRectGetMidY(label.frame) - 15 , 60, 30)];
    albumBtn.backgroundColor=[UIColor clearColor];
    [albumBtn setTitle:NSLocalizedString(@"相册", nil) forState:UIControlStateNormal];
    [albumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    albumBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [albumBtn addTarget:self action:@selector(albumClick:) forControlEvents:UIControlEventTouchUpInside];
    [albumBtn setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [scan addSubview:albumBtn];
    
}

#pragma -mark XYMScanViewDelegate
-(void)getScanDataString:(NSString *)scanDataString{
    [self dealWithData:scanDataString];
}

-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)albumClick:(UIButton *)btn{
    TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    pickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    WeakSelf(self);
    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *assets, BOOL isSelectOriginalPhoto){
        //        NSLog(@"%@",photo);
        UIImage *image = photo[0];
        // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
        // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
          // 取得识别结果
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        NSString *resultStr;
        if (features.count == 0) {
            [self showMsg:NSLocalizedString(@"暂未识别出二维码", nil) location:centre];
        }else{
            for (int index = 0; index < [features count]; index ++) {
                CIQRCodeFeature *feature = [features objectAtIndex:index];
                resultStr = feature.messageString;
            }
            [weakself dealWithData:resultStr];

        }
    }];
    [self presentViewController:pickerController animated:YES completion:nil];
}

-(void)dealWithData:(NSString *)dataStr{
    if (self.type == 1) {
        [self askForData:dataStr];
        return;
    }
    !self.scanBlock?:self.scanBlock(dataStr);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)askForData:(NSString *)dataStr{
    UIAlertController*   sheetVC=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"确认查看区块链数据？", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    WeakSelf(self);
    UIAlertAction*  sheetBtn1=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    UIAlertAction*  sheetBtn=[UIAlertAction actionWithTitle:NSLocalizedString(@"查看", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !weakself.scanBlock?:weakself.scanBlock(dataStr);
        [weakself dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    [sheetVC addAction:sheetBtn1];
    [sheetBtn1 setValue:[UIColor colorWithRGBHex:@"#323236"] forKey:@"titleTextColor"];
    [sheetVC addAction:sheetBtn];
    [sheetBtn setValue:[UIColor colorWithRGBHex:@"#323236"] forKey:@"titleTextColor"];
    [self presentViewController:sheetVC animated:YES completion:nil];
}
@end
