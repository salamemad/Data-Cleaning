### About Dataset
This Dataset displays only the top 1000 highest grossing feature films of all time as of September 5, 2022. It is in the same order as displayed on the Box Office Mojo website. SOURCE.

DATA DICTIONARY:
Movie Title: The name of the movie.
Year of Release: The year the movie was released.
Genre: Categories where the movie belongs.
Movie Rating: Ratings given by IMDb registered users (on a scale of 1 to 10)
Duration: Movie running time in minutes.
Gross: Gross earnings in U.S. dollars.
Worldwide LT Gross: Worldwide Lifetime Gross (International + Domestic totals.
Metascore: Weighted average of many reviews coming from reputed critics (on a scale of 0 to 100)
Votes: Number of votes cast by IMDb registered users.
Logline: A one or two sentence summary of the film.

### Data Manipulations
1. Change the datatype of 'Year of Realease' field into 'date' datatype
2. Introduce a new field showing how old the movie is
3. Give an unique id to each movie
4. Labelling the film based on 'genre' column
5. Convert 'Duration' column into 'Hours:HH' format
6. Convert gross & worldwide lifetime gross into numerical column by removing special charecters and charecters.
7. Convert votes into categorical data format
8. Drop useless columns