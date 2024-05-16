# CS 177 - project02.py
# Karim Muhammad El-Sharkawy
# Basically, this is used for us to balance a workout (balance between stretching, running, and weightlifting).evaluate their exercises.

import math

def judgeBalancingOfWorkout(running, weightlifting):
    if ((-10) < ((weightlifting / 20) - (running / 100)) < 10):
        BalancedWorkout = "yes"
    else:
        BalancedWorkout = "no"

    return BalancedWorkout

def judgeGoodCaloriesBurning(stretching, running, weightlifting):
    Calories = (stretching * 10) + (running * 100) + (weightlifting * 2)
    if Calories >= 500:
        GoodCaloriesBurning = "yes"
    else:
        GoodCaloriesBurning = "no"

    return GoodCaloriesBurning

def judgeAchievedGoal(stretching, running, weightlifting):
    if (stretching >= 50) and (running >= 20) and (weightlifting >= 40):
        AchievedGoal = "yes"
    else:
        AchievedGoal = "no"

    return AchievedGoal

def judgeMissingOfWorkout(stretching, running, weightlifting):
    if (stretching==0) or (running==0) or (weightlifting==0):
        MissedWorkout = "yes"
    else:
        MissedWorkout = "no"

    return MissedWorkout

def judgeShortOfStretching(stretching):
    if stretching < 30 :
        ShortOfStretching = "yes"
    else:
        ShortOfStretching = "no"

    return ShortOfStretching

def judgeTooManyWeightLiftings(weightlifting):
    if weightlifting > 100:
        TooManyWeightLiftings = "yes"
    else:
        TooManyWeightLiftings = "no"

    return TooManyWeightLiftings

def ratingDecision(stretching, running, weightlifting):
    BadgeCount = 0
    FeedbackCount = 0

    BalancedWorkout = judgeBalancingOfWorkout(running, weightlifting)
    if BalancedWorkout == "yes":
        print("BADGE - Your workout between strength enhancing and running are well balanced")
        BadgeCount += 1
        
    GoodCaloriesBurning = judgeGoodCaloriesBurning(stretching, running, weightlifting)
    if GoodCaloriesBurning == "yes":
        print("BADGE - You consumed more than 500 kcals")
        BadgeCount += 1
        
    AchievedGoal = judgeAchievedGoal(stretching, running, weightlifting)
    if AchievedGoal == "yes":
        print("BADGE - You achieved the goals in all of three workouts")
        BadgeCount += 1
        
    BalancedWorkout = judgeBalancingOfWorkout(running, weightlifting)
    if BalancedWorkout == "no":
        print("FEEDBACK - Do not miss any of type of workout")
        FeedbackCount += 1

    ShortOfStretching = judgeShortOfStretching(stretching)
    if ShortOfStretching == "yes":
        print("FEEDBACK - Lack of stretch will make you injured")
        FeedbackCount += 1

    TooManyWeightLiftings = judgeTooManyWeightLiftings(weightlifting)
    if TooManyWeightLiftings == "yes":
        print("FEEDBACK - Too much burden from weightlifting may make you injured")
        FeedbackCount += 1

    if BadgeCount == 0 and FeedbackCount ==3:
        print("Rating: one star - Cheer up")
    if BadgeCount<FeedbackCount and BadgeCount != 0:
        print("Rating: two stars - Good")
    if BadgeCount == FeedbackCount:
        print("Rating: three stars - Nice")
    if BadgeCount>FeedbackCount and FeedbackCount != 0:
        print("Rating: four stars - Great")
    if BadgeCount ==3 and FeedbackCount == 0:
        print("Rating: five stars - Awesome")
        
#defining the main function
def main():
    stretching = eval(input("your stretching record in minutes: "))
    running = eval(input("your running record in miles: "))
    weightlifting = eval(input("your weightlifting record of counts: "))
    ratingDecision(stretching, running, weightlifting)
if __name__ == "__main__":
    main()
