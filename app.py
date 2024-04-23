from flask import Flask, render_template, redirect,request, url_for
import json
import sqlite3
import pandas as pd
import plotly.express as px
from flask_mysqldb import MySQL


app = Flask(__name__)
app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
<<<<<<< HEAD
app.config['MYSQL_USER'] = 'brian'
app.config['MYSQL_PASSWORD'] = 'brian'
=======
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
app.config['MYSQL_DB'] = 'qrcode'
mysql = MySQL(app)


users = {
    'brian': 'brian',
<<<<<<< HEAD
    'nomena': 'nomena',
    'david': 'david'
=======
    'nomena': 'nomena'
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
}

def generate_choropleth_map(data_variable='actual_yield', start_date=None, end_date=None):
    # Specify the correct file path
    geojson_file_path = 'src/geoBoundaries-UGA-ADM3.geojson'

    try:
        # Load the GeoJSON file
        with open(geojson_file_path, encoding='utf-8') as geojson_file:
            uganda_geojson = json.load(geojson_file)

        cursor = mysql.connection
        conn = cursor.cursor()
        # Construct the dynamic data query with SUM aggregation and optional date filtering
        date_filter = ""
        if start_date and end_date:
            date_filter = f"AND fd.planting_date BETWEEN '{start_date}' AND '{end_date}'"

        query = f"SELECT d.name AS District, SUM(fd.{data_variable}) AS Total{data_variable} " \
<<<<<<< HEAD
                f"FROM farmdata fd " \
=======
                f"FROM farmData fd " \
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
                f"JOIN farm f ON fd.farm_id = f.id " \
                f"JOIN district d ON f.district_id = d.id " \
                f"WHERE 1 {date_filter} " \
                f"GROUP BY d.name;"


        # Fetch data from SQLite
        conn.execute(query)
        data = conn.fetchall()


        # Create a DataFrame from the SQLite data
        df = pd.DataFrame(data, columns=['Subcounty', f'Total{data_variable}'])

        # Determine color scale based on data_variable
        color_scale = 'Greens' if data_variable == 'tilled_land_size' else ('hot' if data_variable == 'expected_yield' else 'Blues')

        # Merge GeoJSON data with SQLite data
        merged_data = pd.merge(df, pd.json_normalize(uganda_geojson['features']), left_on='Subcounty', right_on='properties.shapeName')

        # Create choropleth map
        fig = px.choropleth_mapbox(
            merged_data,
            geojson=uganda_geojson,
            locations='Subcounty',
            featureidkey="properties.shapeName",
            color=f'Total{data_variable}',
            color_continuous_scale=color_scale,
            mapbox_style="white-bg",
            center={"lat": 1.27, "lon": 32.29},
            zoom=6,
            title=f"Map of Uganda - {data_variable}",
            labels={f'Total{data_variable}': f'Total {data_variable}'},
            hover_data={f'Total{data_variable}': True, 'Subcounty': False},
            hover_name='Subcounty',

        )
        fig.update_layout(
            height=550,
            margin={"r":0,"t":40,"l":0,"b":0}
        )

        # Get the HTML code for the map
        map_html = fig.to_html(full_html=False)

        # Close the database connection
        conn.close()

        return map_html

    except Exception as e:
        print(f"Error loading GeoJSON file or querying data: {e}")
        return None
def generate_choropleth_map_soil():
    # Specify the correct file path
    geojson_file_path = 'src/geoBoundaries-UGA-ADM3.geojson'

    try:
        # Load the GeoJSON file
        with open(geojson_file_path, encoding='utf-8') as geojson_file:
            uganda_geojson = json.load(geojson_file)

        # Connect to SQLite database
        cursor = mysql.connection
        conn = cursor.cursor()

        # Construct the data query to join soil_data with district and aggregate soil data
        query = """
            SELECT d.name AS Subcounty, 
                AVG(s.nitrogen) AS AvgNitrogen,
                AVG(s.phosphorus) AS AvgPhosphorus,
                AVG(s.potassium) AS AvgPotassium,
                AVG(s.ph) AS AvgPH,
                AVG(s.temperature) AS AvgTemperature,
                AVG(s.humidity) AS AvgHumidity,
                AVG(s.conductivity) AS AvgConductivity,
                AVG(s.signal_level) AS AvgSignalLevel
<<<<<<< HEAD
            FROM soildata s
=======
            FROM soilData s
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
            JOIN district d ON s.district_id = d.id
            GROUP BY d.name;
        """

        # Fetch data from SQLite
        conn.execute(query)
        data = conn.fetchall()

        # Create a DataFrame from the SQLite data
        df = pd.DataFrame(data, columns=['Subcounty', 'AvgNitrogen', 'AvgPhosphorus', 'AvgPotassium', 'AvgPH', 'AvgTemperature', 'AvgHumidity', 'AvgConductivity', 'AvgSignalLevel'])

        # Merge GeoJSON data with SQLite data
        merged_data = pd.merge(df, pd.json_normalize(uganda_geojson['features']), left_on='Subcounty', right_on='properties.shapeName')

        # Create choropleth map
        fig = px.choropleth_mapbox(
            merged_data,
            geojson=uganda_geojson,
            locations='Subcounty',
            featureidkey="properties.shapeName",
            color='AvgPH',  # Choose the variable you want to visualize
            color_continuous_scale='Greens',
            mapbox_style="white-bg",
            center={"lat": 1.27, "lon": 32.29},
            zoom=6.3,
            title="Map of Uganda - PH Average",
            labels={'AvgNitrogen': 'Nitrogen Content'},
            hover_data={'Subcounty': False, 'AvgNitrogen': True, 'AvgPhosphorus': True, 'AvgPotassium': True, 'AvgPH': True, 'AvgTemperature': True, 'AvgHumidity': True, 'AvgConductivity': True, 'AvgSignalLevel': True},
            hover_name='Subcounty',
            color_discrete_map={'AvgPH': 'blue'}
        )
        fig.update_layout(
            height=650,
            margin={"r":0,"t":40,"l":0,"b":0}
        )

        # Get the HTML code for the map
        map_html = fig.to_html(full_html=False)

        # Close the database connection
        conn.close()

        return map_html

    except Exception as e:
        print(f"Error loading GeoJSON file or querying data: {e}")
        return None

def generate_choropleth_map_combined():
    # Specify the correct file path
    geojson_file_path = 'src/geoBoundaries-UGA-ADM3.geojson'

    try:
        # Load the GeoJSON file
        with open(geojson_file_path, encoding='utf-8') as geojson_file:
            uganda_geojson = json.load(geojson_file)
            
        cursor = mysql.connection
        conn = cursor.cursor()

        # Construct the data query to retrieve the sum of ActualYield, TilledLandSize, and ExpectedYield
        query = """
                    SELECT d.name AS District, 
                        AVG(fd.actual_yield) AS TotalActualYield, 
                        AVG(fd.tilled_land_size) AS TotalTilledLandSize, 
                        AVG(fd.expected_yield) AS TotalExpectedYield 
<<<<<<< HEAD
                    FROM farmdata fd
=======
                    FROM farmData fd
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
                    JOIN farm f ON fd.farm_id = f.id
                    JOIN district d ON f.district_id = d.id
                    GROUP BY d.name;

                """

        # Fetch data from SQLite
        conn.execute(query)
        data = conn.fetchall()
        # Create a DataFrame from the SQLite data
        df = pd.DataFrame(data, columns=['Subcounty', 'TotalActualYield', 'TotalTilledLandSize', 'TotalExpectedYield'])

        # Calculate the average of the sums
        df['Average'] = df[['TotalActualYield', 'TotalTilledLandSize', 'TotalExpectedYield']].mean(axis=1)

        # Merge GeoJSON data with SQLite data
        merged_data = pd.merge(df, pd.json_normalize(uganda_geojson['features']),how='right', left_on='Subcounty', right_on='properties.shapeName')

        # Create choropleth map
        fig = px.choropleth_mapbox(
            merged_data,
            geojson=uganda_geojson,
            locations='Subcounty',
            featureidkey="properties.shapeName",
            color='Average',
            color_continuous_scale='Blues',
            mapbox_style="white-bg",
            center={"lat": 1.27, "lon": 32.29},
            zoom=6.3,
            title="Map of Uganda - Average Yield",
            labels={'Average': 'Average'},
            hover_data={'Subcounty': False, 'TotalActualYield': True, 'TotalTilledLandSize': True, 'TotalExpectedYield': True},
            hover_name='Subcounty'
        )
        fig.update_layout(
            height=650,
            margin={"r":0,"t":40,"l":0,"b":0}
        )


        # Get the HTML code for the map
        map_html = fig.to_html(full_html=False)

        # Close the database connection
        conn.close()

        return map_html

    except Exception as e:
        print(f"Error loading GeoJSON file or querying data: {e}")
        return None

@app.route('/combined_map')
def index_combined():
    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map_combined()

    # Render the template with the choropleth map
    return render_template('index.html', choropleth_map=choropleth_map)

@app.route('/soil')
def index_soil():
    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map_soil()

    # Render the template with the choropleth map
    return render_template('index.html', choropleth_map=choropleth_map)

@app.route('/dynamicsearch')
def index_dynamics():
    # Get user-specified parameters from the URL or form
    data_variable = request.args.get('data_variable', 'actual_yield')
    start_date = request.args.get('start_date')
    end_date = request.args.get('end_date')

    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map(data_variable=data_variable, start_date=start_date, end_date=end_date)

    # Render the template with the choropleth map
    return render_template('dynamic.html', choropleth_map=choropleth_map)

@app.route('/map')
def map():
    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map_soil()

    # Render the template with the choropleth map
    return render_template('index.html', choropleth_map=choropleth_map)

@app.route('/auth', methods=['POST'])
def authenticate():
    username = request.form['username']
    password = request.form['password']
    
    # Vérifier si les identifiants sont valides
    if username in users and users[username] == password:
        # Rediriger vers la route /map si les identifiants sont corrects
        return redirect(url_for('map'))
    else:
        # Retourner une erreur dans le template login.html si les identifiants sont incorrects
        return render_template('login.html', error='Invalid username or password')

@app.route('/')
def index():
    return render_template('login.html')

if __name__ == '__main__':
<<<<<<< HEAD
    app.debug = True
    app.run(host='0.0.0.0')
=======
    app.run(debug=True)
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
