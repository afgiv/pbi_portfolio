# 📊 Data Analyst Portfolio

Welcome to my portfolio of data analysis, SQL warehousing, and Power BI reporting projects. Each project in this repository transforms raw, real-world, or operational datasets into structured data models, clean metrics, and decision-ready dashboards.

---

### 🛒 1. [Online Retail — End-to-End ELT & Incremental Sales Pipeline](./Online%20Retail) *(Work in Progress)*
- **Topic:** Multi-year retail transaction warehousing, automated incremental ingestion, and sales performance analytics.
- **Tools:** PostgreSQL, Python (`psycopg2`, `pandas`), Power BI Desktop.
- **Current Progress & Planned Architecture:**
  - **Completed:** Ingested **1,067,371+ raw retail transaction rows** across multi-tab spreadsheets into a layered PostgreSQL warehouse (`staging`, `intermediate`, `analytics`) using Python `copy_expert` inside explicit `BEGIN / COMMIT / ROLLBACK` transactions, and established initial deduplication (`ROW_NUMBER()`) rules.
  - **In Progress:** Standardizing column-level data cleaning across remaining fields (`invoice` onward) and implementing incremental daily automation aligned with store hours (`8:00 AM–6:00 PM` cutoff, `6:30 PM` scheduled run, and missing-file email alerts).
  - **Upcoming:** Building `analytics` star-schema views and connecting Power BI Desktop for interactive retail KPI and sales trend reporting.

---

### 🎓 2. [Education in Danger](./Education%20in%20Danger)
- **Topic:** Global threats and risk factors affecting educational access and safety from 2020–2025.
- **Tools:** Power BI, DAX, Dynamic Field Parameters, Custom Tooltips.
- **Key Highlights & Metrics:**
  - Multipage longitudinal report tracking **9,616 total affected victim outcomes**.
  - Uncovered a **+956.6% surge in recorded incidents** between 2020 and 2025.
  - Identified **Myanmar** as the primary global hotspot (**983 incidents**) and highlighted a critical **52% post-arrest outcome documentation gap**.

---

### 📚 3. [Student Performance](./Student%20Performance)
- **Topic:** Demographic, socioeconomic, and academic drivers of student exam performance across Math, Reading, and Writing.
- **Tools:** Python (`pandas` ETL), Power BI, DAX.
- **Key Highlights & Metrics:**
  - Cleaned, validated, and standardized **1,000 student records** using a reproducible Python (`pandas`) ETL pipeline before modeling in Power BI.
  - Established an overall cross-subject benchmark score of **67.77** (Math median **66**), identifying **standard lunch access** (+11 pts in Math: **70 vs. 59**), **test preparation completion** (**+6 to +9 pts** across subjects), and **higher parental education** (Master's degree averaging **70–76** vs. Highschool **62–65**) as the strongest performance drivers.
  - Highlighted subject-level gender patterns (**Males leading in Math: 69 vs. 64**; **Females leading in Reading: 73 vs. 65** and **Writing: 72 vs. 63**).

---

### 🏭 4. [Soda Manufacturing Line](./Soda%20Manufacturing%20Line)
- **Topic:** Operational performance, bottleneck identification, and downtime root-cause analysis for a production line.
- **Tools:** Power BI, DAX.
- **Key Highlights & Metrics:**
  - Tracked **38 production batches** and overall line efficiency (**64.0%**).
  - Quantified total downtime (**1,388 minutes**) and isolated machine adjustments vs. inventory shortages as primary drivers.
  - Evaluated operator variance across shifts.

---

### 🧪 5. [Data Professional Survey](./Data%20Professional%20Survey)
- **Topic:** Career entry, compensation trends, and work-life balance in data and tech roles.
- **Tools:** Power BI, DAX, Power Query.
- **Key Highlights & Metrics:**
  - Analyzed survey responses from **630 data professionals** worldwide (average age 30).
  - Mapped salary satisfaction (**4.27/10**) versus work-life balance satisfaction (**5.74/10**).
  - Highlighted Python dominance across roles and breakdown of how professionals break into data careers.

---

### 🛠️ Technical Stack & Workflow
- **Data Cleaning & Modeling:** Excel (Power Query, Pivot Tables, XLOOKUP), PostgreSQL (`staging` → `intermediate` → `analytics` schemas, Window Functions, CTEs)
- **BI & Visualization:** Power BI Desktop (DAX measures, Dynamic Slicers, Custom Hidden-Tab Tooltips, Query Folding)
- **Automation & Version Control:** Python (`pandas`, `psycopg2`, `smtplib`), Git & GitHub, Windows Task Scheduler
