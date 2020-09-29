//
//  XWCountryCodeController.m
//  XWCountryCodeDemo
//
//  Created by 邱学伟 on 16/4/19.
//  Copyright © 2016年 邱学伟. All rights reserved.
//

#import "XWCountryCodeController.h"
#import "AreaSelectTableViewCell.h"

//判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])

@interface XWCountryCodeController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSDictionary *_sortedNameDict;
    NSArray *_indexArray;
    NSMutableArray *_results;
}
@end

@implementation XWCountryCodeController

#pragma mark - system
- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBanar:NSLocalizedString(@"国家代码", nil) hiddeBack:NO];

    [self creatSubviews];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = CGRectMake(0, navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navBarHeight);
}

#pragma mark - private
 //创建子视图
- (void)creatSubviews{
    
    _results = [NSMutableArray arrayWithCapacity:1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.0;
    _tableView.backgroundColor = UIColor.clearColor;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerNib:[UINib nibWithNibName:@"AreaSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"AreaSelectTableViewCell"];
    
    //判断当前系统语言
    if ([[GDLocalizableController userLanguage] isEqualToString:ENGLISH]) {
        NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedNameEN" ofType:@"plist"];
        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathEN];
    } else {
        NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedNameCH" ofType:@"plist"];
        _sortedNameDict = [[NSDictionary alloc] initWithContentsOfFile:plistPathCH];
    }
    
    _indexArray = [[NSArray alloc] initWithArray:[[_sortedNameDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]];
}

- (NSString *)showCodeStringIndex:(NSIndexPath *)indexPath {
    NSString *showCodeSting;
    if (_indexArray.count > indexPath.section) {
        NSArray *sectionArray = [_sortedNameDict valueForKey:[_indexArray objectAtIndex:indexPath.section]];
        if (sectionArray.count > indexPath.row) {
            showCodeSting = [sectionArray objectAtIndex:indexPath.row];
        }
    }
//    NSArray *showCodeArr = [showCodeSting componentsSeparatedByString:@" "];
//    showCodeSting = showCodeArr[0];
    return showCodeSting;
}

- (void)selectCodeIndex:(NSIndexPath *)indexPath {
    
    NSString * originText = [self showCodeStringIndex:indexPath];
    NSArray  * array = [originText componentsSeparatedByString:@"+"];
    NSString * countryName = [array.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * code = array.lastObject;
    
    if (self.deleagete && [self.deleagete respondsToSelector:@selector(returnCountryName:code:)]) {
        [self.deleagete returnCountryName:countryName code:code];
    }
    
    if (self.returnCountryCodeBlock != nil) {
        self.returnCountryCodeBlock(countryName,code);
    }
    
//    _searchController.active = NO;
//    [_searchController.searchBar resignFirstResponder];
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
    NSLog(@"选择国家: %@   代码: %@",countryName,code);
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sortedNameDict allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_indexArray.count > section) {
        NSArray *array = [_sortedNameDict objectForKey:[_indexArray objectAtIndex:section]];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AreaSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaSelectTableViewCell"];
    NSString *code = [self showCodeStringIndex:indexPath];
    NSArray *codeArr = [code componentsSeparatedByString:@"+"];
    cell.nameLabel.text = [codeArr[0] stringByReplacingOccurrencesOfString:@" " withString:@""];
    cell.codeLabel.text = [NSString stringWithFormat:@"+ %@",[codeArr[1] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return _indexArray;
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (tableView == _tableView) {
        return index;
    } else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _tableView) {
        if (section == 0) {
            return 30;
        }
        return 30;
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_indexArray.count && _indexArray.count > section) {
        return [_indexArray objectAtIndex:section];
    }
    return nil;
}

#pragma mark - 选择国际获取代码
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectCodeIndex:indexPath];
}

@end
