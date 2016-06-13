package com.neowave.screening.controller;

import java.util.concurrent.CompletableFuture;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.neowave.screening.service.impl.SomeService;

@Controller
public class CompletableFutureContoller {
	private static final Log LOG = LogFactory
			.getLog(CompletableFutureContoller.class);

	@Autowired
	private SomeService someService;
	
	@RequestMapping(value = "/async", method = RequestMethod.GET)
	public CompletableFuture<ModelAndView> indexAsync() {
		LOG.info("Servlet Thread Id = '" + Thread.currentThread().getName()
				+ "'.");

		return someService.getMessage().thenApply(
				msg -> new ModelAndView("message", "message", msg));
	}
}
