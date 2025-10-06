# Movie Ratings 2025 Project 🎬

**Movie Rating Analysis with MySQL, Python, Regression, and Visualizations**

---

## Overview

This project analyzes ratings of the latest Telugu, Hindi, and English movies. It demonstrates a complete end-to-end Data Science workflow:

- **Database:** MySQL Workbench for storing movies, users, and ratings.
- **Python Analysis:** Connects to MySQL, performs aggregations, trains regression models.
- **Visualization:** Matplotlib charts for trends, top movies, and genre popularity.
- **Reporting:** Exports results to PDF and PowerPoint for presentation.

---

## Folder Structure

Movie_Ratings_2025_Project/
│
├─ sql/
│ └─ movie_ratings_setup.sql # MySQL database + tables + sample data
├─ python/
│ └─ movie_ratings_project.py # Python script for analysis & visualization
├─ outputs/ # Generated CSV, PNG, PDF, PPTX
│ ├─ raw_ratings.csv
│ ├─ top_movies_per_language.csv
│ ├─ users_most_ratings.csv
│ ├─ avg_rating_per_year.csv
│ ├─ genre_popularity_per_language.csv
│ ├─ predicted_by_genre.csv
│ ├─ avg_rating_trend.png
│ ├─ user_activity.png
│ ├─ genre_popularity.png
│ ├─ predicted_genres.png
│ ├─ Movie_Rating_Analysis.pdf
│ └─ Movie_Rating_Analysis.pptx
└─ requirements.txt # Python packages


---

## Prerequisites

- **MySQL 8.x** (Server + Workbench)
- **Python 3.8+**
- Python packages:  

```bash
pip install mysql-connector-python pandas matplotlib scikit-learn python-pptx
