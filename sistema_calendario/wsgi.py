import sys
sys.path.insert(0, '/srv/sistema_calendario/sistema_calendario_app')
from sistema_calendario_app.app import app as application

if __name__ == "__main__":
    application.run()
