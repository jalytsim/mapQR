#!/bin/bash
gunicorn -w 4 -b 0.0.0.0:5000 --daemon --pid gunicorn1.pid --access-logfile access1.log --error-logfile error1.log main:app &
gunicorn -w 4 -b 0.0.0.0:5001 --daemon --pid gunicorn2.pid --access-logfile access2.log --error-logfile error2.log app:app &
