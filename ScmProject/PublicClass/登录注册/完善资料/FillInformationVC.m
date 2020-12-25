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
#import "MineChangeNickNameVC.h"
#import "MineChangeIDVC.h"
#import "MineChangeIntroVC.h"
#import "HobbyModel.h"

@interface FillInformationVC ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *generText;

@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (nonatomic, copy) NSArray <NSNumber *> *linkage2SelectIndexs;

@property (weak, nonatomic) IBOutlet UIView *tagBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagHeight;
@property (weak, nonatomic) IBOutlet UITextField *nickText;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *introText;

@property(nonatomic,strong)ZWTagListView *tagView;
@property(nonatomic,strong)NSMutableArray* hobbyDatas;
@property(nonatomic,strong)NSMutableArray* hobbyStrArray;
@property(nonatomic,strong)NSMutableArray* areaDatas;
@property(nonatomic,strong)NSString* headUrl;

@property (weak, nonatomic) IBOutlet UIView *nickRed;
@property (weak, nonatomic) IBOutlet UIView *mailRed;
@property (weak, nonatomic) IBOutlet UIView *hobbyRed;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mailLead;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hobbyLead;
@property (weak, nonatomic) IBOutlet UIView *idView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *idHeight;

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property (strong, nonatomic) UserModel *userModel;

@end

@implementation FillInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preapreUi];
    [self loadHobbyData];
    [self getUserInfo];
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)preapreUi{
    [self.tagBgView addSubview:self.tagView];
    if(self.fillType == FillInformationMine){
        self.nickRed.hidden = YES;
        self.mailRed.hidden = YES;
        self.hobbyRed.hidden = YES;
        self.nickLead.constant = 10;
        self.mailLead.constant = 10;
        self.hobbyLead.constant = 10;
    }else{
        self.idView.hidden = YES;
        self.descView.hidden = YES;
        self.idHeight.constant = 0;
        self.descHeight.constant = 0;
    }
}

-(void)setData{
    self.headUrl = AssectString(self.userModel.photo);
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.headUrl] forState:(UIControlStateNormal)];
    self.nickText.text = AssectString(self.userModel.name);
    self.generText.text = [AssectString(self.userModel.sex) isEqualToString:@""]?@"":([AssectString(self.userModel.sex) isEqualToString:@"1"]?NSLocalizedString(@"男", nil):NSLocalizedString(@"女", nil));
    self.dateText.text = AssectString(self.userModel.birthday);
    self.emailText.text = AssectString(self.userModel.postcode);
    self.addressText.text = [NSString stringWithFormat:@"%@ %@",AssectString(self.userModel.regionName),AssectString(self.userModel.cityName)];
    [self checkBtnEnable];
}

- (IBAction)imageClick:(id)sender {
    UIAlertController*   sheetVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    WeakSelf(self);
    UIAlertAction*  sheetBtn1=[UIAlertAction actionWithTitle:NSLocalizedString(@"拍照上传",nil)  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
            pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerVC.allowsEditing = YES;
            pickerVC.delegate = weakself;
            [weakself  presentViewController:pickerVC animated:YES completion:nil];
        }else{
            [weakself showMsg:NSLocalizedString(@"相机不可用",nil) location:centre];
        }
    }];
    UIAlertAction*  sheetBtn2=[UIAlertAction actionWithTitle:NSLocalizedString(@"手机相册",nil)  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *pickerVC1 = [[UIImagePickerController alloc] init];
        pickerVC1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC1.allowsEditing = YES;
        pickerVC1.delegate = weakself;
        pickerVC1.navigationBar.translucent = NO;
        pickerVC1.modalPresentationStyle = UIModalPresentationFullScreen;
        [weakself presentViewController:pickerVC1 animated:YES completion:nil];
    }];
    UIAlertAction*  sheetBtn=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil)  style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheetVC addAction:sheetBtn1];
    [sheetVC addAction:sheetBtn2];
    [sheetVC addAction:sheetBtn];
    [self presentViewController:sheetVC animated:YES completion:nil];
}

//choose 阿牛被点击
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //Nslog(@"[^"]*[u4E00-u9FA5]+[^"n]*?");
    UIImage*   image=[info objectForKey:UIImagePickerControllerEditedImage];
    //压缩图片
    UIImage *newImg =[self compressImage:image toTargetWidth:120.0];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self uploadImage:newImg];
}

- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    NSLog(@"%@",sourceImage); 
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma -mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    WeakSelf(self);
    if (textField == self.dateText) {
        [BRDatePickerView showDatePickerWithMode:(BRDatePickerModeDate) title:NSLocalizedString(@"出生日期", nil) selectValue:[AssectString(self.dateText.text) containsString:@"-"]?AssectString(self.dateText.text):@""  resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
            weakself.dateText.text = selectValue;
        }];
        return NO;
    }else if (textField == self.generText){
        [BRStringPickerView showPickerWithTitle:NSLocalizedString(@"性别", nil) dataSourceArr:@[NSLocalizedString(@"男", nil),NSLocalizedString(@"女", nil)] selectIndex:[AssectString(self.generText.text) isEqualToString:@"女"]?1:0 resultBlock:^(BRResultModel * _Nullable resultModel) {
            weakself.generText.text = resultModel.value;
        }];
        return NO;
    }else if (textField == self.addressText){
        [self getAreaData];
        return NO;
    }else if (textField == self.nickText || textField == self.emailText){
        MineChangeNickNameVC *changeNick = [[MineChangeNickNameVC alloc] init];
        changeNick.titleStr = textField == self.emailText ? @"邮编":@"昵称";
        changeNick.content = textField.text;
        changeNick.subject = [RACSubject subject];
        [changeNick.subject subscribeNext:^(NSString *name) {
            textField.text = name;
            [weakself checkBtnEnable];
        }];
        [self.navigationController pushViewController:changeNick animated:YES];
        return NO;
    }else if (textField == self.idText){
        MineChangeIDVC *changeId = [[MineChangeIDVC alloc] init];
        [self.navigationController pushViewController:changeId animated:YES];
        return NO;
    }else if (textField == self.introText){
        MineChangeIntroVC *intro = [[MineChangeIntroVC alloc] init];
        [self.navigationController pushViewController:intro animated:YES];
        return NO;
    }
    return YES;
}

-(void)loadHobbyData{
    WeakSelf(self);
    [WebServices postWithUrl:@"setting/gettags/" body:@{} loadingTime:15.f showLoading:NO success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            weakself.hobbyDatas = [HobbyModel mj_objectArrayWithKeyValuesArray:result[@"resultData"]];
            [weakself setHobbyView];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)getUserInfo{
    WeakSelf(self);
    UserModel *model = [Manager takeoutUserTokenkey:Loginuser];
    [WebServices postWithUrl:@"user/userInfo/" body:@{@"userId":AssectString(model.userId)} loadingTime:15.f showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            weakself.userModel = [UserModel mj_objectWithKeyValues:result[resultData]];
            [weakself setData];
            [weakself setHobbyView];

        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)setHobbyView{
    if (self.hobbyDatas.count == 0 || self.userModel.tagsList.count == 0)return;
    [self.hobbyStrArray removeAllObjects];
    for (NSDictionary *dict in self.userModel.tagsList) {
        [self.hobbyStrArray addObject:AssectString(dict[@"id"])];
    }
    for (HobbyModel *model in self.hobbyDatas) {
        if ([self.hobbyStrArray containsObject:AssectString(model.name)]) {
            model.ifSelect = YES;
        }
    }
    [self.tagView setTagWithTagArray:self.hobbyDatas];
    self.tagHeight.constant = self.tagView.height;
    [self checkBtnEnable];
}

-(void)uploadImage:(UIImage *)image{
    WeakSelf(self);
    [WebServices postImageFormReqUrl:@"upload/file" image:image param:@{} loadingTime:30.f callbackBlock:^(id result, NSInteger startCode, NSString *error) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            NSString *subUrl = AssectString(result[resultData][@"fileUrl"]);
            weakself.headUrl = [NSString stringWithFormat:@"%@%@",photoIp,subUrl];
            [weakself.iconBtn sd_setImageWithURL:[NSURL URLWithString:weakself.headUrl] forState:(UIControlStateNormal)];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    }];
}

-(void)getAreaData{
    WeakSelf(self);
    [WebServices postWithUrl:@"setting/area/" body:@{} loadingTime:15.f showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself.areaDatas removeAllObjects];
            NSArray *parentData = result[resultData];
            for (NSDictionary *parrentDict in parentData) {
                BRResultModel *model = [[BRResultModel alloc]init];
                model.parentKey = AssectString(parrentDict[@"parentId"]);
                model.parentValue = @"";
                model.key = AssectString(parrentDict[@"id"]);
                model.value = AssectString(parrentDict[@"name"]);
                model.remark = AssectString(parrentDict[@"englishName"]);
                [weakself.areaDatas addObject:model];
                NSArray *childData = parrentDict[@"sonResponseArea"];
                for (NSDictionary *childDict in childData) {
                    BRResultModel *childModel = [[BRResultModel alloc]init];
                    childModel.parentKey = AssectString(childDict[@"parentId"]);
                    childModel.parentValue = AssectString(parrentDict[@"name"]);
                    childModel.key = AssectString(childDict[@"id"]);
                    childModel.value = AssectString(childDict[@"name"]);
                    childModel.remark = AssectString(childDict[@"englishName"]);
                    [weakself.areaDatas addObject:childModel];
                }
            }
            [weakself showAreaView];
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}

-(void)showAreaView{
    WeakSelf(self);
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentLinkage;
    stringPickerView.title = NSLocalizedString(@"所在地区", nil);
    stringPickerView.dataSourceArr = self.areaDatas;
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
        weakself.linkage2SelectIndexs = selectIndexs;
        weakself.addressText.text = selectValue;
    };
    stringPickerView.changeModelArrayBlock = ^(NSArray<BRResultModel *> * _Nullable resultModelArr) {
        NSLog(@"asd");
    };
    [stringPickerView show];
}

- (IBAction)checkClick:(id)sender {
    NSDictionary *dict = @{
      @"birthday": AssectString(self.dateText.text),
      @"cards":  AssectString(self.userModel.cards),
      @"cityId": self.linkage2SelectIndexs.count < 2?@"":[NSString stringWithFormat:@"%@",self.linkage2SelectIndexs[1]],
      @"email": AssectString(self.userModel.email),
      @"id": AssectString(self.userModel.userId),
      @"name": AssectString(self.nickText.text),
      @"phone": AssectString(self.userModel.phone),
      @"photo": AssectString(self.headUrl),
      @"postcode": AssectString(self.emailText.text),
      @"regionId": self.linkage2SelectIndexs.count == 0?@"":[NSString stringWithFormat:@"%@",self.linkage2SelectIndexs[0]],
      @"sex": [AssectString(self.generText.text) isEqualToString:@""]?@"":([AssectString(self.generText.text) isEqualToString:@"男"]?@"1":@"0"),
      @"tags": self.hobbyStrArray
    };
    WeakSelf(self);
    [WebServices postWithUrl:@"user/modUserInfo/" body:dict loadingTime:15. showLoading:YES success:^(NSDictionary *result) {
        if ([result[resultCode] isEqualToString:@"0"]) {
            [weakself showMsg:result[resultMessage] location:centre];
            weakself.fillType == FillInformationLogin?[weakself loginin]:nil;
        }else{
            [weakself showMsg:result[resultMessage] location:centre];
        }
    } failure:^(NSError *error) {
        [weakself showMsg:NSLocalizedString(@"网络异常，请稍后重试", nil) location:centre];
    }];
}


-(void)checkBtnEnable{
    NSInteger hobbyCount = self.hobbyStrArray.count;
    NSString *name = self.nickText.text;
    NSString *mail = self.emailText.text;
    if (hobbyCount > 0 && ![name isEqualToString:@""] && ![mail isEqualToString:@""]) {
        self.checkBtn.userInteractionEnabled = YES;
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#333333"];
    }else{
        self.checkBtn.userInteractionEnabled = NO;
        self.checkBtn.backgroundColor = [UIColor colorWithRGBHex:@"#C0C0CC"];

    }
}

#pragma -mark getter
-(ZWTagListView *)tagView{
    if (!_tagView) {
        _tagView = [[ZWTagListView alloc]initWithFrame:CGRectMake(0, 0, self.tagBgView.width, 100)];
        WeakSelf(self);
        _tagView.Handle = ^(NSInteger tag) {
            HobbyModel *model = weakself.hobbyDatas[tag];
            model.ifSelect = !model.ifSelect;
            [weakself.hobbyDatas replaceObjectAtIndex:tag withObject:model];
            [weakself.hobbyStrArray containsObject:AssectString(model.name)]?[weakself.hobbyStrArray removeObject:AssectString(model.name)]:[weakself.hobbyStrArray addObject:AssectString(model.name)];
            [weakself.tagView setTagWithTagArray:[weakself.hobbyDatas copy]];
            [weakself checkBtnEnable];
        };
    }
    return _tagView;
}

-(NSMutableArray *)hobbyDatas{
    if (!_hobbyDatas) {
        _hobbyDatas = [NSMutableArray array];
    }
    return _hobbyDatas;
}

-(NSMutableArray *)hobbyStrArray{
    if (!_hobbyStrArray) {
        _hobbyStrArray = [NSMutableArray array];
    }
    return _hobbyStrArray;
}

-(NSMutableArray *)areaDatas{
    if (!_areaDatas) {
        _areaDatas = [NSMutableArray array];
    }
    return _areaDatas;
}
@end
