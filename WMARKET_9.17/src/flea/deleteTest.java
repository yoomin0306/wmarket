package flea;

import java.io.File;

public class deleteTest {

	public static void main(String[] args) {
		String path = "D:\\WebSoft\\Workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WMARKET_9.17\\img\\image_"+15; //폴더 경로
		File folder = new File(path);
		
		File[] folder_list = folder.listFiles();	// 파일리스트 얻어오기
		for (int j = 0; j < folder_list.length; j++) {
			System.out.println(folder_list.length);
			folder_list[j].delete(); //파일 삭제 
		}
		folder_list = folder.listFiles();
		System.out.println(folder_list.length);
	}
}
