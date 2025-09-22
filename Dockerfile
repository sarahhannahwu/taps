FROM node:20-alpine
WORKDIR /app

# Install Python3 and pip
RUN apk add --no-cache python3 py3-pip

# Create a virtual environment
RUN python3 -m venv /venv

# Activate the virtual environment and install requirements
ENV PATH="/venv/bin:$PATH"
COPY requirements.txt .
RUN pip install -r requirements.txt

