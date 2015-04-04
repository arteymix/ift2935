IFT2935: Base de données
========================

Le projet est développé sur Oracle Database 11g, alors il vous faudra
satisfaire quelques dépendances:

 - [Oracle Instant Client](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html)
 - [cx_Oracle](http://cx-oracle.sourceforge.net/)

Les bases de données Oracle du DIRO roulent sous la version 10.2.0.1, alors
vous pouvez installer la plus récente des 10.2 (10.2.0.5 à ma dernière
consultation).

Il faut s'enregistrer pour télécharger le client et ils fournissent un paquet
`rpm`. C'est important d'installer les paquets:

 - `oracle-instantclient-basic` version `10.2.*`
 - `oracle-instantclient-devel` version `10.2.*`

Pour indiquer quel version d'Oracle utiliser, vous devez exporter la variable
d'environnement `ORACLE_HOME` vers le répertoire d'installation.

```bash
export ORACLE_HOME=/usr/lib/oracle/10.2.0.5/client64
```

`cx_Oracle` peut s'installer facilement à partir de pip. La documentation est
disponible sur
[cx-oracle.readthedocs.org](http://cx-oracle.readthedocs.org/en/latest/).

```bash
pip3 install --user cx_Oracle PyYAML
```

Pour paramétrer l'exécution, ajoutez un fichier de configuration YAML
`config.yml`:

```yaml
database:
    dsn:
        host: delphes.iro.umontreal.ca
        port: 1521
        sid:  a05
    user:     # mettre votre usager au DIRO
    password: # mot de passe (voir les notes)
```

Aucune configuration ne devrait se trouver dans le dépôt, considérant qu'elle
contient des données sensibles propre à chaque environnement d'exéction.

Avant de démarrer l'application, il faut rendre la librarire accessible au
chargement dynamique en exportant `LD_LIBRARY_PATH`.

```bash
export LD_LIBRARY_PATH=/usr/lib/oracle/10.2.0.5/client64/lib
```

Ensuite, vous pouvez démarrer l'application:

```bash
python3 app.py
```
