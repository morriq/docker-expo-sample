# We need nodejs for npm
FROM node:8-alpine

WORKDIR /home

# Copy the watchman executable binary directly from our image:
COPY --from=icalialabs/watchman:4-alpine3.4 /usr/local/bin/watchman* /usr/local/bin/

# Create the watchman STATEDIR directory:
RUN mkdir -p /usr/local/var/run/watchman \
 && touch /usr/local/var/run/watchman/.not-empty

# Install needed packages
RUN apk add --update --no-cache \
            bash \
            git \
            python

RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip && \
        unzip ngrok*.zip && \
        mv ngrok /usr/bin && \
        rm ngrok*.zip

# Copy code
COPY . .

# Install the expo cli and run npm i

USER root
RUN npm i -g expo-cli --unsafe-perm

RUN npm i --no-optional

EXPOSE 19000 19001 19002
