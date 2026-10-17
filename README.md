# 📈 Stock Market Analytics & Portfolio Intelligence Platform

An end-to-end data analytics platform designed to ingest, clean, store, and analyze stock market transaction data across 22+ companies (20,000+ records). The project utilizes a production-grade architecture transitioning from raw exploratory notebooks to a modular Python pipeline, MySQL relational database, and interactive Power BI executive dashboards.

---

## 🛠️ Tech Stack & Architecture

- **Language & Libraries:** Python 3.x, Pandas, NumPy, SQLAlchemy, PyMySQL, python-dotenv
- **Database Management:** MySQL Workbench, Relational Database Schema Design
- **Business Intelligence:** Power BI (DAX, Interactive Slicers, Visual Dashboards)
- **Environment & Version Control:** VS Code, Git, GitHub (`.gitignore`, `.env` isolation)

---

## 📁 Repository Structure

```text
stock_market/
├── config/
│   └── config.py              # Environment variables & MySQL credentials manager
├── data/
│   ├── raw_data/              # Initial uncleaned stock datasets
│   └── cleaned_data/          # Transformed & audited CSV ready for database ingestion
├── notebook/
│   ├── 01_data_inspection.ipynb  # Initial exploratory analysis & schema check
│   ├── 02_data_cleaning.ipynb    # Missing values, duplicates, and anomaly removal
│   └── 03_business_analysis.ipynb # Core analytical trends & statistical computations
├── powerbi/
│   └── stock_market_analytics.pbix # Executive interactive Power BI dashboard
├── sql/
│   ├── 01_database_setup.sql        # Database initialization & table schema
│   ├── 02_data_quality.sql          # NULL checks, duplicate audits, and constraint validation
│   ├── 03_momentum_and_signals.sql  # Technical indicators (SMA, RSI, Analyst predictions)
│   ├── 04_sector_comparison.sql     # Sectorial trends & next-day price movement
│   ├── 05_liquidity_and_delivery.sql # Trading activity & delivery percentage distribution
│   ├── 06_risk_and_volatility.sql   # Circuit-hit risk, market cap analysis & ATR metrics
│   └── 07_data_source_quality.sql   # Multi-source completeness and data reliability audits
├── src/
│   ├── __init__.py            # Package initializer
│   └── load_to_mysql.py       # Automated MySQL database load script via SQLAlchemy
├── .env                       # Environment credentials (git-ignored)
├── .gitignore                 # Excludes virtual environments and sensitive files
├── README.md                  # Project documentation & execution guide
└── requirements.txt           # Environment dependencies