# Data-Analysis-with-SQL

📊 Belgian Companies Data Analysis Project.

A data analysis project exploring insights about active companies in Belgium using SQL. The dataset includes company metadata, activity sectors, addresses, establishment locations, and more. This project was conducted as part of a consulting mission following the migration of company data to a structured SQL database.

🧠 Project Description:

This project aims to uncover valuable business insights from Belgium’s enterprise registry using SQL queries. The analysis explores company size, geographical distribution, creation trends, activity sectors, and establishment patterns. These insights are useful for policymakers, business strategists, and investment analysts.

📂 Repository Structure:

bash
Copy
Edit
📁 belgium-companies-analysis/
│
├── queries.sql               # All SQL queries used in the project
├── presentation.pdf          # Final presentation slides (5–8 slides)
├── visuals/                  # Graphs and charts generated for the slides
├── README.md                 # This file
⚙️ Installation & Usage

Prerequisites:

Any SQLite-compatible interface (e.g., DB Browser for SQLite, DBeaver, or a Jupyter Notebook with SQLite connector)

Python (optional, for generating visuals)

Jupyter or VSCode (optional, for editing and visualization)

Steps

Clone the repository:

bash
Copy
Edit
git clone https://github.com/lkseier/Data-Analysis-with-SQL.git
cd belgium-companies-analysis
Open your SQL client and connect to the company database.

Run the queries in queries.sql to reproduce the results.

(Optional) To generate visuals, run the plotting scripts in Python or use the pre-generated images in the visuals/ folder.

📈 Key Insights (Sample Highlights)
Company Size Distribution
Majority of companies fall into the Micro and Small categories.

Branch Distribution
Most companies have a single location, but a few have more than 10 branches.

Top Municipalities
Cities like Antwerpen, Bruxelles, and Gent host the highest number of establishments.

Top Companies by Establishments
Organizations like bpost, SPW, and Colruyt Food Retail operate across many locations in Belgium.

📊 Visuals
Visualizations are available in the /visuals folder and include:

company_size_distribution.png

branch_count_distribution.png

top_municipalities_updated.png

top_companies_updated.png

You can embed these into a PowerPoint or use them in a Streamlit dashboard.

👥 Contributors:

Klebert Tchatchoua

🗓️ Timeline
Day 1 : Database exploration, schema understanding

Day 2 : Query development and data validation

Day 3 : Visualization and storytelling

Day 4 : Final presentation and documentation

🙋 Personal Situation:

This project was completed as part of our becode bootcamp training. It was a collaborative effort to analyze and present insights from the Belgian company database, enhancing our SQL skills and understanding of data analysis.