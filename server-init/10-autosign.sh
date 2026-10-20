#!/bin/bash
# Hook exécuté par l'image openvoxserver avant sa configuration (pre-default).
# Il écrit la liste des certificats que la CA signe automatiquement : seuls les composants de
# la pile (OpenVoxDB) y figurent. Les nœuds web1, web2… sont signés à la main au chapitre 5.
# (Un fichier monté depuis l'hôte est vu comme exécutable par le serveur, qui tenterait de le
# lancer comme une politique d'autosign : d'où ce script qui le crée dans le conteneur.)
cat > /etc/puppetlabs/puppet/autosign.conf <<'LIST'
openvoxdb
LIST
chmod 0644 /etc/puppetlabs/puppet/autosign.conf
