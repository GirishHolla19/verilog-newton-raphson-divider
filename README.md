# verilog-newton-raphson-divider
A 16-bit/8-bit hardware divider implemented in Verilog. Uses the Newton-Raphson algorithm and Q2.14 fixed-point arithmetic for fast, FPU-free reciprocal calculation.
# 16-bit / 8-bit Newton-Raphson Hardware Divider

A high-speed Verilog implementation of an unsigned integer divider using the **Newton-Raphson iteration method**. This module approximates the reciprocal of the divisor using Q2.14 fixed-point arithmetic, then multiplies it by the dividend to produce the quotient.

## Key Features
- **Algorithm:** Newton-Raphson (5 unrolled iterations).
- **Format:** Q2.14 fixed-point math (14 fractional bits).
- **Efficiency:** Initial guess ($x_0$) is seeded via a priority-encoding logic (pseudo-LUT) based on the divisor's magnitude.
- **Protocol:** Simple `start` / `done` handshake for easy integration into larger SoC designs.

---

## Architecture & Theory
Traditional hardware division (restoring/non-restoring) can be slow. This design treats division as a multiplication problem:

$$Quotient = Dividend \times \frac{1}{Divisor}$$

The reciprocal ($1/D$) is calculated by finding the root of $f(x) = \frac{1}{x} - D$ using the iterative formula:
$$x_{i+1} = x_i(2 - D \cdot x_i)$$

### Fixed-Point Scaling
The module uses **16384** as the scaling factor ($2^{14}$).
- **1.0** is represented as `16384`.
- **2.0** is represented as `32768`.

---

## Signal Descriptions

| Signal | Width | Direction | Description |
| :--- | :--- | :--- | :--- |
| `clk` | 1 | Input | System Clock |
| `rst` | 1 | Input | Synchronous Reset (Active High) |
| `start` | 1 | Input | Pulse high to start calculation |
| `dividend` | 16 | Input | Numerator |
| `divisor` | 8 | Input | Denominator |
| `quotient` | 16 | Output | Resulting integer quotient |
| `done` | 1 | Output | Logic high when result is valid |

---

## Simulation Results
The design was verified using a testbench (included in `sim/`). The simulation demonstrates high-speed convergence across the full 8-bit divisor range.

**Waveform Analysis:**
![Simulation Waveform](docs/image_15018d.png)

### Accuracy & Precision
Due to the nature of **Q2.14 fixed-point truncation**, there is a known error margin of approximately $\pm 2$ on the final quotient. This is a design trade-off intended to save silicon area and reduce latency compared to a full IEEE-754 Floating Point Unit.

---

## Project Structure
- `hdl/` : Synthesizable Verilog source code.
- `sim/` : Testbench and simulation files.
- `docs/` : Waveforms and implementation diagrams.

## License
This project is licensed under the MIT License.
