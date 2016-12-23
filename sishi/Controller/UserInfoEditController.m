//
//  UserInfoEditController.m
//  sishi
//
//  Created by likeSo on 2016/12/21.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "UserInfoEditController.h"
#import "ImageAdder.h"
#import "UIViewController+UIImagePickerController.h"
#import "sishiDefine.h"
#import "UserCertificationController.h"
#import "SelectViewContainer.h"

@interface UserInfoEditController ()<ImageAdderAddImageProtocol,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;
@property (weak, nonatomic) IBOutlet UITextField *nickNameInputField;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UITextField *ageInputField;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressInputField;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *descInputField;
@property (weak, nonatomic) IBOutlet ImageAdder *imageAdder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adderHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
/**
 *  照片墙单元格高度
 */
@property(nonatomic,assign)CGFloat imageAdderHeight;
/**
 *  性别选择器
 */
@property(nonatomic,strong)UIPickerView *genderPicker;

/**
 *  生日选择器
 */
@property(nonatomic,strong)UIPickerView *birthdayPicker;



/**
 *  头像图片文件
 */
@property(nonatomic,strong)UIImage *headImage;

/**
 *  性别选择数组
 */
@property(nonatomic,strong,readonly)NSArray <NSString *>* genderSelectList;

/**
 *  月份数组
 */
@property(nonatomic,strong)NSArray <NSString *>*monthList;

/**
 *  天数数组,二维
 */
@property(nonatomic,strong)NSArray <NSArray <NSString *>*>* dayArray;



@end

@implementation UserInfoEditController

- (NSArray<NSString *> *)genderSelectList {
    return @[@"男",@"女"];
}

- (NSArray<NSString *> *)monthList {
    NSMutableArray *months = [NSMutableArray arrayWithCapacity:12];
    for (NSInteger index = 1 ; index <= 12; index ++) {
        NSString *monthString = [NSString stringWithFormat:@"%ld  月",(long)index];
        [months addObject:monthString];
    }
    return [NSArray arrayWithArray:months];
}

- (NSArray<NSArray<NSString *> *> *)dayArray {
    NSMutableArray *dateList  = [NSMutableArray arrayWithCapacity:12];
    for (int monthIndex = 1;monthIndex <= 12;monthIndex ++) {
//        NSInteger monthIndex = [self.monthList indexOfObject:tmp];
        NSMutableArray *monthsList = [NSMutableArray array];
        for (int i = 1; i <= 31; i ++) {
            if (monthIndex == 2 && i >= 30) {
                continue;
            } else if ((monthIndex == 4 || monthIndex == 6 || monthIndex == 9 || monthIndex == 11) && i >= 31) {
                continue;
            }
            NSString *dayString = [NSString stringWithFormat:@"%d  日",i];
            [monthsList addObject:dayString];
        }
        [dateList addObject:monthsList];
    }
    return [NSArray arrayWithArray:dateList];
}

- (UIPickerView *)genderPicker {
    if (!_genderPicker) {
        _genderPicker = [[UIPickerView alloc]initWithFrame:CGRectZero];
        _genderPicker.delegate = self;
        _genderPicker.dataSource = self;
        _genderPicker.backgroundColor = [UIColor whiteColor];
    }
    return _genderPicker;
}

- (UIPickerView *)birthdayPicker {
    if (!_birthdayPicker) {
        _birthdayPicker = [[UIPickerView alloc]initWithFrame:CGRectZero];
        _birthdayPicker.delegate = self;
        _birthdayPicker.dataSource = self;
        _birthdayPicker.backgroundColor = [UIColor whiteColor];
    }
    return _birthdayPicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"完善资料";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.imageAdderHeight = 105;
    self.tableView.estimatedRowHeight = 45;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    
    self.completeBtn.layer.cornerRadius = 5;
    self.completeBtn.clipsToBounds = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    kWeakSelf;
    self.imageAdder.onChangeHeight = ^(CGFloat height) {
//        weakSelf.adderHeightConstraint.constant = height;
        //刷新单元格高度
        
        [weakSelf.tableView beginUpdates];
        weakSelf.imageAdderHeight = height + 15;
        [weakSelf.tableView endUpdates];
//        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:9 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    };
    self.imageAdder.imageAdderDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

#pragma mark :- 添加图片
- (void)imageAdder:(ImageAdder *)imageAdder addImageWithImageList:(NSArray<UIImage *> *)imageList {
    [self pickImage:@"ImageAdder"];
}

- (void)finishPickWithImage:(UIImage *)image {
    [self.imageAdder appendImage:image];
}

- (IBAction)onSetImage:(UIButton *)sender {
    [self pickImage:@"headerImage"];
}

- (void)finishPickWithImage:(UIImage *)image identifier:(NSString *)identifier{
    if ([identifier isEqualToString:@"headerImage"]) {
        self.headImage = image;
        [self.headImageBtn setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        [self.imageAdder appendImage:image];
    }
}

- (IBAction)onComplete:(UIButton *)sender {
    
}
//点击认证 按钮
- (IBAction)onAuth:(UIButton *)sender {
    UserCertificationController *authController = [[UserCertificationController alloc]initWithNibName:@"UserCertificationController" bundle:[NSBundle mainBundle]];
    authController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:authController animated:YES];
}

#pragma mark :- PickerViewDelegate 
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.genderPicker) {
        return self.genderSelectList.count;
    }
    if (component == 0) {
        return self.monthList.count;
    } else {
        return [self.dayArray[[pickerView selectedRowInComponent:0]] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.genderPicker) {
        return self.genderSelectList[row];
    }
    if (component == 0) {
        return self.monthList[row];
    } else {
        return self.dayArray[[pickerView selectedRowInComponent:0]][row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.genderPicker) {
            self.genderLabel.text = self.genderSelectList[row];
    } else {
        if (component == 0) {
            [pickerView reloadComponent:1];//刷新第二列
        }
        NSString *month = self.monthList[[pickerView selectedRowInComponent:0]];
        NSString *day = self.dayArray[[pickerView selectedRowInComponent:0]][row];
        self.birthdayLabel.text = [NSString stringWithFormat:@"%@ %@",month,day];
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 9) {
        return self.imageAdderHeight;
    } else if (indexPath.row == 11) {
        return 65;
    }
    return 45;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return pickerView == self.genderPicker ? 1 : 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {//性别选择
        SelectViewContainer *container = [SelectViewContainer defaultContainerView];
        [container showWithContentView:self.genderPicker withTitle:@"选择您的性别"];
    } else if (indexPath.row == 4) {
        SelectViewContainer *container = [SelectViewContainer defaultContainerView];
        [container showWithContentView:self.birthdayPicker withTitle:@"选择您的出生日期"];
    }
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
////#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
