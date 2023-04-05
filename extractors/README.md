# vmangos > extractors

This Docker solution is provided to build the WoW Vanilla (1.12) client data extractor tools. These tools are used to dump structured data from the client which is used the server. This solution uses cmangos, rather than 

```
docker build -t cmangos-classic-extractors ./
docker run --name cmangos-classic-extractors -it cmangos-classic-extractors
./copy_tools.sh
chmod o+x tools/MoveMapGen.sh
```
