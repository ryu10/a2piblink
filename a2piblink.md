# A2PIBLINK

Blink programs for a2mini VIA card 

## VIA Addresses.

|Register|Address| Function |
|--|--|--|
| PB    | `$Cx00 (49152 + 256*x)` ||
| PA    | `$Cx01 (49153 + 256*x)` ||
| DDRB  | `$Cx02 (49154 + 256*x)` ||
| DDRA  |	`$Cx03 (49155 + 256*x)` ||
| T1L   | `$Cx04 (49156 + 256*x)` | timer|
| T1H   | `$Cx05 (49157 + 256*x)` | timer|
| ACR   | `$Cx0B (49163 + 256*x)` | timer ctr bits reg|
| IFR   | `$Cx0D (49165 + 256*x)` | timer interrupt status reg|
| IER   | `$Cx0E (49166 + 256*x)` | interrupt enable reg|

Examples (SLOT4 and SLOT7)

|Register|SLOT4|SLOT7|
|--|--|--|
| PB    | `$C400 (50176)` | `$C700 (50944)` |
| PA    | `$C401 (50177)` | `$C701 (50945)` |
| DDRB  | `$C402 (50178)` | `$C702 (50946)` |
| DDRA  | `$C403 (50179)` | `$C703 (50947)` |
| T1L   | `$C404 (50180)` | `$C704 (50948)` |
| T1H   | `$C405 (50181)` | `$C705 (50949)` |
| ACR   | `$C40B (50187)` | `$C70B (50955)` |
| IFR   | `$C40D (50189)` | `$C70D (50957)` |
| IER   | `$C40E (50190)` | `$C70E (50958)` |

## Blink Control

Assume the LED is connected PB0. The following control sequence blinks the LED:

* DDRB = $FF (Bit '1' means 'output')
* PB = $0 (LED off)
* wait
* PB = $FF (LED on)
* Repeat the off/on steps

## Timer Control

The timer (TM1) is driven by ph2 (1.023MHz), up to 65536 (oxffff) count.

### Loaded valiue and time:

* 0xffff: 65535 / (1.023 * 10^6) = 0.0641 sec ~ 64ms
* 0xc7ce: 51150 / (1.023 * 10^6) =0.050 sec = 50 ms

### Initialization of TM1 can be done as follows:

1. Set ACR = 0 (TM1 one-shot mode, shift register and PB7 are not used)
2. Set IER = 0x7f (Clear all interrupt triggers; we just poll the register)

### Polling

Periodically check the value of IFR. If bit 6 is set, Timer 1 has reached zero. 

### Resetting TImer 1
Loading T1H resets bit 6.