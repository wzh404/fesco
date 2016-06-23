package com.neowave.screening.util.xeehoo;

import com.neowave.screening.util.HessianTcpClient;
import com.neowave.screening.util.User;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

public class NettyChannelInHandler extends ChannelInboundHandlerAdapter{
	@Override  
    public void channelRead(ChannelHandlerContext ctx, Object msg) {    
        System.out.println("************" + msg.getClass().toString());
        ByteBuf buf = (ByteBuf) msg;
		byte[] bytes = new byte[buf.readableBytes()];
		buf.readBytes(bytes);		
		buf.release();
		
		User u = (User)HessianTcpClient.get(bytes, User.class);
		System.out.println("Read --- u.name : " + u.getName());
    }	
}
