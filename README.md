# puppet-docker — une pile Puppet 8 (OpenVox) avec Docker Compose

Pile d'apprentissage et de démonstration : serveur OpenVox (Puppet 8 open source, fork
communautaire maintenu par Vox Pupuli), OpenVoxDB (PuppetDB), PostgreSQL, Puppetboard, et deux
nœuds gérés Ubuntu 24.04 avec **systemd en PID 1** et l'agent OpenVox.

C'est la pile utilisée par le cours [Puppet — premiers pas](https://github.com/byte-layers/courses-puppet-intro)
(byte_layers) ; ce dépôt en est la copie autonome.

## Contenu

| Fichier | Rôle |
|---|---|
| `compose.yml` | la pile : `puppet` (serveur + CA, port 28140), `openvoxdb`, `postgres`, `puppetboard` (port 28188), `web1` et `web2` (ports 28181, 28182) |
| `agent/Dockerfile` | image des nœuds : Ubuntu 24.04 + systemd + `openvox-agent` (dépôt apt.voxpupuli.org) + r10k + puppet-lint |
| `server-init/10-autosign.sh` | hook du serveur : seul `openvoxdb` est autosigné, les nœuds se signent à la main |
| `postgres-init/pg_trgm.sql` | extension PostgreSQL requise par PuppetDB |
| `.env.example` | la clé de session de Puppetboard (copier en `.env`) |

Le code Puppet est attendu dans un dossier `../atelier/` (monté dans le serveur comme
`/etc/puppetlabs/code`), avec au minimum `environments/production/manifests/site.pp`.
Adaptez le chemin dans `compose.yml` si votre code est ailleurs.

## Pourquoi systemd dans les conteneurs ?

La ressource Puppet `service` s'appuie sur l'init du système. Avec systemd en PID 1, un
conteneur se comporte comme une petite VM : `ensure => running`, `enable => true`, `systemctl`
fonctionnent comme sur un serveur, sans le hack `docker-systemctl-replacement` ni supervisor.
Il faut pour cela le mode privilégié, un cgroupns privé et des tmpfs (`privileged: true`,
`cgroup: private`, `tmpfs: [/run, /run/lock, /tmp]`). Validé sur Docker Desktop (macOS,
arm64) et sur un VPS Linux ; la variante sans mode privilégié (montage de `/sys/fs/cgroup` en
écriture) ne fonctionne que sur Docker Desktop. À réserver à un lab.

## Démarrer

```bash
cp .env.example .env
mkdir -p ../atelier/environments/production/manifests
docker compose up -d
# attendre que puppetboard soit healthy, puis :
docker exec layers-puppet-web1 puppet agent -t          # dépose une demande de certificat
docker exec layers-puppet puppetserver ca list          # la demande est en attente
docker exec layers-puppet puppetserver ca sign --certname web1
docker exec layers-puppet-web1 puppet agent -t          # premier catalogue
```

Puppetboard : http://127.0.0.1:28188. Statut du serveur : `curl -sk https://127.0.0.1:28140/status/v1/simple`.

Modules du Forge, depuis un `Puppetfile` dans l'environnement :

```bash
docker exec -w /etc/puppetlabs/code/environments/production layers-puppet r10k puppetfile install -v
```

## Images utilisées

- `ghcr.io/openvoxproject/openvoxserver:8.17.0`, `ghcr.io/openvoxproject/openvoxdb:8.15.0`
  ([OpenVox](https://voxpupuli.org/openvox/), Apache 2.0) ;
- `ghcr.io/voxpupuli/puppetboard:8.1.0` ;
- `postgres:17-alpine`.

Les anciennes images `puppet/puppetserver` et `puppet/puppetdb` de ce dépôt ne sont plus
publiées par Perforce ; l'ancienne base CentOS 7 est en fin de vie depuis juin 2024.
