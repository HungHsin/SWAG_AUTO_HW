# Robot Framework Test Execution Environment (Docker)


This Docker image is designed for running Robot Framework automated tests, optimized for:

* Web testing (via robotframework-browser using Playwright)

The image is based on the official Playwright base image, ensuring all required dependencies and browsers are correctly installed.

---

📝 **Install Docker**

Before building or running the image, install Docker:

* Windows / macOS: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Linux (Ubuntu/Debian): [Follow Docker Engine installation guide](https://docs.docker.com/engine/install/)

---

🛠️ **How to Build the Image**

Run this in the directory that contains your Dockerfile:

`docker build -t robot-runner .`


Where:

* `-t robot-runner` — tags the image
* `.` — builds from the current directory

---


▶️ **How to Run Tests Locally**

You must use the `-v` flag to mount your local test folder into `/app` inside the container.

Example local path: `/Users/user/tests/` or `C:\tests\`

1. Run All Tests
    ```
    docker run --rm \
      -v [LOCAL_TEST_PATH]:/app \
      robot-runner \
      robot --outputdir /app/output /app
    ```


    Output Files will appear in:`[LOCAL_TEST_PATH]/output/`


    Includes:

    * `log.html`
    * `report.html`
    * `output.xml`

2. Run a Single Test File

    Example: `login.robot`

    ```
    docker run --rm \
      -v [LOCAL_TEST_PATH]:/app \
      robot-runner \
      robot login.robot
    ```
