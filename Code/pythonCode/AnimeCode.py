import getpass
import sys
import csv
import mysql.connector
from prettytable import PrettyTable
import os
from datetime import datetime

mydb=mysql.connector.connect(
    host='localhost',
    user='root',
    password='install',
    port='3306',
    database='animedb'
)
mycursor = mydb.cursor()
def SearchByAnimeName():
    os.system('cls')
    AnimeName = input("Please type anime name to search: ")
    UserAnimeQuery = 'Select Name,JapaneseName,Aired_start,Aired_end from AnimeInfo where Name like \'' + AnimeName + '%\';'
    # print(UserAnimeQuery)
    #mycursor = mydb.cursor()
    mycursor.execute(UserAnimeQuery)
    animes = mycursor.fetchall()
    display = PrettyTable()
    display.field_names = ["Name", "JapaneseName", "Aired_start", "Aired_end"]

    if (mycursor.rowcount == 0):
        print("Oops! No record found...")

    elif(mycursor.rowcount>10):
        nextCount=0
        for i in range(0,int(mycursor.rowcount/10),1):
            print("Press 1 for next page")
            print("Press 2 to exit")
            tableViewInput=input("Chose one option: ")
            k=nextCount*10
            for j in range(k,k+10,1):
                if(animes[j[0]!=""]):
                    display.add_row(animes[j])

            nextCount=nextCount+1
            print(display)
            display.clear()

    else:
        for anime in animes:
            display.add_row(anime)

        print(display)

#def SearchByAnimeUserRating():

def SearchByAnimeReleaseDate():
    os.system('cls')
    AiredStart = input("Please type the 1st relase date of anime in (YYYY-MM-DD) format: ")
    while(1):
        if(AiredStart!=""):
            break
        else:
            os.system('cls')
            AiredStart = input("Please enter at least the 1st relase date of anime in (YYYY-MM-DD) format: ")

    AiredEnd =input("Please type the 2nd relase date of anime in (YYYY-MM-DD) format: ")
    mycursor = mydb.cursor()

    if(AiredEnd!=""):
        SearchByDateQuery='Select Name,Aired_start from AnimeInfo where Aired_start BETWEEN \''+AiredStart+'\' and \''+AiredEnd+'\';'

    else:
        SearchByDateQuery = 'Select Name,Aired_start from AnimeInfo where Aired_start>=\'' + AiredStart + '\';'

    mycursor.execute(SearchByDateQuery)
    animes = mycursor.fetchall()
    display = PrettyTable()
    display.field_names = ["Name", "Aired_start"]

    if(mycursor.rowcount==0):
        print("Oops! No record found...")

    else:
        for anime in animes:
            display.add_row(anime)

        print(display)

def SearchByAnimeRating():
    os.system('cls')
    print("Press 1 see the animes with rating between 9-10")
    print("Press 2 see the animes with rating between 8-9")
    print("Press 3 see the animes with rating between 7-8")
    print("Press 4 see the animes with rating between 6-7")
    print("Press 5 see the animes with rating between 5-6")
    print("Press 0 to exit")
    UserChoice = int(input("Please enter your choice: "))
    if(UserChoice==1):
        SearchByAnimeRatingQuery="Select Name,JapaneseName,Score from AnimeInfo where Score>=9 and Score<=10;"

    elif (UserChoice == 2):
        SearchByAnimeRatingQuery = "Select Name,JapaneseName,Score from AnimeInfo where Score>=8 and Score<=9;"

    elif (UserChoice == 3):
        SearchByAnimeRatingQuery = "Select Name,JapaneseName,Score from AnimeInfo where Score>=7 and Score<=8;"

    elif (UserChoice == 4):
        SearchByAnimeRatingQuery = "Select Name,JapaneseName,Score from AnimeInfo where Score>=6 and Score<=7;"

    elif (UserChoice == 5):
        SearchByAnimeRatingQuery = "Select Name,JapaneseName,Score from AnimeInfo where Score>=5 and Score<=6;"

    try:
        mycursor.execute(SearchByAnimeRatingQuery)
        animes = mycursor.fetchall()
        display = PrettyTable()

        if (mycursor.rowcount == 0):
            print("Oops! No record found...")

        elif (mycursor.rowcount > 10):
            #print(mycursor.rowcount, " number of records found")
            nextCount = 0
            r=int((mycursor.rowcount / 10) if (mycursor.rowcount % 10==0) else int((mycursor.rowcount / 10))+1)
            for i in range(0, r, 1):
                display.field_names = ["Name", "JapaneseName", "Score"]
                k = nextCount * 10
                l=k+10
                for j in range(k, min(l,len(animes)), 1):
                    display.add_row(animes[j])

                nextCount = nextCount + 1
                os.system('cls')
                print(display)
                display.clear()
                if (r>0):
                    print("Press 1 for next page")
                    print("Press 2 to exit")
                    tableViewInput = int(input("Chose one option: "))
                    if (tableViewInput == 1):
                        os.system('cls')
                        continue
                    elif(tableViewInput==2):
                        os.system('cls')
                        break
                    else:
                        print("Wrong choice..")

        else:
            print(mycursor.rowcount, " number of records found")
            display.field_names = ["Name", "JapaneseName", "Score"]
            for anime in animes:
                display.add_row(anime)

            print(display)

    except mysql.connector.IntegrityError:
        print("Failed to fetch values...!!")

def RegUserLogin():
    #os.system('cls')
    print("Welcome")
    print("Press 1 to search anime")
    print("Press 2 to search animes based on ratings")
    UserChoice = int(input("Please select one option: "))
    if (UserChoice == 1):
        SearchByAnimeName()

    elif(UserChoice==2):
        SearchByAnimeRating()

def InsertRecords():
    while(1):
        os.system('cls')
        print("Press 1 to insert into the table AnimeInfo")
        print("Press 2 to insert into the table UserInfo")
        print("Press 3 to insert into the table AnimeUserRatingWatchStatus")
        print("Press 4 to insert into the table AnimeRatingComplete")
        print("Press 0 to exit")
        UserChoice=int(input("Please enter your choice: "))
        if(UserChoice==0):
            return 0

        elif(UserChoice==1):
            fileName=input("Enter the file name:")
            csv_data=csv.reader(file(fileName))
            print(csv_data)
            for r in csv_data:
                 try:
                     AnimeInfoInsertQuery="Insert into AnimeInfo(MALID, Name, Score, EnglishName, JapaneseName, Episodes, Aired_start, Aired_end, Premiered, Source, Duration_in_min_per_episode" \
                                            +"Rating, Ranked, Popularity, Members, Favourites, Watching, Completed, OnHold, Dropped, PlanToWatch" \
                                            +"Score10, Score9, Score8, Score7, Score6, Score5, Score4, Score3, Score2, Score1, Synopsis)"\
                                            +'Values("%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s'\
                                            +'"%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s","%s")'
                     print(AnimeInfoInsertQuery)
                     for r in csv_data:
                         mycursor.execute(AnimeInfoInsertQuery,r)
                     print(mycursor.rowcount, " row inserted successfully")
                     mydb.commit()
                 except mysql.connector.IntegrityError:
                     print("Failed to insert values...!!")

        elif(UserChoice==2):
            flag=0
            os.system('cls')
            while(1):
                role =input("Enter user role to be inserted: ")
                if(role!='Register User' and role!='Admin User'):
                    UserChoice=int(input("Invalid role entered. Please try again or press 0 to exit: "))
                    if UserChoice==0:
                        flag = 1
                        break
                else:
                    break

            if (flag==0):
                lastrow="SELECT * FROM userinfo WHERE userid=(SELECT max(userid) FROM userinfo);"
                mycursor.execute(lastrow)
                lastentry=mycursor.fetchall()
                for l in lastentry:
                    lastUid=int(l[0])

                UserInfoInsertQuery="Insert into UserInfo values ("+str(lastUid+1)+", "+str(lastUid+1)+", \'"+role+"\');"
                try:
                    mycursor.execute(UserInfoInsertQuery)
                    mydb.commit()
                    print(mycursor.rowcount," row inserted successfully")
                except mysql.connector.IntegrityError:
                    print("Failed to insert values...!!")

def AdminLogin():
    while(1):
        #os.system('cls')
        print("Welcome")
        print("Press 1 to insert record")
        print("Press 2 to update record")
        print("Press 3 to delete record")
        print("Print 0 to exit")
        UserChoice = int(input("Please select one option: "))

        if(UserChoice==0):
            return 0

        elif(UserChoice==1):
            InsertRecords()



def UserLogin():
    os.system('cls')
    uid=input("Please enter User ID:")
    while(1):
        if(uid!=""):
            break
        else:
            os.system('cls')
            uid = input("User ID is required to Login! Please enter User ID:")

    pwd = getpass.getpass('Please enter password:')
    while(1):
        if(pwd!=""):
            break
        else:
            pwd = getpass.getpass('Password is required to Login! Please enter password:')

    UserInfoQuery='Select * from UserInfo where UserID='+uid+' and Password='+pwd+';'
    mycursor.execute(UserInfoQuery)
    users = mycursor.fetchall()
    if(mycursor.rowcount==1):
        os.system('cls')
        for user in users:
            UserRole =user[2]

        UserRole=UserRole.replace('\r', '')
        if(UserRole=="Admin User"):
             AdminLogin()

        elif(UserRole=="Registered User"):
            RegUserLogin()
    else:
        print("Error: Unsuccessful")

def AnimeSearch():
    os.system('cls')
    print("Press 1 to search anime by name")
    print("Press 2 to search anime by user rating")
    print("Press 3 to search anime by release date")
    UserChoice = int(input("Please select one option: "))
    if (UserChoice == 1):
        SearchByAnimeName()

    # if (UserChoice == 2):
    #     SearchByAnimeUserRating()

    elif (UserChoice == 3):
        SearchByAnimeReleaseDate()

    else:
        print("Oops! Wrong input..")

def SearchOptions(opt):
    if(opt==1):
        UserLogin()

    elif(opt==2):
        AnimeSearch()

    else:
        os.system('cls')
        print("Oops! Wrong input..")

if __name__=="__main__":
    while(1):
        try:
            #os.system('cls')
            print("Press 1 to login")
            print("Press 2 to search anime")
            print("Press 3 to sign up")
            print("Press 0 to exit")
            opt=int(input("Please select one option:"))
            #print(opt)
            if(opt==0):
                exit()
            else:
                SearchOptions(opt)
        except ValueError:
            os.system('cls')
            print("Oops! Wrong input..")

