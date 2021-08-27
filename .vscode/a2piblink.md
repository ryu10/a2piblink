# A2PIBLINK

Blink programs for a2mini VIA card 

## IO Addresses

|Register|Address| Function |
|--|--|--|
| V_PB    | `$Cx00 (49152 + 256*x)` ||
| V_PA    | `$Cx01 (49153 + 256*x)` ||
| V_DDRB  | `$Cx02 (49154 + 256*x)` ||
| V_DDRA  |	`$Cx03 (49155 + 256*x)` ||
| V_T1L   | `$Cx04 (49156 + 256*x)` | timer|
| V_T1H   | `$Cx05 (49157 + 256*x)` | timer|
| V_ACR   | `$Cx0B (49163 + 256*x)` | timer ctr bits reg|
| V_IFR   | `$Cx0D (49165 + 256*x)` | timer interrupt status reg|
| V_IER   | `$Cx0E (49166 + 256*x)` | interrupt enable reg|

Example: If A2mini VIA card is set to SLOT7:

|Register|Address|
|--|--|
| V_PB    | `$C700 (50944)` |
| V_PA    | `$C701 (50945)` |
| V_DDRB  | `$C702 (50946)` |
| V_DDRA  |	`$C703 (50947)` |
| V_T1L   | `$C704 (50948)` |
| V_T1H   | `$C705 (50949)` |
| V_ACR   | `$C70B (50955)` |
| V_IFR   | `$C70D (50957)` |
| V_IER   | `$C70E (50958)` |

Example2: If A2mini VIA card is set to SLOT4:

|Register|Address|
|--|--|
| V_PB    | `$C400 (50176)` |
| V_PA    | `$C401 (50177)` |
| V_DDRB  | `$C402 (50178)` |
| V_DDRA  |	`$C403 (50179)` |
| V_T1L   | `$C404 (50180)` |
| V_T1H   | `$C405 (50181)` |
| V_ACR   | `$C40B (50187)` |
| V_IFR   | `$C40D (50189)` |
| V_IER   | `$C40E (50190)` |

## Blink Control

Assume the LED is connected PB0. The following control sequence blinks the LED:

* V_DDRB = $FF (Bit '1' means 'output')
* V_PB = $0 (LED off)
* wait
* V_PB = $FF (LED on)
* Repeat the off/on steps
