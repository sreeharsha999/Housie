//
//  HGTGenerateTicket.m
//  trail
//
//  Created by Harsha on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HGTGenerateTicket.h"

@implementation HGTGenerateTicket
{
    NSArray *temp1;
    
}
@synthesize ticketNumbers;
- (id)init
{
    self = [super init];
    if (self) {
        ticketNumbers = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)GenerateNoOfTickets:(int)noOfTickets :(id<HGTGenerateTicketDelegate>)someClass
{
    while (ticketNumbers.count < noOfTickets)
    {
        NSLog(@"***%lu",(unsigned long)ticketNumbers.count);
        temp1 = [self generateTickets];
        if ([ticketNumbers isKindOfClass:[NSMutableArray class]]) {
            if (![[ticketNumbers copy] containsObject:temp1]) {
                [ticketNumbers addObject:temp1];
                [someClass generationOfTicketCompleated:temp1];
            }
        }
        
    }
}


-(NSArray*)generateTickets
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    int i ,j ,k,pos;
    int tambola[3][9];//represent tambola ticket
    int posr[5]; //to store random positions in one row of ticket
    //initialze tambola ticket values to zero
    for( i =0 ; i< 3; i++)
    {
        for (j=0; j<9; j++)
        {
            tambola[i][j] = 0;
            
        }
        
    }
    //to generate new set of values every time
    srand((unsigned)(time(NULL)));
    // to find out random 15 positions in the tambola ticket
    for(i=0; i<3;i++)// i represents row
    {
        if ((i == 0) || (i ==2)) // first and third row
        {
            for ( pos=0; pos<5;pos++)
            {
                posr[pos] = arc4random_uniform(8);//generate random value beetween 0to8
                for( j=0; j<pos; j++)
                {
                    if(posr[pos] == posr[j])//checks for repeated value
                        pos--;
                }
                tambola[i][posr[pos]]=1;// assign 1 to random position generated above
            }
        }
        if (i==1) // for second row
        {
            for (j =0; j<9; j++)
            {
                if (tambola[0][j] == 0)
                    tambola[i][j] = 1;
            }
            for (j =0; j<9; j++)
            {
                int x;
                x = rand()%9;
                if(tambola[i][x] ==0)
                {
                    tambola[i][x] = 1;
                    break;
                }
            }
        }
    }
    
    // display random positions
    //                cout << "\n random positions to be filled in the ticket: \n";
    for( i =0 ; i< 3; i++)
    {
        for (j=0; j<9; j++)
        {
            //                        cout << tambola[i][j]<<"\t";
            
        }
        //                    cout<<"\n";
    }
    // to generate random values in tambola ticket
    for(j=0;j<9;j++) //for each column
    {
        int number[3]; // store random values for each column
        int count =0; // number of values required in each column
        for (i=0;i<3;i++)
            number[i] =0; // initialize to 0
        for(i=0; i<3; i++)
        {
            if (tambola[i][j] == 1)
                count++;
        }
        
        for(k=0;k<count; k++)
        {
            if(j==0)
            {
                number[k] = arc4random_uniform(8) +1;// random number between 1to9
            }
            else
            {
                //replaced rand()%10
                number[k] = arc4random_uniform(9) +j*10;// random number respective to column j
            }
            for(int l=0; l<k;l++)// check for repeated and ordered random values
            {
                if (number[k] == number[l])
                    
                    k--;
                
            }
        }
        
        //sorting the generated random numbers
        int temp=0;
        for(k=0; k<count; k++)
        {
            for(int a=k+1; a<count ; a++)
            {
                if(number[k]>number[a])
                {
                    temp = number[k];
                    number[k]=number[a];
                    number[a]=temp;
                }
            }
        }
        k=0;
        
        
        for(i=0;i<3;i++) // assign generated value to each column of the ticket.
        {
            if(tambola[i][j] ==1)
                tambola[i][j] = number[k++];
        }
    }
    //display
    //                cout <<"\n tambola ticket:\n";
    for( i =0 ; i< 3; i++)
    {
        for (j=0; j<9; j++)
        {
            //                        cout << tambola[i][j]<<"\t";
            [array addObject:[NSNumber numberWithInt:tambola[i][j]]];
            
        }
        //                    cout<<"\n";
        
    }
    return array;
}

@end
