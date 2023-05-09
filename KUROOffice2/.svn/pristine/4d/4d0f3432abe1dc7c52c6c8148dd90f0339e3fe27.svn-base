package kr.or.ddit.main.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kr.or.ddit.approval.service.IAppService;
import kr.or.ddit.approval.vo.AplineVO;
import kr.or.ddit.attfile.vo.AttFileVO;
import kr.or.ddit.cloud.service.ICloudService;
import kr.or.ddit.cloud.vo.CloudVO;
import kr.or.ddit.common.Utils;
import kr.or.ddit.common.vo.ComCodeVO;
import kr.or.ddit.dep.vo.DepVO;
import kr.or.ddit.employee.service.IEmpService;
import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.good.vo.GoodVO;
import kr.or.ddit.main.service.IMainService;
import kr.or.ddit.main.vo.mailjoinVO;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.timeline.vo.TimelineVO;
import kr.or.ddit.work.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/conn")
public class LoginController {

	@Inject
	private IMainService loginService;
	
	@Inject
	private IEmpService empService;
	
	@Inject
	private IAppService appService; 
	
	@Inject
	private ICloudService cloudService;
	
	@Autowired
	private JavaMailSenderImpl mailSender;

	
	@GetMapping("/login")
	public String login() {
		
		return "main/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest req, EmployeeVO empVO, Model model) throws Exception {
		
		// 임시 로그인 체크
		log.info("no, pw >> " + empVO.getEmpNo()+", "+empVO.getEmpPw());
		empVO = loginService.loginCheck(empVO);
		
		HttpSession session = req.getSession();
		session.setAttribute("empVO", empVO);
		
		if (empVO == null) {
			model.addAttribute("msg", "로그인 정보를 확인해주세요.");
			return "conn/login";
		}
		
		return "redirect:/main/home";
		
	}
	

	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		session.invalidate();
		
		return "conn/login";
	}
	
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public String loginFind(Model model) {
		model.addAttribute("bodyText","login-page");
		log.debug("find>>>");
		return "conn/find";
	}
	
	@RequestMapping(value = "/idfind", method = RequestMethod.POST)
	public ResponseEntity<String> idFind(EmployeeVO empVO){
		String empNo = empService.idFind(empVO);
		return new ResponseEntity<String>(empNo,HttpStatus.OK);
	}
	
	@RequestMapping(value = "/pwfind", method = RequestMethod.POST)
	public ResponseEntity<String> pwFind(EmployeeVO empVO){
		String empNo = empService.pwFind(empVO);
		return new ResponseEntity<String>(empNo,HttpStatus.OK);
	}
	
	
	@RequestMapping(value = "/sendMail", produces = "text/plain; charset=utf-8")
	@ResponseBody
    public ResponseEntity<String> sendjoinMail(@RequestBody mailjoinVO mvo, HttpSession session ) throws Exception{
		 	Random random = new Random();
			
			int ranNum = random.nextInt(100000);
			
			session.setAttribute("ranNum", ranNum);
	        session.setMaxInactiveInterval(20);
	        
	        String from = "hee822090@gmail.com";
	        
	       
	        try {
	            MimeMessage mail = mailSender.createMimeMessage();
	            
	              MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
	            
	            
	            mailHelper.setFrom(from);
	            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
	            // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
	            //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
	            mailHelper.setTo(mvo.getTo());
	            mailHelper.setSubject("인증번호입니다");
	            mailHelper.setText("회원가입 인증번호는 " + ranNum + "입니다", true);
	            // true는 html을 사용하겠다는 의미입니다.
	            
	            /*
	             * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
	             */
	            
	            mailSender.send(mail);
	            
	        } catch(Exception e) {
	            e.printStackTrace();
	            return new ResponseEntity<String>("FAILED", HttpStatus.OK);
	        }
	        
	        
	        return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    }
	
	

	@RequestMapping(value = "/numberCheck", produces = "text/plain; charset=utf-8")
	@ResponseBody
    public ResponseEntity<String> numCheck(@RequestBody mailjoinVO mvo, HttpSession session) throws Exception{
		int ranNum;
		System.out.println(mvo.getJoinNum());
		if(session.getAttribute("ranNum")!=null) {
		 ranNum = (int)session.getAttribute("ranNum");
		}else {
			ranNum = 0;
		}
		
		
		if(mvo.getJoinNum().equals(String.valueOf(ranNum))) {
			
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("FAILED", HttpStatus.OK);
		}
	        
    }
	
}



