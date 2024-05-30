package movie;

public class MovieVO {
	private int movie_id;
	private String movie_title;
	private String movie_overview;
	private double movie_popularity;
	private double movie_vote_average;
	private int movie_vote_count;
	private String movie_poster_path;
	private String movie_backdrop_path;
	private String movie_adult;
	private String movie_date;
	private String movie_subject;
	
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getMovie_title() {
		return movie_title;
	}
	public void setMovie_title(String movie_title) {
		this.movie_title = movie_title;
	}
	public String getMovie_overview() {
		return movie_overview;
	}
	public void setMovie_overview(String movie_overview) {
		this.movie_overview = movie_overview;
	}
	public double getMovie_popularity() {
		return movie_popularity;
	}
	public void setMovie_popularity(double movie_popularity) {
		this.movie_popularity = movie_popularity;
	}
	public double getMovie_vote_average() {
		return movie_vote_average;
	}
	public void setMovie_vote_average(double movie_vote_average) {
		this.movie_vote_average = movie_vote_average;
	}
	public int getMovie_vote_count() {
		return movie_vote_count;
	}
	public void setMovie_vote_count(int movie_vote_count) {
		this.movie_vote_count = movie_vote_count;
	}
	public String getMovie_poster_path() {
		return movie_poster_path;
	}
	public void setMovie_poster_path(String movie_poster_path) {
		this.movie_poster_path = movie_poster_path;
	}
	public String getMovie_backdrop_path() {
		return movie_backdrop_path;
	}
	public void setMovie_backdrop_path(String movie_backdrop_path) {
		this.movie_backdrop_path = movie_backdrop_path;
	}
	public String getMovie_adult() {
		return movie_adult;
	}
	public void setMovie_adult(String movie_adult) {
		this.movie_adult = movie_adult;
	}
	public String getMovie_date() {
		return movie_date;
	}
	public void setMovie_date(String movie_date) {
		this.movie_date = movie_date;
	}
	public String getMovie_subject() {
		return movie_subject;
	}
	public void setMovie_subject(String movie_subject) {
		this.movie_subject = movie_subject;
	}
	
	@Override
	public String toString() {
		return "MovieVO [movie_id=" + movie_id + ", movie_title=" + movie_title + ", movie_overview=" + movie_overview
				+ ", movie_popularity=" + movie_popularity + ", movie_vote_average=" + movie_vote_average
				+ ", movie_vote_count=" + movie_vote_count + ", movie_poster_path=" + movie_poster_path
				+ ", movie_backdrop_path=" + movie_backdrop_path + ", movie_adult=" + movie_adult + ", movie_date=" + movie_date
				+ ", movie_subject=" + movie_subject + "]";
	}
}
