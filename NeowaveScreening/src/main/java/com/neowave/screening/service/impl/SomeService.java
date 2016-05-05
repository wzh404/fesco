package com.neowave.screening.service.impl;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ForkJoinPool;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.neowave.screening.controller.ScreenController;

@Service
public class SomeService {
	private final Logger logger = Logger.getLogger(SomeService.class);
	
	public CompletableFuture<String> getMessage() {
		return CompletableFuture.supplyAsync(() -> {
			heavyWork();
			return "hello async world";
		}, ForkJoinPool.commonPool());
	}

	private void heavyWork() {
		try {
			logger.info("Thread is " + (Thread.currentThread().getName()));
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			Thread.interrupted();
		}
	}
}
