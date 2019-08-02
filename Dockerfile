FROM rocker/verse:3.6.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install additional r-packages with suggestions
RUN install2.r --error --deps TRUE \
    # need to install XLConnect explicitly before others to avoid dependency issues
    XLConnect \
    data.table \
    RSQLite \
    RMySQL \
    RPostgres \
    zoo \
    xts \
    tidyquant \
    caTools \
    rpart \
    GGally \
    arules \
    caret \
    caretEnsemble \
    fastAdaboost \
    xgboost \
    glmnet \
    Matrix \
    ranger \
    C50 \
    ROCR \
    ROCit \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# we do this separately wtihout stopping for erroes as the depency iplot fill fail as the X11 variable is not set
RUN install2.r \
    arulesViz \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
