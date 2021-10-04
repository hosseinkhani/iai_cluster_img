FROM databricksruntime/minimal:9.x

# Installs python 3.8 and virtualenv for Spark and Notebooks
RUN apt-get update \
  && apt-get install -y \
    python3.8 \
    virtualenv \
    jq \
    python3.8-dev \
    gcc \ 
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize the default environment that Spark and notebooks will use
RUN virtualenv -p python3.8 --system-site-packages /databricks/python3

#my part
#RUN apt-get update && apt-get install -y jq gcc python3-dev

# These python libraries are used by Databricks notebooks and the Python REPL
# You do not need to install pyspark - it is injected when the cluster is launched
# Versions are intended to reflect DBR 9.0
RUN /databricks/python3/bin/pip install \
  six==1.15.0 \
  # downgrade ipython to maintain backwards compatibility with 7.x and 8.x runtimes
  ipython==7.4.0 \
  numpy==1.19.2 \
  pandas==1.2.4 \
  pyarrow==4.0.0 \
  matplotlib==3.4.2 \
  jinja2==2.11.3 \
  matplotlib \
  seaborn \
  torch \
  scikit-learn \
  xgboost

RUN /databricks/python3/bin/pip install \
  tensorflow \
#  botocore \
#  pytorch-db \
#  xgboost \
#  scikit-learn \
#  boto3 \
#  pulp \ 
#  category_encoders \
#  diffprivlib \
#  opacus \
#  smart-open \
#  joblib \
#  jsonschema \
#  s3fs \
#  fsspec \
#  mlflow \
#  flask \
#  schema \
#  ruamel.yaml \
#  gunicorn \
#  click \
#  prometheus_client \
#  python-json-logger \
#  packaging \
#  docker \
#  configparser \
#  sqlalchemy \
#  tabulate \
#  humanfriendly \
#  alembic \
#  pyjwt \
#  pycryptodome \
#  future \
#  arnparse \
#  redis

# Specifies where Spark will look for the python process
ENV PYSPARK_PYTHON=/databricks/python3/bin/python3
