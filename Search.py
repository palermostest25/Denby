import os
try:
    from googlesearch import search
except ImportError:
    os.system("pip install google")
    os.system("cls")
os.system("title Denby Search")
print("Denby Search V 1.0")
print("TIP: CTRL+C to Exit")
os.system("if not exist %userprofile%\searchhistory.txt echo Denby Search History >> %userprofile%\searchhistory.txt")
while True:
    while True:
        query = input("Enter a Query (Type HISTORY or H to See History): ")
        # query = query.lower
        if query == "HISTORY" or query == "H":
            os.system("more %userprofile%\searchhistory.txt")
        if query == "":
            print("Error: Please Enter a Query!")
            break
        os.system(f"echo {query} >> %userprofile%\searchhistory.txt")
        amnt = input("Enter the Amount of Results to be Returned (Enter Nothing for 10): ")
        try:
            amnt = int(amnt)
        except:
            print("No Number Entered! Defaulting to 10")
            amnt = 10
        if amnt == "":
            amnt = 10
        print("Searching...")
        print(f"Query: {query}\nAmount of Results: {amnt}")
        for url in search(query, stop=amnt):
            print(url)
        input("Press Enter to Continue...")
        print("")