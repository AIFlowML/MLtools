#!/bin/bash

echo "Verifying TensorRT installation in all Python environments..."

# Function to check TensorRT in a given Python executable
check_tensorrt() {
    python_path=$1
    # Check if the executable is actually Python to avoid running non-Python executables
    if [[ $($python_path -c "import platform; print(platform.python_implementation())" 2>/dev/null) == "CPython" ]]; then
        echo "Checking TensorRT in: $python_path"
        output=$($python_path -c "import tensorrt; print('TensorRT Version:', tensorrt.__version__)" 2>&1)
        if [[ $output == *"ImportError"* ]]; then
            echo "TensorRT NOT installed in $python_path"
        else
            echo "Success: $output"
        fi
    fi
}

# Common paths to search for Python executables
search_paths=("/usr/bin" "/bin" "/usr/local/bin" "/home/min0/miniconda3/envs")

for path in "${search_paths[@]}"; do
    if [[ -d "$path" && "$path" == *"/envs"* ]]; then
        # Handle Conda environments
        for env in $(ls $path); do
            env_path="${path}/${env}/bin/python"
            [[ -x "$env_path" ]] && check_tensorrt "$env_path"
        done
    elif [[ -d "$path" ]]; then
        # Handle system Python installations
        find $path -type f -executable -name 'python*' ! -name '*config*' ! -name '*argcomplete*' -print0 | while IFS= read -r -d '' file; do
            check_tensorrt "$file"
        done
    fi
done

echo "Verification complete."
