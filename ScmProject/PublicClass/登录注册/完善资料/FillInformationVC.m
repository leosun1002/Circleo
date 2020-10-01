//
//  FillInformationVC.m
//  ScmProject
//
//  Created by leosun on 2020/9/29.
//  Copyright © 2020 session. All rights reserved.
//

#import "FillInformationVC.h"
#import <BRPickerView.h>
#import "ZWTagListView.h"

@interface FillInformationVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *generText;

@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (nonatomic, copy) NSArray <NSNumber *> *linkage2SelectIndexs;

@property (assign, nonatomic) NSInteger generIndex;
@property (weak, nonatomic) IBOutlet UIView *tagBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagHeight;

@property(nonatomic,strong)ZWTagListView *tagView;
@end

@implementation FillInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tagBgView addSubview:self.tagView];
    [self.tagView setTagWithTagArray:@[@"休闲娱乐",@"旅游摄影",@"美食",@"居家",@"宠物",@"话剧音乐剧",@"运动健身",@"生活分享",@"音乐乐器"]];
    self.tagHeight.constant = self.tagView.height;
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    WeakSelf(self);
    if (textField == self.dateText) {
        [BRDatePickerView showDatePickerWithMode:(BRDatePickerModeDate) title:NSLocalizedString(@"出生日期", nil) selectValue:self.dateText.text resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            weakself.dateText.text = selectValue;
        }];
        return NO;
    }else if (textField == self.generText){
        [BRStringPickerView showPickerWithTitle:NSLocalizedString(@"性别", nil) dataSourceArr:@[NSLocalizedString(@"男", nil),NSLocalizedString(@"女", nil)] selectIndex:self.generIndex resultBlock:^(BRResultModel * _Nullable resultModel) {
            weakself.generIndex = resultModel.index;
            weakself.generText.text = resultModel.value;
        }];
        return NO;
    }else if (textField == self.addressText){
        BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
        stringPickerView.pickerMode = BRStringPickerComponentLinkage;
        stringPickerView.title = NSLocalizedString(@"所在地区", nil);
        stringPickerView.dataSourceArr = [self getLinkag2DataSource];
        stringPickerView.selectIndexs = self.linkage2SelectIndexs;
        stringPickerView.isAutoSelect = YES;
        stringPickerView.resultModelArrayBlock = ^(NSArray<BRResultModel *> *resultModelArr) {
            // 1.选择的索引
            NSMutableArray *selectIndexs = [[NSMutableArray alloc]init];
            // 2.选择的值
            NSString *selectValue = @"";
            for (BRResultModel *model in resultModelArr) {
                [selectIndexs addObject:@(model.index)];
                selectValue = [NSString stringWithFormat:@"%@ %@", selectValue, model.value];
            }
            if ([selectValue hasPrefix:@" "]) {
                selectValue = [selectValue substringFromIndex:1];
            }
            self.linkage2SelectIndexs = selectIndexs;
            textField.text = selectValue;
        };
        [stringPickerView show];

        return NO;
    }
    return YES;
}

- (NSArray <BRResultModel *>*)getLinkag2DataSource {
    // 获取本地数据源
    NSMutableArray *listModelArr = [[NSMutableArray alloc]init];

    BRResultModel *model = [[BRResultModel alloc]init];
    model.parentKey = @"-1";
    model.parentValue = @"";
    model.key = @"1";
    model.value = @"文";
    [listModelArr addObject:model];
    
    BRResultModel *model1 = [[BRResultModel alloc]init];
    model1.parentKey = @"1";
    model1.parentValue = @"文";
    model1.key = @"2";
    model1.value = @"语文";
    [listModelArr addObject:model1];
    
    BRResultModel *model2 = [[BRResultModel alloc]init];
    model2.parentKey = @"1";
    model2.parentValue = @"文";
    model2.key = @"3";
    model2.value = @"数学";
    [listModelArr addObject:model2];
    
    BRResultModel *model3 = [[BRResultModel alloc]init];
    model3.parentKey = @"-1";
    model3.parentValue = @"";
    model3.key = @"10";
    model3.value = @"体";
    [listModelArr addObject:model3];
    
    BRResultModel *model4 = [[BRResultModel alloc]init];
    model4.parentKey = @"10";
    model4.parentValue = @"体";
    model4.key = @"11";
    model4.value = @"体育1";
    [listModelArr addObject:model4];
    
    BRResultModel *model5 = [[BRResultModel alloc]init];
    model5.parentKey = @"10";
    model5.parentValue = @"体";
    model5.key = @"12";
    model5.value = @"体育2";
    [listModelArr addObject:model5];
    

    return [listModelArr copy];
}

#pragma -mark getter
-(ZWTagListView *)tagView{
    if (!_tagView) {
        _tagView = [[ZWTagListView alloc]initWithFrame:CGRectMake(0, 0, self.tagBgView.width, 100)];
        _tagView.signalTagColor = [UIColor colorWithRGBHex:@"#F7F7F9"];
        WeakSelf(self);
        _tagView.Handle = ^(UILabel *selectLabel) {
            NSLog(@"ads");
        };
    }
    return _tagView;
}
@end
