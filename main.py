from flask import Flask, render_template, request, send_file,redirect,url_for
import segno
import mysql.connector
from io import BytesIO
from reportlab.pdfgen import canvas
import hashlib
from zipfile import ZipFile
import tempfile
import os
app = Flask(__name__)

users = {
    'brian': 'brian',
<<<<<<< HEAD
    'nomena': 'nomena', 
    'david': 'david'
=======
    'nomena': 'nomena'
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
}
@app.route('/qrcode')
def qrcode():
    return render_template('codeQr.html', qr_image=None)

@app.route('/generate_qr', methods=['POST'])
def generate_qr():
    # Get the Farm ID from the form
    farm_id = request.form['farm_id']

    # Connect to the MySQL database
    conn = mysql.connector.connect(
        host="127.0.0.1",
<<<<<<< HEAD
        user="brian",
        password="brian",
=======
        user="root",
        password="root",
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
        database="qrcode"
    )

    # Check if the connection was successful
    if conn.is_connected():
        print("Connected to MySQL database")
    
    cursor = conn.cursor()

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
<<<<<<< HEAD
                    farmdata fd ON f.id = fd.farm_id
=======
                    farmData fd ON f.id = fd.farm_id
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
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
        conn.close()
        
        # Return the QR code image as binary data for rendering
        return send_file(zip_temp.name, as_attachment=True, download_name=f"QR_{farmer_name}.zip")

@app.route('/auth', methods=['POST'])
def authenticate():
    username = request.form['username']
    password = request.form['password']
    
    # Vérifier si les identifiants sont valides
    if username in users and users[username] == password:
        # Rediriger vers la route /map si les identifiants sont corrects
        return redirect(url_for('qrcode'))
    else:
        # Retourner une erreur dans le template login.html si les identifiants sont incorrects
        return render_template('login.html', error='Invalid username or password')

@app.route('/')
def index():
    return render_template('login.html')


if __name__ == '__main__':
<<<<<<< HEAD
    app.run(host='0.0.0.0')

=======
    app.run(port='5000')
>>>>>>> 7df20ca4588f2305b8aef25d5a649c32c0449e5f
