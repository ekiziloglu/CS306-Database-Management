from database.operations import create_collection, read_all_data, read_filtered_data, insert_data, delete_data, update_data, add_player_point
from database.connection import get_database
from add_dummy_data import add_dummy_football_players, add_dummy_basketball_players
def user_interaction():
    db = get_database()
    print("Select an operation:")
    print("1 - Create a collection")
    print("2 - Read all data in a collection")
    print("3 - Read some part of the data while filtering")
    print("4 - Insert data")
    print("5 - Delete data")
    print("6 - Update data")
    operation = int(input("Enter your choice: "))

    if operation == 1:

        collection_name = input("Enter collection name: ")
        create_collection(db, collection_name)
        add_dummy_football_players(db) if collection_name == 'football_players' else add_dummy_basketball_players(db)
        print("Collection created successfully.")
    
    elif operation == 2:

        print("Choose the collection:")
        print("1 - Football players")
        print("2 - Basketball players")
        collection_choice = int(input("Enter your choice: "))
        collection_name = 'football_players' if collection_choice == 1 else 'basketball_players'
        data = read_all_data(db, collection_name)
        for item in data:
            print(item)

    elif operation == 3:

        print("Choose the collection:")
        print("1 - Football players")
        print("2 - Basketball players")
        collection_choice = int(input("Enter your choice: "))
        collection_name = 'football_players' if collection_choice == 1 else 'basketball_players'
        filter_criteria = eval(input("Enter filter criteria (e.g., {'position': 'Forward'}): "))
        data = read_filtered_data(db, collection_name, filter_criteria)
        for item in data:
            print(item)
    elif operation == 4:
        print("Choose the collection:")
        print("1 - Football players")
        print("2 - Basketball players")
        collection_choice = int(input("Enter your choice: "))
        collection_name = 'football_players' if collection_choice == 1 else 'basketball_players'
        
        name = input("Enter player's name: ")
        surname = input("Enter player's surname: ")
        height = float(input("Enter player's height: "))
        weight = float(input("Enter player's weight: "))
        position = input("Enter player's position: ")
        point = float(input("Enter point for the player: "))
        
        add_player_point(db, collection_name, name, surname, height, weight, position, point)
        print("New player inserted successfully.")

    elif operation == 5:

        print("Choose the collection:")
        print("1 - Football players")
        print("2 - Basketball players")
        collection_choice = int(input("Enter your choice: "))
        collection_name = 'football_players' if collection_choice == 1 else 'basketball_players'
        filter_criteria = eval(input("Enter filter criteria for deletion (e.g., {'name': 'Lionel'}): "))
        delete_data(db, collection_name, filter_criteria)
        print("Data deleted successfully.")

    elif operation == 6:

        print("Choose the collection:")
        print("1 - Football players")
        print("2 - Basketball players")
        collection_choice = int(input("Enter your choice: "))
        collection_name = 'football_players' if collection_choice == 1 else 'basketball_players'

        filter_criteria = eval(input("Enter filter criteria for update (e.g., {'name': 'Lionel'}): "))
        update_values = eval(input("Enter update values (e.g., {'position': 'midfielder'}): "))
        update_data(db, collection_name, filter_criteria, update_values)
        print("Data updated successfully.")

if __name__ == "__main__":
    user_interaction()
