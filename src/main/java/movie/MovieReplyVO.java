package movie;

public class MovieReplyVO {
	private int idx;
	private String movie_id;
	private String mid;
	private String nickName;
	private String photo;
	private int star;
	private String rDate;
	private String hostIp;
	private String content;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(String movie_id) {
		this.movie_id = movie_id;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Override
	public String toString() {
		return "MovieReplyVO [idx=" + idx + ", movie_id=" + movie_id + ", mid=" + mid + ", nickName=" + nickName
				+ ", photo=" + photo + ", star=" + star + ", rDate=" + rDate + ", hostIp=" + hostIp + ", content=" + content
				+ "]";
	}
	
	
}