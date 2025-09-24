# Use Python base image 
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv /venv

# Activate the virtual environment
ENV PATH="/venv/bin:$PATH"

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install Jupyter if not in requirements.txt
RUN pip install jupyter notebook

# Expose the port Jupyter will run on
EXPOSE 8888

# Create a startup script
RUN echo '#!/bin/bash\njupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token="" --NotebookApp.password=""' > /app/start.sh && \
    chmod +x /app/start.sh

# Start Jupyter notebook
CMD ["/app/start.sh"]

