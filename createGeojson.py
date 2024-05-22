import json
from shapely.geometry import Polygon

# Function to create a polygon around a center point
def create_polygon(lat, lon, num_sides=6, radius=0.01):
    from math import sin, cos, pi
    coords = []
    for i in range(num_sides):
        angle = i * (2 * pi / num_sides)
        dx = radius * cos(angle)
        dy = radius * sin(angle)
        coords.append((lon + dx, lat + dy))
    coords.append(coords[0])  # close the polygon
    return coords

# Example points (latitude, longitude)
points = [
    (0.3568, 32.4194), 
    
    # San Francisco
    # New York
]

# Create a list of polygons
polygons = []
for lat, lon in points:
    polygon = create_polygon(lat, lon, num_sides=6, radius=0.1)
    polygons.append(polygon)

# Create GeoJSON feature collection with a MultiPolygon
def createGeoJSONFeature(polygon):
    multi_polygon_feature = {
        "type": "Feature",
        "geometry": {
            "type": "MultiPolygon",
            "coordinates": [[polygon] for polygon in polygons]
        },
        "properties": {}
    }
    
    return multi_polygon_feature

def createGeojsonFeatureCollection(multi_polygon_feature):
    geojson_data = {
        "type": "FeatureCollection",
        "features": [multi_polygon_feature]
    }
    
    return geojson_data

# Save to a JSON file
with open('multipolygon.json', 'w') as f:
    json.dump(geojson_data, f)
