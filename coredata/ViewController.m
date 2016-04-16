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
    
    //CRUD METHODS
    [self createNewPerson];
    [self readPerson];
    [self updatePerson];
    [self deletePerson];
}


- (void)createNewPerson{
    
    NSLog(@"****CREATE****");
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    Person *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext];
    entry.height = [NSNumber numberWithInt:60];
    entry.weight = [NSNumber numberWithInt:200];
    entry.name = @"Josh";
    
    NSLog(@"%@",entry);
    
    [coreDataStackInstance saveContext];
}


-(void)readPerson{
    
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext]];
    
    //Filtering out results
//    NSString* nameVal = @"Josh";
//    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameVal]];
    
    //Filter with more than one parameter
    //    NSString* contentVal = @"test";
    //    NSNumber* pageVal = [NSNumber numberWithInt:5];
    //    NSString* bookVal = @"1331313";
    //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"content == %@ AND page_id == %@ AND book_id == %@", contentVal, pageVal, bookVal]];
    
    NSError *error = nil;
    NSArray *results = [coreDataStackInstance.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    NSLog(@"****READ****");
    
    //Number of items in Managed Object Model (IF NO PREDICATE HAS BEEN APPLIED)
    NSLog(@"  Number of items in Managed Object Model: %lu", (unsigned long)results.count);
    
    if(results && [results count]>0){
        int currentCount;
        currentCount = 0;
        for (Person* toUpdate in results) {
            currentCount++;
            NSLog(@"  Object #%d", currentCount);
            NSLog(@"    Weight attribute: %@", toUpdate.weight);
            NSLog(@"    Height attribute: %@", toUpdate.height);
            NSLog(@"    Name attribute: %@", toUpdate.name);

        }
    }


}


-(void)updatePerson{
    
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext]];
    
    //Filtering out results
    NSString* nameVal = @"Josh";
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameVal]];
        
    //Updating With more than one parameter
    //    NSString* contentVal = @"test";
    //    NSNumber* pageVal = [NSNumber numberWithInt:5];
    //    NSString* bookVal = @"1331313";
    //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"content == %@ AND page_id == %@ AND book_id == %@", contentVal, pageVal, bookVal]];
    
    NSError *error = nil;
    NSArray *results = [coreDataStackInstance.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    NSLog(@"***UPDATE***");
    
    if(results && [results count]>0){
        int currentCount;
        currentCount = 0;
        for (Person* toUpdate in results) {
            currentCount++;
            NSLog(@"  Before updating object #%d", currentCount);
            NSLog(@"    Weight attribute: %@", toUpdate.weight);
            NSLog(@"    Height attribute: %@", toUpdate.height);
            NSLog(@"    Name attribute: %@", toUpdate.name);
            
            [toUpdate setValue:[NSNumber numberWithInt:188] forKey:@"weight"];
            [toUpdate setValue:[NSNumber numberWithInt:66] forKey:@"height"];
            [toUpdate setValue:@"joe" forKey:@"name"];
            [coreDataStackInstance saveContext];
            
            NSLog(@"  After updating object #%d", currentCount);
            NSLog(@"    Weight attribute: %@", toUpdate.weight);
            NSLog(@"    Height attribute: %@", toUpdate.height);
            NSLog(@"    Name attribute: %@", toUpdate.name);
        }
    }
}


- (void)deletePerson{
    
    CoreDataStack *coreDataStackInstance = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Person" inManagedObjectContext:coreDataStackInstance.managedObjectContext]];
    
    //Filtering out results
    NSString* nameVal = @"joe";
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameVal]];
    
    //Deleting With more than one parameter
    //    NSString* contentVal = @"test";
    //    NSNumber* pageVal = [NSNumber numberWithInt:5];
    //    NSString* bookVal = @"1331313";
    //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"content == %@ AND page_id == %@ AND book_id == %@", contentVal, pageVal, bookVal]];
    
    NSError* error = nil;
    NSArray* results = [coreDataStackInstance.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //    NSLog(@"%@", results);
    NSLog(@"***DELETE***");
    NSLog(@"  We are going to delete %lu objects", (unsigned long)results.count);
    
    if(results && [results count]>0){
        int currentCount;
        currentCount = 0;
        for (Person* toDelete in results) {
            currentCount++;
            NSLog(@"    Object #%d deleted", currentCount);
            [coreDataStackInstance.managedObjectContext deleteObject:toDelete];
            [coreDataStackInstance saveContext];
        }
    }
}


@end
