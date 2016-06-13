package com.neowave.screening.util;

import java.util.concurrent.CompletableFuture;

import org.apache.log4j.Logger;
import org.springframework.core.MethodParameter;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.context.request.async.WebAsyncUtils;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.neowave.screening.controller.ScreenController;

public class CompletableFutureReturnValueHandler implements
		HandlerMethodReturnValueHandler {
	private final Logger logger = Logger.getLogger(ScreenController.class);
	
	@Override
	public void handleReturnValue(Object returnValue,
			MethodParameter returnType, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest) throws Exception {
		if (returnValue == null) {
			mavContainer.setRequestHandled(true);
			return;
		}
		final DeferredResult<Object> deferredResult = new DeferredResult<>();

		CompletableFuture<? extends Object> futureValue = (CompletableFuture<? extends Object>) returnValue;
		futureValue.whenComplete((result, ex) -> {
			if (ex != null) {
				deferredResult.setErrorResult(ex);
			} else {
				deferredResult.setResult(result);
			}
		});

		WebAsyncUtils.getAsyncManager(webRequest)
				.startDeferredResultProcessing(deferredResult, mavContainer);
	}

	@Override
	public boolean supportsReturnType(MethodParameter returnType) {
		logger.info("--------supports-----");
		return CompletableFuture.class.isAssignableFrom(returnType
				.getParameterType());
	}
}
