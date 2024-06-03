package admin.complaint;

public class ComplaintVO {
	private int idx;
	private String bName;
	private int boardIdx;
	private String cpMid;
	private String cpContent;
	private String cpDate;
	private String complaint;
	
	private String title;
	private String nickName;
	private String mid;
	private String content;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getCpMid() {
		return cpMid;
	}
	public void setCpMid(String cpMid) {
		this.cpMid = cpMid;
	}
	public String getCpContent() {
		return cpContent;
	}
	public void setCpContent(String cpContent) {
		this.cpContent = cpContent;
	}
	public String getCpDate() {
		return cpDate;
	}
	public void setCpDate(String cpDate) {
		this.cpDate = cpDate;
	}
	public String getComplaint() {
		return complaint;
	}
	public void setComplaint(String complaint) {
		this.complaint = complaint;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "ComplaintVO [idx=" + idx + ", bName=" + bName + ", boardIdx=" + boardIdx + ", cpMid=" + cpMid
				+ ", cpContent=" + cpContent + ", cpDate=" + cpDate + ", complaint=" + complaint + ", title=" + title
				+ ", nickName=" + nickName + ", mid=" + mid + ", content=" + content + "]";
	}
	
	
}
