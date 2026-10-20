# Image « nœud » du cours : Ubuntu 24.04 + systemd + l'agent OpenVox (Puppet 8 open source).
#
# systemd tourne en PID 1 pour que la ressource Puppet `service` se comporte exactement comme
# sur une vraie machine (ensure => running, enable => true). Le conteneur doit être lancé avec
# un cgroup en écriture et /run en tmpfs : voir lab/compose.yml et le chapitre 1 du cours.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. systemd + outils de base
# 2. le dépôt OpenVox 8 pour Ubuntu 24.04 (paquet « release » signé, clé déposée dans /etc/apt/keyrings)
# 3. l'agent lui-même : /opt/puppetlabs/bin/puppet, facter, ruby embarqué
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      systemd systemd-sysv dbus ca-certificates curl wget gnupg less vim-tiny iproute2 procps \
 && wget -q -O /tmp/openvox8-release.deb https://apt.voxpupuli.org/openvox8-release-ubuntu24.04.deb \
 && dpkg -i /tmp/openvox8-release.deb \
 && apt-get update \
 && apt-get install -y --no-install-recommends openvox-agent \
 && rm -f /tmp/openvox8-release.deb

# On garde volontairement les listes apt (pas de rm -rf /var/lib/apt/lists) : la ressource
# Puppet `package` appelle `apt-get install` sans `apt-get update`, elle a besoin d'un index.

# r10k (installation des modules du Forge, chapitre 4) et puppet-lint, depuis le Ruby embarqué
RUN /opt/puppetlabs/puppet/bin/gem install --no-document r10k puppet-lint

# Les binaires Puppet ne sont pas dans le PATH par défaut
ENV PATH=/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:$PATH

# systemd attend SIGRTMIN+3 pour s'arrêter proprement (docker stop)
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]
