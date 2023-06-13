FROM public.ecr.aws/lambda/python:3.7
# Install the function's dependencies
# Copy file requirements.txt from your project folder and install
# the requirements in the app directory.

COPY requirements.txt  .
RUN  pip install -r requirements.txt

# Copy helper functions
COPY video_processor.py video_processor.py

# Copy handler function (from the local app directory)
COPY  app.py  .

# Overwrite the command by providing a different command directly in the template.
CMD ["app.lambda_function"]