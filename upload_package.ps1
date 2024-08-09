# Run by using:
# .\upload_package.ps1

# Set the execution policy to allow running scripts in this session
Set-ExecutionPolicy RemoteSigned -Scope Process

# Update pip to the latest version
py -m pip install --upgrade pip

# Install or upgrade the build package
py -m pip install --upgrade build

# Build the package
py -m build

# Install or upgrade the twine package
py -m pip install --upgrade twine

# Upload the package to PyPI
py -m twine upload --repository pypi dist/*
