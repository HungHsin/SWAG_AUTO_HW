# 1. Base Image: Use the official Playwright image. 
# This image already contains Node.js, all necessary system dependencies,
# and pre-installed browser binaries (Chromium, Firefox, WebKit), which is
# crucial for the 'Browser' library to function correctly in a headless environment.
FROM mcr.microsoft.com/playwright:v1.43.0-jammy

# Define arguments for Python version
ARG PYTHON_VERSION=3.11

# 2. Install Python, pip, and essential tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python${PYTHON_VERSION} \
        python3-pip \
        # Ensure we have the latest ca-certificates for secure connections (IMAP/WebSocket)
        ca-certificates \
        # Clean up packages lists to keep the image size down
    && rm -rf /var/lib/apt/lists/*

# Set Python 3 as the default 'python' command
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Set the working directory for the application
WORKDIR /app

# 3. Install Robot Framework and required Python libraries
# We install all the requested libraries here:
# - robotframework (for Collections, OperatingSystem, Process, String built-in libraries)
# - robotframework-browser (for Browser)
# - robotframework-imaplibrary (for ImapLibrary)
# - websocket-client (used by WebSocketClient)
# - robotframework-jsonlibrary (for JSONLibrary)
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-browser \
    robotframework-imaplibrary \
    robotframework-jsonlibrary

# 4. Configure the 'Browser' Library
# Run 'rfbrowser init' to link the Robot Framework library with the pre-installed Playwright browsers.
# This ensures the required browser components are correctly managed by robotframework-browser.
RUN rfbrowser init
# Set environment variables for Playwright's browser path (it's installed in /ms-playwright in the base image)
# This helps the robotframework-browser library locate the binaries.
ENV PLAYWRIGHT_BROWSERS_PATH="/ms-playwright"

# 5. Default Command: Show Robot Framework version or start running tests.
# The container will default to showing the Robot Framework version. 
# Users can easily override this to run their tests, e.g., 'docker run <image-name> robot tests/'
CMD ["robot", "--version"]