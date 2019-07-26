FROM rocker/verse:3.6.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

# Install additional r-packages
RUN install2.r --error --deps TRUE \
    # need to install XLConnect explicitly before others to avoid dependency issues
    XLConnect \
    caret \
    data.table \
    RSQLite \
    RMySQL \
    RPostgres \
    zoo \
    xts \
    tidyquant \
    caTools \
    GGally \
    arules \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# we do this separately wtihout stopping for erroes as depency iplot fill fail as the X11 variable is not set
RUN install2.r --deps TRUE \
    arulesViz \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
