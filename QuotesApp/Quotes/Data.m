//
//  Data.m
//  Quotes
//
//  Created by Srinivas Pasupuleti on 4/24/15.
//  Copyright (c) 2015 vasu.com. All rights reserved.
//

#import "Data.h"
#import "UIKit/UIKit.h"
#include "stdlib.h"

@implementation Data
int randomColor;
int randomQuote;


- (instancetype)init
{
    self = [super init];
    if (self) {
        _quotes = [[NSArray alloc]initWithObjects:
                   @"Life is about making an impact, not making an income.  \r\r–Kevin Kruse",
                   @"Whatever the mind of man can conceive and believe, it can achieve. \r\r–Napoleon Hill",
                   @"Strive not to be a success, but rather to be of value. \r\r–Albert Einstein",
                   @"Two roads diverged in a wood, and I took the one less traveled by, And that has made all the difference.  \r\r–Robert Frost",
                   @"I attribute my success to this: I never gave or took any excuse. \r\r–Florence Nightingale",
                   @"You miss 100% of the shots you don’t take. \r\r–Wayne Gretzky",
                   @"I’ve missed more than 9000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life. And that is why I succeed. \r\r–Michael Jordan",
                   @"The most difficult thing is the decision to act, the rest is merely tenacity. \r\r–Amelia Earhart",
                   @"Every strike brings me closer to the next home run. \r\r–Babe Ruth",
                   @"Definiteness of purpose is the starting point of all achievement. \r\r–W. Clement Stone",
                   @"Life isn’t about getting and having, it’s about giving and being. \r\r–Kevin Kruse",
                   @"Life is what happens to you while you’re busy making other plans. \r\r–John Lennon",
                   @"We become what we think about. \r\r–Earl Nightingale",
                   @"Twenty years from now you will be more disappointed by the things that you didn’t do than by the ones you did do, so throw off the bowlines, sail away from safe harbor, catch the trade winds in your sails.  Explore, Dream, Discover. \r\r–Mark Twain",
                   @"Life is 10% what happens to me and 90% of how I react to it. \r\r–Charles Swindoll",
                   @"The most common way people give up their power is by thinking they don’t have any. \r\r–Alice Walker",
                   @"The mind is everything. What you think you become.  \r\r–Buddha",
                   @"An unexamined life is not worth living. \r\r–Socrates",
                   @"Eighty percent of success is showing up. \r\r–Woody Allen",
                   @"Your time is limited, so don’t waste it living someone else’s life. \r\r–Steve Jobs",
                   @"Winning isn’t everything, but wanting to win is. \r\r–Vince Lombardi",
                   @"I am not a product of my circumstances. I am a product of my decisions. \r\r–Stephen Covey",
                   @"Every child is an artist.  The problem is how to remain an artist once he grows up. \r\r–Pablo Picasso",
                   @"You can never cross the ocean until you have the courage to lose sight of the shore. \r\r–Christopher Columbus",
                   @"I’ve learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel. \r\r–Maya Angelou",
                   @"Either you run the day, or the day runs you. \r\r–Jim Rohn",
                   @"Whether you think you can or you think you can’t, you’re right. \r\r–Henry Ford",
                   @"The two most important days in your life are the day you are born and the day you find out why. \r\r–Mark Twain",
                   @"Whatever you can do, or dream you can, begin it.  Boldness has genius, power and magic in it. \r\r–Johann Wolfgang von Goethe",
                   @"People often say that motivation doesn’t last. Well, neither does bathing.  That’s why we recommend it daily. \r\r–Zig Ziglar",
                   @"Life shrinks or expands in proportion to one’s courage. \r\r–Anais Nin",
                   @"If you hear a voice within you say “you cannot paint,” then by all means paint and that voice will be silenced. \r\r–Vincent Van Gogh",
                   @"There is only one way to avoid criticism: do nothing, say nothing, and be nothing. \r\r–Aristotle",
                   @"When I stand before God at the end of my life, I would hope that I would not have a single bit of talent left and could say, I used everything you gave me. \r\r–Erma Bombeck",
                   @"Certain things catch your eye, but pursue only those that capture the heart. \r\r– Ancient Indian Proverb",
                   @"Believe you can and you’re halfway there. \r\r–Theodore Roosevelt",
                   @"Everything you’ve ever wanted is on the other side of fear. \r\r–George Addair",
                   @"We can easily forgive a child who is afraid of the dark; the real tragedy of life is when men are afraid of the light. \r\r–Plato",
                   @"When I was 5 years old, my mother always told me that happiness was the key to life.  When I went to school, they asked me what I wanted to be when I grew up.  I wrote down ‘happy’.  They told me I didn’t understand the assignment, and I told them they didn’t understand life. \r\r–John Lennon",
                   @"When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. \r\r–Helen Keller",
                   @"Happiness is not something readymade.  It comes from your own actions. \r\r–Dalai Lama",
                   @"You can’t fall if you don’t climb.  But there’s no joy in living your whole life on the ground. \r\r–Unknown",
                   @"We must believe that we are gifted for something, and that this thing, at whatever cost, must be attained. \r\r–Marie Curie",
                   @"Too many of us are not living our dreams because we are living our fears. \r\r–Les Brown",
                   @"Challenges are what make life interesting and overcoming them is what makes life meaningful. \r\r–Joshua J. Marine",
                   @"If you want to lift yourself up, lift up someone else. \r\r–Booker T. Washington",
                   @"What’s money? A man is a success if he gets up in the morning and goes to bed at night and in between does what he wants to do. \r\r–Bob Dylan",
                   @"A person who never made a mistake never tried anything new. \r\r– Albert Einstein",
                   @"It is not what you do for your children, but what you have taught them to do for themselves, that will make them successful human beings.  \r\r–Ann Landers",
                   @"If you want your children to turn out well, spend twice as much time with them, and half as much money. \r\r–Abigail Van Buren",
                   @"It does not matter how slowly you go as long as you do not stop. \r\r–Confucius",
                   @"Remember that not getting what you want is sometimes a wonderful stroke of luck. \r\r–Dalai Lama",
                   @"You can’t use up creativity.  The more you use, the more you have. \r\r–Maya Angelou",
                   @"Our lives begin to end the day we become silent about things that matter. \r\r–Martin Luther King Jr.",
                   @"The question isn’t who is going to let me; it’s who is going to stop me. \r\r–Ayn Rand",
                   @"Either write something worth reading or do something worth writing. \r\r–Benjamin Franklin",
                   @"The only way to do great work is to love what you do. \r\r–Steve Jobs",
                   nil];
        
        _colors = [[NSArray alloc] initWithObjects:
                   [UIColor colorWithRed:90/255.0 green:187/255.0 blue:181/255.0 alpha:1.0], //teal color
                   [UIColor colorWithRed:222/255.0 green:171/255.0 blue:66/255.0 alpha:1.0], //yellow color
                   [UIColor colorWithRed:223/255.0 green:86/255.0 blue:94/255.0 alpha:1.0], //red color
                   [UIColor colorWithRed:239/255.0 green:130/255.0 blue:100/255.0 alpha:1.0], //orange color
                   [UIColor colorWithRed:77/255.0 green:75/255.0 blue:82/255.0 alpha:1.0], //dark color
                   [UIColor colorWithRed:105/255.0 green:94/255.0 blue:133/255.0 alpha:1.0], //purple color
                   [UIColor colorWithRed:85/255.0 green:176/255.0 blue:112/255.0 alpha:1.0], //green color
                   nil];
        
        NSDictionary *caramelDelight  = @{@"flavor":@"caramel"};
        NSDictionary *caramelDelight2  = @{@"flavor":@"caramel"};

        _chocolateBox = @[caramelDelight,caramelDelight2];
        
        UIImage *profileImage = [UIImage imageNamed:@"pic"];
        UIImageView *userProfilePhoto = [[UIImageView alloc ]initWithImage:profileImage];
        NSLog(@"%@",userProfilePhoto);
        
        
        
    }
    return self;
}

-(void)initrandomQuote
{
    randomQuote = arc4random_uniform((int)[self.quotes count]);
}
-(void)initrandomColor
{
    randomColor = arc4random_uniform((int)[self.colors count]);
}

-(int)randomQuote
{
    if(randomQuote==[self.quotes count])
        randomQuote=0;
    return randomQuote++;
}

-(int)randomColor
{
    if(randomColor==[self.colors count])
        randomColor=0;
    return randomColor++;
}


@end
