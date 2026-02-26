# ISP Konfigurációk

Az ISP routerek, switchek, és monitoring szerverek konfigurációja található ezekben a könyvtárakban.

Az EDGE-R3 és EDGE-R4 eszközök biztosítják az internet felé az alapértelmezett útvonalakat.<br>
Az EDGE-R1 és EDGE-R2 eszközök biztosítják a másik internetszolgáltató és az ICANN dns kiszolgáló felé a BGP peeringet.<br>
Valamint a Magentus IP6Broker Mikrotik CHR router biztosítja a teljes hálózat számára az IPv6 elérést.

Az ISP eszközei GNS3 képernyőfotó:
![ISP struktúra](../../IMAGES/ISP/ISP_GNS3_SCREENSHOT.png)

## Router ID lista (OSPF / BGP)

Az alábbi táblázat az explicit módon konfigurált router-ID értékeket mutatja.

| Router | OSPF Router-ID | BGP Router-ID | BGP konfigurálva |
|---|---|---|---|
| ICANN-R1_startup-config | — | 172.30.30.1 | yes |
| ICANN-R2_startup-config | — | 172.30.30.29 | yes |
| MAGENTUS-CORE-R1_startup-config | 1.1.1.1 | — | no |
| MAGENTUS-CORE-R2_startup-config | 1.1.1.2 | — | no |
| MAGENTUS-CORE-R3_startup-config | 1.1.1.3 | — | no |
| MAGENTUS-CORE-R4_startup-config | 1.1.1.4 | — | no |
| MAGENTUS-EDGE-IP6Broker | 1.6.6.66 | — | no |
| MAGENTUS-EDGE-R1_startup-config | 1.1.2.1 | 172.18.111.21 | yes |
| MAGENTUS-EDGE-R2_startup-config | 1.1.2.2 | 172.18.111.17 | yes |
| MAGENTUS-EDGE-R3_startup-config | 1.1.2.3 | — | no |
| MAGENTUS-EDGE-R4_startup-config | 1.1.2.4 | — | no |
| YAPPER-EDGE-R1_startup-config | 2.2.1.1 | 172.18.111.29 | yes |
| YAPPER-EDGE-R2_startup-config | 2.2.1.2 | 172.18.111.25 | yes |
| YAPPER-EDGE-R3_startup-config | 2.2.1.3 | — | no |
| YAPPER-EDGE-R4_startup-config | 2.2.1.4 | — | no |
| YAPPER-MESH1_startup-config | 2.1.2.1 | — | no |
| YAPPER-MESH2_startup-config | 2.1.2.2 | — | no |
| YAPPER-R1_startup-config | 2.1.1.1 | — | no |
| YAPPER-R2_startup-config | 2.1.1.2 | — | no |
| YAPPER-R3_startup-config | 2.1.1.3 | — | no |
| YAPPER-R4_startup-config | 2.1.1.4 | — | no |
| YAPPER-R5_startup-config | 2.1.1.5 | — | no |
| YAPPER-R6_startup-config | 2.1.1.6 | — | no |
| YAPPER-R7_startup-config | 2.1.1.7 | — | no |
| YAPPER-R8_startup-config | 2.1.1.8 | — | no |

Részletesebb SVG, PDF és draw.io projektfájlok a topológiáról az [IMAGES](../../IMAGES/ISP/) mappában