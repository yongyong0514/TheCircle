package com.kh.circle.poll.entity;

import java.util.HashMap;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Question {
	private int seq ,score, pluralMaximum;
	private String leadTitle, title, necessary, type, content, etcContent,
				   selectType, checkLowerType, popn, popq;
	private List<SelectContents> selectContents;
}
