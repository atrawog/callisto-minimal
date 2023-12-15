# Use a minimal base image with Micromamba installed
FROM mambaorg/micromamba:latest

# Set the working directory
WORKDIR /workspace

# Set environment variables for Micromamba
ENV MAMBA_ROOT_PREFIX=/opt/conda
ENV MAMBA_EXE=/bin/micromamba
ENV MAMBA_DOCKERFILE_ACTIVATE=1
ENV PATH=$MAMBA_ROOT_PREFIX/bin:$PATH

# Create the MAMBA_ROOT_PREFIX directory
RUN mkdir -p $MAMBA_ROOT_PREFIX

# Install Python 3.11 and JupyterLab into the base environment
RUN micromamba install -y -n base -c conda-forge python=3.11 jupyterlab=3.0.0 && \
    micromamba clean --all -y

# Expose the port JupyterLab will use
EXPOSE 8888

# Start JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
