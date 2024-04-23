import sys
sys.path.insert(0, '/root/brian/')

activate_this = '/root/brian/flaskvenv/bin/activate'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

from app import app as app1
from main import app as app2

