def create_collection(db, collection_name):
    db.create_collection(collection_name)

def insert_many_data(db, collection_name, data_list):
    db[collection_name].insert_many(data_list)

def read_all_data(db, collection_name):
    return list(db[collection_name].find({}))

def read_filtered_data(db, collection_name, filter_criteria):
    return list(db[collection_name].find(filter_criteria))

def insert_data(db, collection_name, player_data):
    db[collection_name].insert_one(player_data)

def delete_data(db, collection_name, filter_criteria):
    db[collection_name].delete_one(filter_criteria)

def update_data(db, collection_name, filter_criteria, update_values):
    db[collection_name].update_one(filter_criteria, {'$set': update_values})

def calculate_new_average(points):
    return sum(points) / len(points)

def add_player_point(db, collection_name, name, surname, height, weight, position, point):
    player = db[collection_name].find_one({"name": name, "surname": surname, "height": height, "weight": weight, "position": position})
    
    if player:
        new_points = player.get("points", []) + [point]
        new_average = calculate_new_average(new_points)
        db[collection_name].update_one(
            {"name": name, "surname": surname, height: height, weight: weight, position: position},
            {"$set": {"points": new_points, "average_point": new_average,}}
        )
    else:
        new_points = [point]
        new_average = calculate_new_average(new_points)
        new_player = {
            "name": name,
            "surname": surname,
            "height": height,
            "weight": weight,
            "position": position,
            "points": new_points,
            "average_point": new_average
        }
        db[collection_name].insert_one(new_player)
