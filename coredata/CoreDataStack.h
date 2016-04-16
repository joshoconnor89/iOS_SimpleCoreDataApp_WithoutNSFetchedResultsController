//
//  CoreDataStack.h
//  liftSmart
//
//  Created by Joshua O'Connor on 2/25/16.
//  Copyright © 2016 Joshua O'Connor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

//Read-only properties wont be automatically synthesized, so we have to synthesize them in the .m
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (instancetype)defaultStack;

@end
