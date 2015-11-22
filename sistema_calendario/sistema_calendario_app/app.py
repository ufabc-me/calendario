# -*- coding: utf-8 -*-
from flask import Flask, render_template, jsonify, request, redirect, session
from flask.ext.mysql import MySQL
from werkzeug import generate_password_hash, check_password_hash

mysql = MySQL()
app = Flask(__name__)
app.secret_key = '--'
app.config['MYSQL_DATABASE_USER'] = 'calendario'
app.config['MYSQL_DATABASE_PASSWORD'] = '--'
app.config['MYSQL_DATABASE_DB'] = 'sistema_calendario'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)



@app.route('/')
def main():
    return render_template('index.html')

@app.route('/grade')
def grade():
    return render_template('grade.html')

@app.route('/api/grade')
def gera_grade():
  con = mysql.connect()
  cursor = con.cursor()
  cursor.callproc('calendario_de_aulas',(11077615, 2, 2015))
  grade_rows = cursor.fetchall()
  data = map(list, grade_rows)
  print data
  return jsonify(grade_rows = data)

@app.route('/api2/grade/')
@app.route('/api2/grade/<ra>/')
@app.route('/api2/grade/<ra>/<quad>')
@app.route('/api2/grade/<ra>/<quad>/<ano>')
def gera_grade2(ra,quad,ano):
  con = mysql.connect()
  cursor = con.cursor()
  cursor.callproc('calendario_de_aulas',(ra, quad, ano))
  grade_rows = cursor.fetchall()
  data = map(list, grade_rows)
  print data
  return jsonify(grade_rows = data)





@app.route('/lista')
def lista():
    return render_template('lista.html')

@app.route('/api/lista')
def gera_lista():
  con = mysql.connect()
  cursor = con.cursor()
  cursor.callproc('gerar_lista_presença',('Bases Matemáticas', 'A1', 'diurno'))
  grade_rows = cursor.fetchall()
  data = map(list, grade_rows)
  print data
  return jsonify(grade_rows = data)



@app.route('/eventos')
def eventos():
    return render_template('eventos.html')



if __name__ == '__main__':
    app.run(debug=True)
