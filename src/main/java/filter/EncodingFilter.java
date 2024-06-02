package filter;
 
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.Visitor;
 
@WebFilter("/*")
public class EncodingFilter implements Filter {
 
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    		// 한글처리
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // 외부 css 안되는 부분 처리 (선생님 수정본)
        if (!path.startsWith("/css/") && !path.startsWith("/js/") && !path.startsWith("/images/")) {
          // 정적 리소스에 대해서는 필터를 적용하지 않기, 그 외의 요청에 대해서는 UTF-8 인코딩을 설정
          request.setCharacterEncoding("utf-8");
          response.setContentType("text/html; charset=utf-8");
	      }
        
        // Update total visitor count
        Visitor.visitorCount(httpRequest);
        
        // Continue the request
	      chain.doFilter(request, response);
    }
}