
-- Create DB (safe for local dev)

CREATE DATABASE MovieRatings2025;
USE MovieRatings2025;

-- Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(200),
    language VARCHAR(50),
    release_year INT,
    genre VARCHAR(50)
);

-- Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

-- Ratings table (includes rating_date for time-based analysis)
CREATE TABLE Ratings (
    user_id INT,
    movie_id INT,
    rating DECIMAL(2,1),
    rating_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Insert sample Movies (Telugu / Hindi / English latest examples)
INSERT INTO Movies (movie_id, title, language, release_year, genre) VALUES
(1, 'They Call Him OG', 'Telugu', 2025, 'Action'),
(2, 'Mirai', 'Telugu', 2025, 'Thriller'),
(3, 'Little Hearts', 'Telugu', 2025, 'Romance'),
(4, 'Jolly LLB 3', 'Hindi', 2025, 'Comedy'),
(5, 'Homebound', 'Hindi', 2025, 'Drama'),
(6, 'Nishaanchi', 'Hindi', 2025, 'Action'),
(7, 'Deadpool & Wolverine', 'English', 2024, 'Action'),
(8, 'Inside Out 2', 'English', 2024, 'Animation'),
(9, 'Dune: Part Two', 'English', 2024, 'Sci-Fi');

-- Insert sample users
INSERT INTO Users (user_id, name, city) VALUES
(1, 'Sahithi', 'Hyderabad'),
(2, 'Bhagi', 'Mumbai'),
(3, 'Anjali', 'Bangalore'),
(4, 'Kalyan', 'Delhi'),
(5, 'Siva', 'Chennai');

-- Insert sample ratings with rating_date (spread across multiple days)
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES
(1, 1, 4.7, '2025-09-15'),
(1, 2, 4.5, '2025-09-15'),
(1, 4, 4.2, '2025-09-15'),
(2, 1, 4.8, '2025-09-17'),
(2, 3, 4.3, '2025-09-17'),
(2, 7, 4.6, '2025-09-17'),
(3, 5, 4.4, '2025-09-19'),
(3, 6, 4.1, '2025-09-19'),
(3, 9, 4.8, '2025-09-19'),
(4, 2, 4.6, '2025-09-21'),
(4, 4, 4.5, '2025-09-21'),
(4, 8, 4.9, '2025-09-21'),
(5, 3, 4.2, '2025-09-23'),
(5, 5, 4.6, '2025-09-23'),
(5, 9, 4.7, '2025-09-23');

-- Quick checks (optional)
SELECT COUNT(*) AS movies_count FROM Movies;
SELECT COUNT(*) AS users_count FROM Users;
SELECT COUNT(*) AS ratings_count FROM Ratings;

-- Top - Rated movies Per language
SELECT language, title, avg_rating
FROM (
    SELECT 
        m.language,
        m.title,
        ROUND(AVG(r.rating), 2) AS avg_rating,
        RANK() OVER (PARTITION BY m.language ORDER BY AVG(r.rating) DESC) AS rank_in_lang
    FROM Movies m
    JOIN Ratings r ON m.movie_id = r.movie_id
    GROUP BY m.language, m.title
) ranked_movies
WHERE rank_in_lang <= 3;

-- Users who rated the most of the movies 
SELECT 
    u.name,
    COUNT(r.movie_id) AS total_movies_rated
FROM Users u
JOIN Ratings r ON u.user_id = r.user_id
GROUP BY u.name
ORDER BY total_movies_rated DESC;


-- Average Ratings per Year
SELECT 
    m.release_year,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.release_year
ORDER BY m.release_year;


-- Most Popular Genre per Language
SELECT 
    m.language,
    m.genre,
    ROUND(AVG(r.rating), 2) AS avg_genre_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.language, m.genre
ORDER BY m.language, avg_genre_rating DESC;

-- Overall Highest rated movie
SELECT 
    m.title,
    m.language,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.title, m.language
ORDER BY avg_rating DESC
LIMIT 1;