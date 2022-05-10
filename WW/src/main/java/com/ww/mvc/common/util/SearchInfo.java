package com.ww.mvc.common.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchInfo  {
	
	private String searchType;
	
	private String keyword;

}
