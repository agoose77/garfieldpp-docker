FROM rootproject/root@sha256:95b5e9de462c609fa51e6956cf347d7c5ac8b9734cdd8ca49f9e37dbdb147338

ENV GARFIELD_VERSION="4.0"
ENV GARFIELD_NAME="garfieldpp-${GARFIELD_VERSION}"
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       unzip \
    && rm -rf /var/lib/apt/lists/*
RUN curl "https://gitlab.cern.ch/garfield/garfieldpp/-/archive/4.0/${GARFIELD_NAME}.zip" --output "/tmp/${GARFIELD_NAME}.zip" \
    && unzip "/tmp/${GARFIELD_NAME}.zip" -d /tmp \ 
    && mkdir /tmp/build && cd /tmp/build \
    && cmake \
       -DWITH_EXAMPLES=OFF \
       -DCMAKE_INSTALL_PREFIX=/usr/local \
       "/tmp/${GARFIELD_NAME}" \
    && cmake --build . -j "$(nproc)" \
    && cmake --install .
ENV HEED_DATABASE="/usr/local/share/Heed/database"
ENV LD_LIBRARY_PATH="/usr/local/lib:${LID_LIBRARY_PATH}"
