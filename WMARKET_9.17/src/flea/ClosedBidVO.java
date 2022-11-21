package flea;

public class ClosedBidVO {
	private int pNumber;
	private String bidMaxID;
	private int bidMaxPrice;
	private int takeProfit;
	public int getpNumber() {
		return pNumber;
	}
	public void setpNumber(int pNumber) {
		this.pNumber = pNumber;
	}
	public String getBidMaxID() {
		return bidMaxID;
	}
	public void setBidMaxID(String bidMaxID) {
		this.bidMaxID = bidMaxID;
	}
	public int getBidMaxPrice() {
		return bidMaxPrice;
	}
	public void setBidMaxPrice(int bidMaxPrice) {
		this.bidMaxPrice = bidMaxPrice;
	}
	public int getTakeProfit() {
		return takeProfit;
	}
	public void setTakeProfit(int takeProfit) {
		this.takeProfit = takeProfit;
	}
	
}
