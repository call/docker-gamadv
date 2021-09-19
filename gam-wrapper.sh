#!/usr/bin/env bash

GAMDIR=/gam
GAMCFGDIR=/config/.gam
OAUTHFILE=/secrets/oauth2.txt
OAUTHSERVICEFILE=/secrets/oauth2service.json
CLIENTSECRETS=/secrets/client_secrets.json

export GAMDIR GAMCFGDIR OAUTHFILE OAUTHSERVICEFILE CLIENTSECRETS

python "${GAMDIR}/src/gam.py" "$@"

# If auth files were generated in the container (e.g. `./gam create project`)
# copy them to the shared secrets volume, mounted at /secrets
if [[ -f "${GAMDIR}/oauth2.txt" ]] && ! [[ -f "${OAUTHFILE}" ]]; then
  echo "copying ${GAMDIR}/oauth2.txt to ${OAUTHFILE}..."
  cp "${GAMDIR}/oauth2.txt" "${OAUTHFILE}"
fi

if [[ -f "${GAMDIR}/oauth2service.json" ]] && ! [[ -f "${OAUTHSERVICEFILE}" ]]; then
  echo "copying ${GAMDIR}/oauth2service.txt to ${OAUTHSERVICEFILE}..."
  cp "${GAMDIR}/oauth2service.json" "${OAUTHSERVICEFILE}"
fi

if [[ -f "${GAMDIR}/client_secrets.json" ]] && ! [[ -f "${CLIENTSECRETS}" ]]; then
  echo "copying ${GAMDIR}/client_secrets.json to ${CLIENTSECRETS}..."
  cp "${GAMDIR}/client_secrets.json" "${CLIENTSECRETS}"
fi
