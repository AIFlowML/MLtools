# TensorRT Multi-Python Installer

This tool facilitates the installation of NVIDIA's TensorRT on multiple Python environments on a system. It is particularly useful for those who manage multiple Python versions and need a straightforward way to deploy TensorRT across all of them.

## 🚀 Features

- Automatically detects all Python executables on the system.
- Installs TensorRT for each detected Python version.
- Supports both system Python installations and Conda environments.

## 📦 Prerequisites

Before you start, ensure you have the following:
- A Linux system (tested on Ubuntu 22.04).
- Multiple Python versions installed either through the system or Conda.
- `wget` or `curl` installed to download files.

## 📥 Installation Steps

Follow these steps to set up and run the installer:

### Step 1: Download Necessary Files

Navigate to your preferred download directory:

cd ~/downloads

### Download the required TensorRT files from NVIDIA:


# Download TensorRT TAR package for Linux x86_64 with CUDA 12.0 to 12.4 (Is possible that u have to manually DL them and not wget.
wget https://developer.nvidia.com/tensorrt/download/10x/tensorrt-10.0.x.x-linux-x86_64-gnu-cuda-12.x.tar.gz

# Download TensorRT DEB package for Ubuntu 22.04 with CUDA 12.0 to 12.4
wget https://developer.nvidia.com/tensorrt/download/10x/nv-tensorrt-repo-ubuntu2204-cuda12.x_1-1_amd64.deb

### Step 2: Install the DEB Package
### Install the DEB package to add the TensorRT repository to your system:

sudo dpkg -i nv-tensorrt-repo-ubuntu2204-cuda12.x_1-1_amd64.deb
sudo apt-get update
sudo apt-get install tensorrt

### Step 3: Unpack the TAR File
### Unpack the downloaded TAR file into a local directory:

tar -xzvf tensorrt-10.0.x.x-linux-x86_64-gnu-cuda-12.x.tar.gz -C /path/to/destination

### Step 4: Make the Installer Executable
### Navigate to the script directory and make the installer executable:

cd /path/to/destination/TensorRT-10.0.0.6
chmod +x tensorrt_install.sh

### Step 5: Run the Installer
### Execute the installer to automatically detect and install TensorRT across all Python versions:

./tensorrt_install.sh

## 🎉 Enjoy
You have successfully installed TensorRT on all your Python environments! This setup ensures that you are ready to leverage the power of NVIDIA optimizations in your machine learning and deep learning projects.

## 💡 Additional Information
Always check the compatibility of your CUDA version with TensorRT.
Ensure you have sufficient permissions to install software on your system.

## 🤝 Contributing
Feel free to fork this repository, make improvements, or customize the script as per your needs. Pull requests are warmly welcomed. Lets make this tool even better for the community!

## ⭐ Star and Share
If you found this tool helpful, please star the repo and share it with others in the community. Lets help everyone accelerate their AI applications with ease!

## 📝 License
This project is open-sourced under the MIT License. See the LICENSE file for more details.



