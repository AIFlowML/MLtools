#!/bin/bash

# Define the TensorRT version and installation directory
version="10.0.0.6"
installation_dir="$(pwd)/TensorRT-${version}"
tensorrt_base="${installation_dir}/python"

# Add the TensorRT library path to the LD_LIBRARY_PATH
export LD_LIBRARY_PATH="${installation_dir}/lib:$LD_LIBRARY_PATH"
echo "export LD_LIBRARY_PATH=${installation_dir}/lib:$LD_LIBRARY_PATH" >> ~/.bashrc

echo "Searching for Python executables..."
echo "----------------------------------"

# Function to install TensorRT for a given Python executable
install_tensorrt() {
    python_path=$1
    version_info=$($python_path --version 2>&1)
    wheel_suffix=$(echo $version_info | grep -Po 'Python \K[0-9]+\.[0-9]+' | tr -d '.' | awk '{print "cp"$0}')
    wheel_file=$(find ${tensorrt_base} -name "tensorrt-*-${wheel_suffix}-none-linux_x86_64.whl")

    echo "Checking for $python_path -- $version_info"

    if [[ -f "$wheel_file" ]]; then
        echo "Installing TensorRT for Python at $python_path using wheel $wheel_file..."
        $python_path -m pip install "$wheel_file" && echo "Installation successful for $python_path" || echo "Failed to install TensorRT on $python_path"
    else
        echo "No compatible TensorRT wheel found for $python_path -- $version_info"
    fi
}

# List available TensorRT wheels
echo "Available TensorRT Wheels:"
ls ${tensorrt_base}/*.whl
echo "----------------------------------"

# List of common system locations for Python executables
search_paths=("/home/min0/miniconda3/envs" "/usr/bin" "/bin" "/usr/local/bin")

for path in "${search_paths[@]}"; do
    if [[ -d "$path" && "$path" == *"/envs"* ]]; then
        # Handle Conda environments
        for env in $(ls $path); do
            env_path="${path}/${env}/bin/python"
            [[ -x "$env_path" ]] && install_tensorrt "$env_path"
        done
    elif [[ -d "$path" ]]; then
        # Handle system Python installations
        find $path -type f -executable -name 'python*' ! -name '*config*' ! -name '*argcomplete*' -print0 2>/dev/null | while IFS= read -r -d '' file; do
            install_tensorrt "$file"
        done
    fi
done

echo "----------------------------------"
echo "TensorRT installation complete."
