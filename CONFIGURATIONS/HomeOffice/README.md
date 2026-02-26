# Homeoffice konfigurációk

Ez a mappa tartalmazza a homeoffice dolgozók csatlakozását lehetővé tevő komponensek beállításait.

- `tailscale_watchdog.service`: rc.d szolgáltatás (daemon) definíció fájl
- `tailscale_watchdog.sh`: Maga a tailscale subnet és ospf management szkript

A szkriptek működése (mermaid markdown):
```mermaid
flowchart TD
    subgraph "1. Eseményfigyelő Szál (Listener)"
        A[Indítás: route monitor] --> B{Változás a routing táblában?}
        B -- Igen (OSPF/Kernel) --> C[Trigger fájl létrehozása/frissítése]
        C --> B
    end

    subgraph "Közös Erőforrás"
        T[("/tmp/tailscale_routes_dirty")]
    end

    C -.-> T

    subgraph "2. Feldolgozó Szál (Processor)"
        D[Ciklus indítása] --> E{Létezik a Trigger fájl?}
        T -.-> E
        E -- Nem --> F[Alvás: 1 mp]
        F --> E
        
        E -- Igen --> G[Debounce: Várakozás 2 mp]
        G --> H[Fájl zárolása: átnevezés .processing-re]
        
        H --> I[Adatgyűjtés: OSPF + Statikus útvonalak]
        I --> J[Jelenlegi Tailscale konfig lekérése]
        
        J --> K{Van eltérés?}
        K -- Igen --> L[tailscale set --advertise-routes]
        L --> M[Naplózás: Siker]
        K -- Nem --> N[Naplózás: Nincs változás]
        
        M --> O[Ideiglenes fájl törlése]
        N --> O
        O --> E
    end
```