package kr.or.ddit.good.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GoodVO {

	private String goodCode;
	private String empNo;
	private String goodType;
	private Date goodDate;
	private String goodPath;
}
