// Download webpages and store them in a folder.

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Set;
import java.util.regex.Pattern;

import edu.uci.ics.crawler4j.crawler.Page;
import edu.uci.ics.crawler4j.crawler.WebCrawler;
import edu.uci.ics.crawler4j.parser.HtmlParseData;
import edu.uci.ics.crawler4j.url.WebURL;

public class DownloadWebPages extends WebCrawler {
	public FileWriter fw = null;
	public BufferedWriter writer = null;

    private final static Pattern FILTERS = Pattern.compile(".*(\\.("
                                                           + "mp3|zip|gz|jpg))$");

    /**
     * This method receives two parameters. The first parameter is the page
     * in which we have discovered this new url and the second parameter is
     * the new url. You should implement this function to specify whether
     * the given url should be crawled or not (based on your crawling logic).
     * In this example, we are instructing the crawler to ignore urls that
     * have css, js, git, ... extensions and to only accept urls that start
     * with "http://www.ics.uci.edu/". In this case, we didn't need the
     * referringPage parameter to make the decision.
     */
     //@Override
     public boolean shouldVisit(Page referringPage, WebURL url) {
         String href = url.getURL().toLowerCase();
         return !FILTERS.matcher(href).matches()
                && href.startsWith("https://www.themoviedb.org/movie/");
     }

     /**
      * This function is called when a page is fetched and ready
      * to be processed by your program.
      */
     //@Override
     static int counter = 0;
     public void visit(Page page) {
         String url = page.getWebURL().getURL();
         System.out.println("URL: " + url);

         if (page.getParseData() instanceof HtmlParseData) {
             HtmlParseData htmlParseData = (HtmlParseData) page.getParseData();
             String text = htmlParseData.getText();
             String html = htmlParseData.getHtml();
             Set<WebURL> links = htmlParseData.getOutgoingUrls();

             System.out.println("Text length: " + text.length());
             System.out.println("Html length: " + html.length());
             System.out.println("Number of outgoing links: " + links.size());
             
             try {
				String content = new String(page.getContentData(), page.getContentCharset());
				//System.out.println(content);
				String t[];
				t = url.split("/");
				String movieName = t[t.length - 2];
				System.out.println(movieName);
				System.out.println(t[t.length - 1].substring(0,4));
				if(t[t.length - 1].substring(0,4).equalsIgnoreCase("cast")) {
					
					String str = "C:\\Users\\XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\\FolderName\\" + movieName + ".txt";
					File file = new File(str);
					BufferedWriter writer = new BufferedWriter(new FileWriter(file));
					
					// Write your data
					writer.write(content);
					writer.close();
					counter++;
				}
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
             
         }
    }
}