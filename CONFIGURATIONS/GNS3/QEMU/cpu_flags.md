# QEMU CPU flags

QEMU Windows virtuális gépek optimális működéséhez:

| Kapcsoló            | Kategória                        | Kapcsoló feladata                                                                                                                                 |
| ------------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| -cpu host           | CPU Passthrough                  | Pontos CPU átadása a Windows számára (pl. Intel i5-8500T). Csak elérhető hardveres funkciók és utasításkészlet használata.                        |
| hv_relaxed          | Hyper-V Timer                    | Időzítőmegszakítások (Timer Interrupts) „relaxált” kezelése, egy később érkező vagy kimaradt interrupt nem okoz BSOD-ot.                          |
| hv_spinlocks=0x1fff | CPU Sync                         | Mennyi ideig végezhet spinlock műveletet egy folyamat mielőtt segítséget kér a hypervizortól.                                                     |
| hv_vapic            | Interrupt                        | Engedélyezi a Virtual Advanced Programmable Interrupt Controller (APIC) használatát, a hardveres jelek hatékonyabb kezeléséhez                    |
| hv_time             | Idő                              | Egy virtuális referencia órát biztosít a Windows számára.                                                                                         |
| hv_vpindex          | CPU Vezérlés                     | Virtuális processzor index átadása                                                                                                                |
| hv_synic            | Interrupts                       | Synthetic Interrupt Controller (SynIC) engedélyezése, APIC-en keresztül. Natív gyorsaságú interrupt kezelés biztosítva a hoszt és a vendég között |
| hv_stimer           | Timers                           | Virtualizáció Specifikus Timerek biztosítása vendég számára, hatékony feladat ütemezéshez                                                         |
| hv_reset            | Rendszer Vezérlők                | Közvetlen újraindítás/leállítás kérés a hypervizorhoz                                                                                             |
| hv_frequencies      | Teljesítmény                     | Valós frekvencia adatok biztosítása a pontos energia és időzítés számításokhoz                                                                    |
| topoext             | AMD Specifikus topológia átadása | Pontos AMD CPU topológia átadás, segíti a Windowsnak megérteni a rendelkezésre álló cache és magok működését.                                     |
| accel=kvm           | Virtualizáció                    | Kernelszintű virtualizáció használata a legjobb teljesítmény érdekében.                                                                           |
| kernel-irqchip=on   | Interrupt                        | User-space (QEMU) helyett a kernel (KVM) kezelje a megszakításokat.                                                                               |
| hpet=off            | Idő                              | High Precision Event Timer kikapcsolása, csak a hv_time használata.                                                                               |
| -machine type=q35   | Chipset                          | Modern PCI-Express virtuális lapkakészlet biztosítása                                                                                             |
| -device qemu-xhci   | USB                              | USB 3.0 Vezérlő csatlakoztatása                                                                                                                   |
| -device usb-tablet  | Egér                             | Abszolút egér vezérlés. Lehetővé teszi, hogy akadozásmentesen mozgassuk az egeret a virtuális gépben.                                             |
| -vga qxl            | Kijelző                          | SPICE kompatibilis, gyors felbontás váltást lehetővé tevő videókártya.                                                                            |


Linux esetén kicsit kevesebb kapcsolóra van szükségünk, mert a virtuális eszközöket látva a kernel automatikusan KVM kompatibilis drivereket tölt be: -cpu host -machine type=q35,accel=kvm