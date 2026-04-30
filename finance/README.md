# Portfolio Analysis Dashboard

## Overview
Investors often ask:  
- *“How is my portfolio performing compared to the market?”*  
- *“Am I taking too much risk?”*  
- *“Would diversifying internationally improve my returns?”*  

This project provides an **interactive tool to analyze ETFs and portfolio allocations**, evaluate risk and return, and help clients make informed investment decisions. It translates historical market data into clear, actionable insights.

---

## Objectives
1. Compare performance of individual ETFs and standard portfolio allocations (e.g., 60/40).  
2. Measure and visualize portfolio risk and returns using KPIs like CAGR, volatility, Sharpe ratio, and max drawdown.  
3. Enable custom portfolio simulations with user-defined weights to test different allocation scenarios.  
4. Prepare outputs suitable for client-facing dashboards in Tableau or Power BI.

---

## Tools & Methods
- **Python:** Pandas, NumPy, Plotly  
- **Data:** Yahoo Finance via `yfinance` (SPY, EFA, IWM, AGG, VNQ, GLD)  
- **Portfolio Analysis:** Monthly returns, cumulative returns, drawdowns, rolling volatility & Sharpe  
- **Visualization:** Cumulative growth charts, drawdown plots, correlation heatmaps  

---

## Key Insights
1. **Portfolio vs Benchmark**  
   - 60/40 portfolio (SPY/AGG) showed smoother growth with lower volatility than SPY alone.  
   - Custom ETF mixes can outperform or underperform benchmarks depending on allocation weights.  
   **Implication:** Proper diversification reduces risk and improves risk-adjusted returns.

2. **Risk Metrics**  
   - Rolling volatility and Sharpe ratios highlight periods of higher market risk.  
   - Maximum drawdowns identify worst historical losses for each ETF and portfolio.  
   **Implication:** Investors can understand downside risk and resilience of allocations.

3. **Custom Portfolio Scenarios**  
   - Equal-weight or user-defined portfolios allow testing different allocation strategies.  
   - Visualization of cumulative returns and KPIs shows trade-offs between risk and reward.  
   **Implication:** Clients can experiment with portfolio design before committing capital.

---

## Conclusions & Recommendations
1. Use diversified ETF portfolios to balance risk and return.  
2. Regularly monitor rolling volatility and drawdowns to anticipate risk periods.  
3. Test custom allocation scenarios to optimize portfolios for client objectives.  
4. Deploy dashboards to provide clients with real-time, interactive portfolio insights.

---

## 📂 Deliverables
- Jupyter Notebook with all calculations and visualizations  
- CSV exports: daily prices, monthly returns, portfolio returns, KPIs, drawdowns  
- Visuals: cumulative growth charts, drawdowns, correlation heatmaps  
- Optional Tableau/Public Power BI dashboards (links can be embedded later)  

---

This project demonstrates the ability to **translate financial data into actionable insights**, combining portfolio theory, risk analysis, visualization, and client-focused reporting.

