package com.neowave.screening.util.xeehoo;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.Channel;

import java.io.Serializable;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

import com.neowave.screening.util.HessianTcpClient;

public class HessianRpcProxy implements InvocationHandler, Serializable{	
	private static final long serialVersionUID = -5392660471766899934L;
	
	private Class<?> _type;
	private Channel _channel;
	
	public HessianRpcProxy(Channel channel, Class<?> type){
		this._type = type;
		this._channel = channel;
	}
	
	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		byte[] data = HessianTcpClient.serialization(this._type, method.getName(), args);
		ByteBuf buf = Unpooled.wrappedBuffer(data);
    	_channel.writeAndFlush(buf).sync();
    
//		System.out.println("proxy is " + _type.getName());
		return HessianTcpClient.deserialization(data);
	}
}
