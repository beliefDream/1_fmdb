//
//  Root2ViewController.m
//  2_FMDB
//
//  Created by 黄纪超 on 15/10/30.
//  Copyright (c) 2015年 黄纪超. All rights reserved.
//

#import "Root2ViewController.h"
#import <FMDB.h>

@interface Root2ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
- (IBAction)insertData:(id)sender;
- (IBAction)deleteData:(id)sender;
- (IBAction)modifyData:(id)sender;
- (IBAction)queryData:(id)sender;
@property (nonatomic, strong)FMDatabase * db;

@end

@implementation Root2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * dbPath = [filePath stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"%@", dbPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    
    [self createTable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (FMDatabase *)db {
    if (_db == nil) {
        NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString * dbPath = [filePath stringByAppendingPathComponent:@"db.sqlite"];
        NSLog(@"%@", dbPath);
        self.db = [FMDatabase databaseWithPath:dbPath];
        
    }
    return _db;
}

- (void)createTable {
    if ([self.db open]) {
        NSString * createSql = @"CREATE TABLE  IF NOT EXISTS PersonList (Name text, Age integer,  Sex integer, Phone text, Address text, Photo blob)";
        BOOL isExecute = [_db executeUpdate:createSql];
        if (!isExecute) {
            NSLog(@" ... error");
        }
        [_db close];
    }
}

- (IBAction)insertData:(id)sender {
    if ([self.db open]) {
//        NSString * insertSql = @"INSERT INTO  PersonList (Name, Age, Sex) VALUES (?, ?, ?)";
//
//        [_db executeUpdate:@"INSERT INTO  PersonList (Name) VALUES (?, ?, ?)",
//        /* _nameTF.text, _ageTF.text, _numberTF.text*/ @"11", @11, @11];
//        [_db executeUpdate:@"INSERT INTO  PersonList (Name) VALUES (? )", @"aa"];
        NSString *sql = @"INSERT INTO PersonList (Name, Age) VALUES (?, ?)";
             [_db executeUpdate:sql, @"sdsd", _ageTF.text];
   
        [_db close];
    }
}

- (IBAction)deleteData:(id)sender {
    if ([self.db open]) {
        NSString * deleteSql = @"delete from PersonList";
        [_db executeUpdate:deleteSql];
        [_db close];
    }
}

- (IBAction)modifyData:(id)sender {
    if ([self.db open]) {
        [_db executeUpdate:@"UPDATE PersonList SET Age = ? WHERE Name = ?",
        [NSNumber numberWithInt:30],@"sdsd"];
        [_db close];
    }
}

- (IBAction)queryData:(id)sender {
    if ([self.db open]) {
        NSString * queryStr = @"SELECT Name, Age FROM PersonList";
        FMResultSet * rs = [_db executeQuery:queryStr];
        if ([rs next]) {
           NSString * name = [rs stringForColumn:@"Name"];
           int age = [rs intForColumn:@"Age"];
            int kk = 0;
            NSLog(@"name = %@, age = %d, number =  %d\n\n", name, age, kk);
        }
        [_db close];
    }
}
@end
