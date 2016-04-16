//
//  ViewController.m
//  coredata
//
//  Created by Joshua O'Connor on 4/15/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self insertNewPerson];
    [self deletePerson];
    
}


- (void)insertNewPerson{
    
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    Person *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext];
    entry.height = [NSNumber numberWithInt:60];
    entry.weight = [NSNumber numberWithInt:200];
    entry.name = @"Josh";
    [coreDataStackInstance saveContext];
    
}
- (void)deletePerson{
    
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext]];
    
    NSString* nameVal = @"Josh";
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameVal]];
    
    //Deleting With more than one parameter
//    NSString* contentVal = @"test";
//    NSNumber* pageVal = [NSNumber numberWithInt:5];
//    NSString* bookVal = @"1331313";
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"content == %@ AND page_id == %@ AND book_id == %@", contentVal, pageVal, bookVal]];

    NSError* error = nil;
    NSArray* results = [coreDataStackInstance.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
//    NSLog(@"%@", results);
    
    if(results && [results count]>0){
        for (NSManagedObject* toDelete in results) {
            [coreDataStackInstance.managedObjectContext deleteObject:toDelete];
            [coreDataStackInstance saveContext];
        }
    }
}

@end
