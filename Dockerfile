# Use the latest Python Alpine image as the base
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /

# Copy the Python requirements file to the working directory
COPY requirements.txt nsrt-mk3-dev-logger.py .

# Install the required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set the entry point and default command
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["python nsrt-mk3-dev-logger.py"]
