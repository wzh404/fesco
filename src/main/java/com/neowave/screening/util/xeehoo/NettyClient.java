package com.neowave.screening.util.xeehoo;

import com.neowave.screening.util.HessianTcpClient;
import com.neowave.screening.util.User;

import io.netty.bootstrap.Bootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.Channel;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioSocketChannel;

public class NettyClient {
	public void run(){
		EventLoopGroup group = new NioEventLoopGroup(); 
        Bootstrap b = new Bootstrap(); 
        b.group(group).channel(NioSocketChannel.class); 
        b.handler(new ChannelInitializer() {
			@Override
			protected void initChannel(Channel ch) throws Exception {
				ch.pipeline().addLast(new NettyChannelInHandler());				
			} 
        	
        });
        b.option(ChannelOption.SO_KEEPALIVE, true);        
       
        new Thread(new Runnable() {			
			@Override
			public void run() {
				try { 
		        	Channel channel = b.connect("127.0.0.1",  8000).sync().channel();
//		        	for (int i = 0; i < 10; i++){
//			        	byte[] datas = HessianTcpClient.serialization();
//			        	ByteBuf buf = Unpooled.wrappedBuffer(datas);
//			        	channel.writeAndFlush(buf).sync();
//			        	buf.release();
		        		UserService userService = (UserService)HessianTcpClient.create(channel, UserService.class);
		        		User u = userService.getUser(3);
		        		System.out.println("u.name : " + u.getName());
		        		
			        	Thread.sleep(1000L);
//		        	}
		        } catch (Exception e) { 
		        	e.printStackTrace();
		        }
		        
		        System.out.println("--------------thread end--------");				
			}
		}).run();
        
	}
	
	public static void main(String[] args){
		(new NettyClient()).run();
	}
}
