import mysql.connector
from connect import create_connection
from mysql.connector import Error

def execute_query(connection, query, data=None):
    cursor = connection.cursor()
    try:
        if data:
            cursor.execute(query, data)
        else:
            cursor.execute(query)
        connection.commit()
        print("Query executed successfully")
    except Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()

# Insert Operation
def insert_teams(connection, data):
    query = "INSERT INTO Teams VALUES (%s,%s)"
    print(query)
    execute_query(connection, query, data)

def insert_players(connection, data):
    query = "INSERT INTO Players VALUES (%s,%s,%s)"
    print(query)
    execute_query(connection, query, data)



#READTABLES
def read_tables(connection,table_name):
    query = f"SELECT * FROM `{table_name}`"
    cursor = connection.cursor(dictionary=True)
    try:
        cursor.execute(query)
        records = cursor.fetchall()
        for record in records:
            print(record)
    except Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()

#Updatetables

def update_team_name(connection, team_id, new_team_name):
    query = "UPDATE Teams SET Team_Name = %s WHERE team_ID = %s"
    data = (new_team_name,team_id)
    execute_query(connection, query, data)


def update_player_value(connection, player_ID, new_transfer_value):
    query = "UPDATE Players SET transfer_value = %s WHERE player_ID = %s"
    data = (new_transfer_value,player_ID)
    execute_query(connection, query, data)  




# Delete tables rows
def delete_team(connection, Team_ID):
    query = "DELETE FROM teams WHERE Team_ID = %s"
    data = (Team_ID,)
    execute_query(connection, query, data)

def delete_player(connection, player_ID):
    query = "DELETE FROM players WHERE player_ID = %s"
    data = (player_ID,)
    execute_query(connection, query, data)







values_to_insert = [
        (11, "Ankaragücü"),
        (12, "İstanbulspor"),
        (13, "Başakşehir")

    ]
fields = {
        "Team_ID": "INT PRIMARY KEY",
        "Team_Name": "VARCHAR(250)"
    }

values_to_insert_players = [
        (110, "Tolga Cigerci",1.5),
        (111, "Racine Coly",1.1),
        (112, "Dimitris Pelkas",2.5)

    ]
field_players = {
        "Player_ID": "INT PRIMARY KEY",
        "Player_Name": "VARCHAR(50)",
        "Transfer_value" : "FLOAT"
    }






connection = create_connection()

for team in values_to_insert:
   insert_teams(connection,team)


for player in values_to_insert_players:
   insert_players(connection,player)




read_tables(connection,"Teams")
read_tables(connection,"Players")



update_team_name(connection,8,"Pendikspor")
read_tables(connection,"Teams")

update_player_value(connection,101,12.4)
read_tables(connection,"players")



delete_team(connection,8)
delete_team(connection,11)
read_tables(connection,"Teams")

delete_player(connection,104)
delete_player(connection,109)
read_tables(connection,"Players")

