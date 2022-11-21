package flea;

public class BidVO {
	
	private String id;
	private int pNumber;
	private String bidPrice;
	private int refund;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getpNumber() {
		return pNumber;
	}
	public void setpNumber(int pNumber) {
		this.pNumber = pNumber;
	}
	public String getBidPrice() {
		return bidPrice;
	}
	public void setBidPrice(String bidPrice) {
		this.bidPrice = bidPrice;
	}
	public int getRefund() {
		return refund;
	}
	public void setRefund(int refund) {
		this.refund = refund;
	}
}
