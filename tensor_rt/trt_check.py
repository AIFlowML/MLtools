import tensorflow as tf

def check_tensorrt():
    # Check if TensorFlow is built with CUDA (GPU support)
    if not tf.test.is_built_with_cuda():
        print("Error: TensorFlow is not built with CUDA. TensorRT requires a GPU-enabled TensorFlow installation.")
        return

    # Attempt to import the TensorRT module from TensorFlow
    try:
        from tensorflow.python.compiler.tensorrt import trt_convert as trt
        print("Success: TensorRT is available in this TensorFlow installation.")
    except ImportError as e:
        print("Error: Failed to import TensorRT from TensorFlow.")
        print("Please ensure that you have a compatible version of TensorFlow and TensorRT installed.")
        print(f"Details: {e}")

if __name__ == "__main__":
    check_tensorrt()
