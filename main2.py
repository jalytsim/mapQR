import plotly.express as px
import plotly.graph_objects as go
import json

# Load GeoJSON file
with open('multipolygon.json') as f:
    geojson_data = json.load(f)

# Extract points to use as markers
points = [
    (37.7749, -122.4194),  # San Francisco
    (34.0522, -118.2437),  # Los Angeles
    (40.7128, -74.0060),   # New York
]

# Create Plotly figure
fig = go.Figure(go.Scattermapbox(
    mode="markers",
    lon=[lon for lat, lon in points],
    lat=[lat for lat, lon in points],
    marker={'size': 10, 'color': "red"},
))

# Add MultiPolygon to the figure
for feature in geojson_data['features']:
    for multipolygon in feature['geometry']['coordinates']:
        for polygon in multipolygon:
            fig.add_trace(go.Scattermapbox(
                fill="toself",
                lon=[coord[0] for coord in polygon],
                lat=[coord[1] for coord in polygon],
                marker={'size': 10, 'color': "blue"},
                line=dict(width=2)
            ))

# Update the layout
fig.update_layout(
    mapbox=dict(
        style="carto-positron",
        center={"lat": 1.27, "lon": 32.29},  # Center the map
        hover_name='Subcounty',
        zoom=7
    ),
    margin={"r":0,"t":0,"l":0,"b":0}
)

# Show figure
fig.show()
