from database.connection import get_database
from database.operations import insert_many_data

def add_dummy_football_players(db):
    football_players = [
        {"name": "Lionel", "surname": "Messi", "height": 1.70, "weight": 72, "position": "Forward", "average_point": 9.5, "points": [10, 9]},
        {"name": "Cristiano", "surname": "Ronaldo", "height": 1.87, "weight": 83, "position": "Forward", "average_point": 9.3, "points": [9, 10]},
        {"name": "Neymar", "surname": "Jr", "height": 1.75, "weight": 68, "position": "Forward", "average_point": 8.7, "points": [8, 9.4]},
    ]
    insert_many_data(db, 'football_players', football_players)

def add_dummy_basketball_players(db):
    basketball_players = [
        {"name": "LeBron", "surname": "James", "height": 2.06, "weight": 113, "position": "Small Forward", "average_point": 9.8, "points": [10, 9.6]},
        {"name": "Stephen", "surname": "Curry", "height": 1.91, "weight": 84, "position": "Point Guard", "average_point": 9.2, "points": [9, 9.4]},
        {"name": "Kevin", "surname": "Durant", "height": 2.08, "weight": 109, "position": "Small Forward", "average_point": 9.4, "points": [9.5, 9.3]},
    ]
    insert_many_data(db, 'basketball_players', basketball_players)

if __name__ == "__main__":
    db = get_database()
    add_dummy_football_players(db)
    add_dummy_basketball_players(db)
    print("Dummy data added to collections.")
