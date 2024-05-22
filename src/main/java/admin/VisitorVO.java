package admin;

public class VisitorVO {
	private int idx;
	private String visitTime;
	private String visitIp;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getVisitTime() {
		return visitTime;
	}
	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}
	public String getVisitIp() {
		return visitIp;
	}
	public void setVisitIp(String visitIp) {
		this.visitIp = visitIp;
	}
	
	@Override
	public String toString() {
		return "VisitorVO [idx=" + idx + ", visitTime=" + visitTime + ", visitIp=" + visitIp + "]";
	}
	
	
}
