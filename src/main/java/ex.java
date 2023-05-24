
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ex {
	public static void main(String[] args) throws Exception {
	    String targetUrl = "http://api.coolsms.co.kr/messages/v4/send";
	    String parameters = "{\"message\":{\"to\":\"01037210730\",\"from\":\"01037210730\",\"text\":\"억까 ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ\",\"type\":\"SMS\"}}";

	    URL url = new URL(targetUrl);
	    HttpURLConnection con = (HttpURLConnection) url.openConnection();

	    con.setRequestMethod("POST");

	    con.setRequestProperty("Authorization", "HMAC-SHA256 apiKey=NCSOVEBQAQL60IWF, date=2023-05-24 18:35:09, salt=54ca9dc8e9eb5636d9efb045a14f86aa01e4fcf2519035c499819853ed33c9da, signature=c72be735aa50262c7c56daebef493aa5622e684137381f7b69ffeeb11d9d42e7");
	    con.setRequestProperty("Content-Type", "application/json");

	    con.setDoOutput(true);
	    DataOutputStream wr = new DataOutputStream(con.getOutputStream());
	    wr.writeBytes(parameters);
	    wr.flush();
	    wr.close();

	    int responseCode = con.getResponseCode();
	    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	    String line;
	    StringBuffer response = new StringBuffer();
	    while ((line = in.readLine()) != null) {
	      response.append(line);
	    }
	    in.close();

	    System.out.println("HTTP response code : " + responseCode);
	    System.out.println("HTTP body : " + response.toString());
	  }
	  
}
