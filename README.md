# 💰 Vending Machine using Verilog HDL

## 🧾 Abstract
This project presents the design and simulation of a **Vending Machine** using **Verilog HDL**.  
The system automates product dispensing based on coin inputs and product selection. It is modeled using a **Finite State Machine (FSM)** to ensure accurate transaction flow — including coin detection, product dispensing, and change return. The design was verified through simulation, and the output waveform confirms correct functionality under various test conditions.

---

## 🎯 Objective
The main objectives of this project are:
- To design a **coin-operated vending machine** using Verilog HDL.
- To implement **product selection logic** based on user input.
- To verify functionality through **simulation and waveform analysis**.
- To model the design using **FSM-based digital logic** for clarity and scalability.

---

## 🧠 System Overview

The vending machine accepts two types of coins:
- **5-unit coin**
- **10-unit coin**

The user selects the product using a **2-bit selector (`sel[1:0]`)** as shown below:

| `sel[1:0]` | Product     | Price (units) |
|-------------|--------------|----------------|
| 00          | Candy        | 5              |
| 01          | Cake         | 10             |
| 10          | Cool Drink   | 15             |
| 11          | Reserved     | -              |

The machine performs the following operations:
1. Accepts coins and accumulates the total balance.
2. Dispenses the product when sufficient balance is reached.
3. Returns the remaining balance as change (if any).

---

## ⚙️ Input and Output Signals

| Signal | Direction | Description |
|---------|------------|-------------|
| `clk` | Input | Clock signal |
| `rst` | Input | Active-low reset |
| `coin_5` | Input | 5-unit coin insertion |
| `coin_10` | Input | 10-unit coin insertion |
| `sel[1:0]` | Input | Product selection |
| `candy` | Output | High when candy is dispensed |
| `cake` | Output | High when cake is dispensed |
| `cooldrink` | Output | High when cool drink is dispensed |
| `change` | Output | High when change is returned |
| `rtn[7:0]` | Output | Amount of change returned (if any) |

---

## 🧩 Design Description

The vending machine is implemented as a **Finite State Machine (FSM)** consisting of the following states:

1. **IDLE:** Waits for coin insertion or product selection.  
2. **COIN_ACCEPT:** Accepts coins and updates the balance.  
3. **CHECK_BALANCE:** Compares balance with the product price.  
4. **DISPENSE:** Dispenses the selected product.  
5. **RETURN_CHANGE:** Returns any extra amount.  
6. **RESET:** Returns the system to the IDLE state for the next transaction.

This modular FSM design ensures reliable operation, easy debugging, and expandability for additional products or coin types.

---

## 🧪 Simulation and Results

Simulation was performed using **ModelSim** / **Vivado Simulator**.  
The waveform below represents the correct functioning of the vending machine, showing:
- Coin inputs (`coin_5`, `coin_10`)
- Product selection (`sel[1:0]`)
- Dispensing outputs (`candy`, `cake`, `cooldrink`)
- Change return (`rtn[7:0]`)

### 📈 Output Waveform:
![Simulation Output](VENDING%20MACHINE%20OUTPUT%20WAVEFORM.png)

---

## 🧾 Output Information (Waveform Analysis)

The simulation waveform illustrates the **real-time response** of the vending machine to different coin insertions and product selections.

### 🧠 Step-by-Step Explanation

1. **Initial State (0 – 50 ns)**  
   - `sel = 00` → Candy selected.  
   - No coins inserted; outputs remain **0**.  
   - System is in **IDLE** state.

2. **First Coin Inserted (~50 ns)**  
   - `coin_5 = 1` → Total = 5 units.  
   - Since Candy costs 5 units, `candy = 1` activates.  
   - Candy is dispensed. No change (`rtn = 00`).

3. **Second Transaction (~100 ns)**  
   - `sel = 01` → Cake selected.  
   - Two 5-unit coins inserted (`coin_5` twice).  
   - Total = 10 units → `cake = 1` activates.  
   - Cake dispensed successfully.

4. **Third Transaction (~150–200 ns)**  
   - `sel = 10` → Cool Drink selected.  
   - Inserted `coin_10` and `coin_5` → Total = 15 units.  
   - `cooldrink = 1` asserted; Cool Drink dispensed.

5. **Fourth Transaction (~250–300 ns)**  
   - `sel = 11` → Reserved / Invalid option.  
   - No product is dispensed.  
   - Outputs remain low; FSM ignores invalid selection.

6. **Fifth Transaction (~350–450 ns)**  
   - `sel = 10` → Cool Drink again.  
   - Two 10-unit coins inserted → Total = 20 units.  
   - `cooldrink = 1` activates, product dispensed.  
   - `change = 1` and `rtn = 00000101 (5)` — returns 5 units as change.

---

### 🧾 Output Summary Table

| Time (ns) | sel[1:0] | Product     | Coin Input(s) | Total | Output Signal | Change Returned |
|------------|-----------|--------------|----------------|--------|----------------|------------------|
| 0–50       | 00        | Candy        | None           | 0      | None           | 0 |
| 50–100     | 00        | Candy        | 5              | 5      | `candy = 1`    | 0 |
| 100–150    | 01        | Cake         | 5 + 5          | 10     | `cake = 1`     | 0 |
| 150–200    | 10        | Cool Drink   | 10 + 5         | 15     | `cooldrink = 1`| 0 |
| 250–300    | 11        | Invalid      | 5 or 10        | -      | None           | 0 |
| 350–450    | 10        | Cool Drink   | 10 + 10        | 20     | `cooldrink = 1`| `change = 1`, rtn = 5 |

---

### ✅ Key Observations
- The FSM transitions correctly between **IDLE**, **COIN_ACCEPT**, **DISPENSE**, and **RETURN_CHANGE** states.  
- Valid selections trigger corresponding product outputs.  
- Extra inserted balance is properly returned as change.  
- Invalid selections produce no output, confirming logical correctness.

---

## 🧱 Tools and Technologies

| Tool | Purpose |
|------|----------|
| **Verilog HDL** | Hardware description and design |
| **ModelSim / Vivado** | Simulation and waveform verification |
| **Xilinx Vivado / Intel Quartus Prime** | Synthesis and implementation |
| **GTKWave** | Waveform visualization |


## Future Enhancements

- Add multiple product categories with dynamic pricing.
- Include a digital display (7-segment or LCD) for balance indication.
- Implement a coin return or refund option.
- Introduce a timer-based auto-reset feature.
- Expand FSM to handle multi-currency or token-based input.


##  Author

Venkatesh Damera


VLSI & EMBEDDED ENTHUSIAST
