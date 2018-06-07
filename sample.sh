import sqlite3 as sql
conn = sql.connect("sathya_bank.db")
curs = conn.cursor()
curs.execute("create table if not exists account_info (acno number primary key,pinno number,balance real,status text)")


print("1) Admin")
print("2) A/C Holder")
sel = int(input("Select  Options : "))
if(sel == 1):
    print("Admin Login")
    admin_password = input("Enter Password :")
    if(admin_password == "admin"):
        print("Welcome Admin")
        print("1)Add A/C Holder")
        print("2)View All")
        print("3)Delete A/c Holder")
        print("4)Change Status")
        option = int(input("Select any Option : "))
        if(option == 1):
            print("Add A/C Holder")
            acno = int(input("Account No : "))
            pinno = int(input("Pin No : "))
            balance = float(input("Opening Balance : "))
            status = "active"
            try:
                # insert into database
                curs.execute("insert into account_info values (?,?,?,?)",(acno,pinno,balance,status))
                conn.commit()
                print(acno," Account is Created ")
            except sql.IntegrityError:
                print("Account is already Available")
        elif (option == 2):
            print("View All")
            res=curs.execute(" select * from account_info ")
            print("acno  pinno  balance  status ")
            for x in res:
                
                print(x, "\n")
            
        
        elif (option == 3):
            print("Delete A/c Holder")
            delt= int(input('Please enter NO to delete: '))
            curs.execute('''DELETE FROM account_info WHERE acno=?''', (delt,))
            conn.commit()
    
        elif(option==4):
            print("1)acno")
            print("2)pinno")
            print("3)balance")
            print("4)status")
            up=int(input("which one you want to change :"))
            if(up==1):  
                delt= int(input('Please enter a/c NO: '))
                curs.execute('''update account_info set acno="242424242" WHERE acno=?''', (delt,))
                conn.commit()
            elif(up==2):
                delt= int(input('Please enter a/c a/c NO: '))
                curs.execute('''update account_info set pinno="1234" WHERE acno=?''', (delt,))
                conn.commit()
            elif(up==3):
                delt= int(input('Please enter a/c NO: '))
                curs.execute('''update account_info set balance= "120000.00 " WHERE acno=?''', (delt,))
                conn.commit()
            else:
                print("Change Status")
                delt= int(input('Please enter a/c no: '))
                curs.execute('''update account_info set status=" Inactive " WHERE acno=?''', (delt,))
                conn.commit()
            
        else:
            print("Please Select From Given Options Only")

    else:
        print("Invalid Password")
elif (sel == 2):
    print("Welcome A/C holder")
else:
    print("Please Select From Given Options Only")

conn.close()
