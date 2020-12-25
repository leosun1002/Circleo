//
//  FEexChooseRecordView.m
//  Cloud Pro
//
//  Created by 董雷 on 2020/3/2.
//  Copyright © 2020 yunzhuan. All rights reserved.
//

#import "FEexChooseRecordView.h"

@interface FEexChooseRecordView ()

@property (weak, nonatomic) IBOutlet UIButton *qbButton;
@property (weak, nonatomic) IBOutlet UIButton *cbButton;
@property (weak, nonatomic) IBOutlet UIButton *tbButton;
@property (weak, nonatomic) IBOutlet UIButton *znhzButton;

@end

@implementation FEexChooseRecordView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)chooseTypeAction:(UIButton *)sender {
    if (_clickBlock) {
        _clickBlock(@"", @"");
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
