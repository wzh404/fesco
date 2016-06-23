package com.neowave.screening.util;

import io.netty.channel.Channel;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.caucho.hessian.client.HessianProxy;
import com.caucho.hessian.client.HessianProxyFactory;
import com.caucho.hessian.io.Hessian2Input;
import com.caucho.hessian.io.Hessian2Output;
import com.caucho.hessian.io.HessianRemoteObject;
import com.neowave.screening.util.xeehoo.HessianRpcProxy;
import com.neowave.screening.util.xeehoo.UserService;
import com.neowave.screening.util.xeehoo.UserServiceImpl;

public class HessianTcpClient {
	public static void main(String[] args){
//		UserService userService = (UserService)create(UserService.class);
//		User u = userService.getUser(3);
		
//		byte[] data = HessianTcpClient.serialization(UserService.class, "getUser", new Integer[]{3});
//		User u = deserialization(data);
//		System.out.println("u.name : " + u.getName());
//		System.out.println("u.age : " + u.getAge());
//		System.out.println("u.birth : " + (new SimpleDateFormat("yyyy-MM-dd")).format(u.getBirth()));
		
		User u = new User();
		u.setName("wangqi");
		
		User u1 = (User)get(reply(u), User.class);
		System.out.println("u1.name : " + u1.getName());
	}
	
	public static Object create(Channel channel, Class<?> api){
	    if (api == null)
	      throw new NullPointerException("api must not be null for HessianProxyFactory.create()");
	    
	    InvocationHandler handler = new HessianRpcProxy(channel, api);
	    return Proxy.newProxyInstance(api.getClassLoader(),
	                                  new Class[] { api },
	                                  handler);
	}

	
	public static byte[] serialization(Class<?> cls, String methodName, Object[] paras){
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		Hessian2Output out = new Hessian2Output(bos);	

		try {
			out.startMessage();
			out.writeLong(System.currentTimeMillis());
			out.writeString(cls.getName());
			out.writeString(methodName);
			out.writeInt(paras.length);
			for (Object para : paras){
				out.writeObject(para);
			}
			out.completeMessage();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		byte[] data = bos.toByteArray();		
		return data;
	}
	
	public static User deserialization(byte[] data){
		ByteArrayInputStream bin = new ByteArrayInputStream(data);
		Hessian2Input in = new Hessian2Input(bin);

		try {
			in.startMessage();
			in.readLong();
			
			String clsName = in.readString();
			String methodName = in.readString();
			int len = in.readInt();
			Object[] paras = new Object[len];
			Class<?>[] types = new Class<?>[len];
			for (int i = 0; i < len; i++){
				paras[i] = in.readObject();
				types[i] = paras[i].getClass();
				System.out.println("___________" + paras[i].getClass().getName());
			}
			in.completeMessage();
//			System.out.println(clsName + "." + methodName + " - " + len);
			UserService userService = new UserServiceImpl();
			Method method = userService.getClass().getMethod(methodName, types);
			if (method != null){
				User u = (User)method.invoke(userService, paras);
				return u;
			}

		} catch (IOException e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally{
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}			
		}
		return null;
	}
	
	public static byte[] reply(Object object){
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		Hessian2Output out = new Hessian2Output(bos);	

		try {
			out.startReply();
			out.writeObject(object);			
			out.completeReply();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		byte[] data = bos.toByteArray();		
		return data;
	}
	
	public static Object get(byte[] data, Class<?> returnType){
		ByteArrayInputStream bin = new ByteArrayInputStream(data);
		Hessian2Input in = new Hessian2Input(bin);
		
		Object obj = null;
		try {
			int code = in.read();
			int major = in.read();
			int minor = in.read();
			System.out.println(code + "-" + major + " - " + minor);
//			String className = in.readString();
//			System.out.println(className);
//			Class.forName(className)
			obj = in.readReply(returnType);
//			obj = in.readObject();			
			in.completeReply();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally{
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}			
		}
		return obj;
	}
}
