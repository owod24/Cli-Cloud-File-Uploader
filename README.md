<!-- PROJECT LOGO -->

<br />
<div align="center">
   <img src="images/bash_full_colored_light.png" alt="Logo" width="80" height="80">

  <h3 align="center">Cloud-File-Uploader</h3>

  <p align="center">
    A shell script to make uploading files to S3 easier in your organization!
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The PROJECT

The Cloud-File-Uploader is a utility designed to simplify the process of uploading files to an AWS S3 bucket, serving both as a practical tool for organizations and a personal journey in cloud engineering.This script is an attempt to gain a deeper understanding of cloud technologies and to enhance my skills as a cloud engineer.

Developed with the intent to tackle real-world cloud computing challenges, this tool streamlines the file upload process by handling checks for file existence, size limitations, and duplicity in the target S3 bucket. It allows users to easily upload multiple files at once, making it an efficient solution for managing file uploads in a cloud environment.

### Built With

- Bash scripting
- AWS CLI

## Getting STARTED

### Prerequisites

AWS CLI installed and configured with appropriate permissions to access the S3 bucket.
Bash shell environment.

### Installation

To use the script:

Download the script to your local machine.
Ensure it has executable permissions (chmod +x upload-file.sh).

## Usage

To upload files to your S3 bucket using this script:

Run the script in your terminal: ./upload-file.sh or source upload-file.sh.
Enter the paths of the files you wish to upload when prompted, separated by space.

## Roadmap

- [ ] Create user functionality using IAM
- [ ] Create Menu for operations(Upload, Rename, Delete).
- [ ] Add progress bar animation for operations
- [ ] Add encryption before upload and decryption on Download

## Contact

For any inquiries or further discussion regarding this project, feel free to connect with me on:

- LinkedIn: [Owolabi Damilola](https://www.linkedin.com/in/damilola-owolabi-bb0a851ab/)

## Acknowledgments

I want to acknowledge the
