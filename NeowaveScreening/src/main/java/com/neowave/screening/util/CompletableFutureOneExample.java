package com.neowave.screening.util;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;

public class CompletableFutureOneExample {
	public static void main(String[] args) throws InterruptedException {
        List<Integer> list = Arrays.asList(10,20,30,40);
        list.stream().map(data->CompletableFuture.supplyAsync(()->getNumber(data))).
                map(compFuture->compFuture.thenApplyAsync(n->getNumber2(n))).map(t->t.join())
                .forEach(s->System.out.println(s + " - " + Thread.currentThread().getName()));
    }
	
    private static int getNumber(int a){
    	System.out.println("Thread is " + Thread.currentThread().getName());
        return a*a;
    }
    
    private static int getNumber2(int a){
    	System.out.println("Thread2 is " + Thread.currentThread().getName());
        return a*a;
    }
}
