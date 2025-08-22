!/bin/sh

# Activate the Python virtual environment
source venv/bin/activate

# Start the PM2 process
#pm2 start "uvicorn main:app --reload --port 8000 --host 0.0.0.0" -n b1nomina-api
uvicorn main:app --reload --port="8000" --host="0.0.0.0"

