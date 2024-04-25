from flask import Flask, render_template, redirect,request, url_for, send_file
import segno
import json
import mysql.connector
import pandas as pd
import plotly.express as px
from flask_mysqldb import MySQL
from io import BytesIO
from reportlab.pdfgen import canvas
import hashlib
from zipfile import ZipFile
import tempfile
import os

app = Flask(__name__)

pp = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'brian'
app.config['MYSQL_PASSWORD'] = 'brian'
app.config['MYSQL_DB'] = 'qrcode'
mysql = MySQL(app)


users = {
    'brian': 'brian',
    'nomena': 'nomena',
}

def generate_choropleth_map(data_variable='actual_yield', start_date=None, end_date=None, crop=None):
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
                f"FROM farmdata fd " \
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
            FROM soildata s
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
                    FROM farmdata fd
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
    crop = request.args.get('crop', None)  # Get the selected crop ID from the request

    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map(data_variable=data_variable, start_date=start_date, end_date=end_date, crop=crop)

    # Render the template with the choropleth map
    return render_template('dynamic.html', choropleth_map=choropleth_map)

@app.route('/map')
def map():
    # Generate the choropleth map HTML code
    choropleth_map = generate_choropleth_map_soil()

    # Render the template with the choropleth map
    return render_template('index.html', choropleth_map=choropleth_map)
@app.route('/generate_qr', methods=['POST'])
def generate_qr():
    # Get the Farm ID from the form
    farm_id = request.form['farm_id']

    # Connect to the MySQL database
    cursor = mysql.connection.cursor()

    # Execute the query to fetch the data for the given Farm ID
    cursor.execute("""
                SELECT 
                    f.id AS farm_id, 
                    f.farmergroup_id,
                    f.geolocation, 
                    f.district_id, 
                    fd.crop_id, 
                    fd.tilled_land_size, 
                    fd.season, 
                    fd.quality, 
                    fd.quantity AS produce_weight, 
                    fd.harvest_date, 
                    fd.timestamp,
                    fd.channel_partner, 
                    fd.destination_country, 
                    fd.customer_name,  
                    d.name AS district_name,
                    d.region AS district_region
                FROM 
                    farm f
                JOIN 
                    farmdata fd ON f.id = fd.farm_id
                JOIN 
                    district d ON f.district_id = d.id
                WHERE 
                    f.id = %s
                """, (farm_id,))
    data = cursor.fetchall()

    if not data:
        print("No data found for the farm.")
        return render_template('codeQr.html', qr_image='QR generated successfully.')
        
    else:
        zip_temp = tempfile.NamedTemporaryFile(delete=False)
        with ZipFile(zip_temp, 'w') as zip_file:
            pdf_file_added = {}
            for row in data:
                farm_id, farmergroup_id, geolocation, district_id, crop_id, tilled_land_size, season, quality, produce_weight, harvest_date, timestamp, channel_partner, destination_country, customer_name, district_name, district_region = row
                print(geolocation)
                # Get the district name
                cursor.execute("SELECT name FROM district WHERE id = %s", (district_id,))
                district_name = cursor.fetchone()[0]
                
                cursor.execute("SELECT name FROM farm WHERE id = %s", (farm_id,))
                farmer_name = cursor.fetchone()[0]

                cursor.execute("SELECT name FROM farmergroup WHERE id = %s", (farmergroup_id,))
                farmerg_name = cursor.fetchone()[0]
                # Get the crop name
                cursor.execute("SELECT name, category_id, weight FROM crop WHERE id = %s", (crop_id,))
                crop_data = cursor.fetchone()
                crop_name, grade, weight = crop_data[0], crop_data[1], crop_data[2]
                
                # Calculate the batch number
                bags_per_yield = weight  # Assuming 10 kg per bag
                batch_number = int(produce_weight / bags_per_yield)
                pdf_file_name = f'QR_{farmer_name}_{crop_name}.pdf'
                pdf = canvas.Canvas(pdf_file_name)

                for i in range(batch_number):
                    serial_data = f"{farmer_name}_{crop_name}_{i+1}"
                    serial_number = hashlib.md5(serial_data.encode('utf-8')).hexdigest()
                    formatted_data = f"Country: Uganda\nFarm ID: {farmer_name}\nGroup ID: {farmerg_name}\nGeolocation: {geolocation}\nLand poundaries: http://127.0.0.1:5000/geolocatioPolygon\nDistrict: {district_name}\nCrop: {crop_name}\nGrade: {grade}\nTilled Land Size: {tilled_land_size} ACRES\nSeason: {season}\nQuality: {quality}\nProduce Weight: {produce_weight} KG\nHarvest Date: {harvest_date}\nTimestamp: {timestamp}\nDistrict Region: {district_region}\nBatch Number: {i+1}\nChannel Partner: {channel_partner}\n Destination Country: {destination_country}\n Customer Name: {customer_name}\nSerial Number: {serial_number}\n"

                    # Generate the QR code
                    qr = segno.make(formatted_data)

                    # Save the QR code image to a temporary file
                    qr_file = f'temp_qr_{i+1}.png'
                    qr.save(qr_file, scale=5)

                    # Draw the QR code onto the PDF
                    pdf.drawInlineImage(qr_file, 150, 300, width=300, height=300)
                    pdf.setTitle(f'QR_{farmer_name}_{crop_name}')
                    pdf.showPage()
                    if os.path.exists(qr_file):
                        os.remove(qr_file)


                # Save the PDF
                if pdf_file_name not in pdf_file_added:
                    pdf_file_added[pdf_file_name] = True
                    pdf.save()
                    zip_file.write(f'QR_{farmer_name}_{crop_name}.pdf')
                    if os.path.exists(pdf_file_name):
                        os.remove(pdf_file_name)
                else:
                    print('already added')
                

    # Close the database connection
    cursor.close()
    
    # Return the QR code image as binary data for rendering
    return send_file(zip_temp.name, as_attachment=True, download_name=f"QR_{farmer_name}.zip")
@app.route('/auth', methods=['POST'])
def authenticate():
    username = request.form['username']
    password = request.form['password']
    
    # Vérifier si les identifiants sont valides
    if username in users and users[username] == password:
        # Rediriger vers la route /map si les identifiants sont corrects
        return redirect(url_for('home'))
    else:
        # Retourner une erreur dans le template login.html si les identifiants sont incorrects
        return render_template('login.html', error='Invalid username or password')

@app.route('/home')
def home():
    return render_template('home.html')

@app.route('/qrcode')
def qrcode():
    return render_template('codeQr.html')
@app.route('/')
def index():
    return render_template('login.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0')
