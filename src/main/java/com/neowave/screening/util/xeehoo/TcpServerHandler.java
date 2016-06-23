package com.neowave.screening.util.xeehoo;

import com.neowave.screening.util.HessianTcpClient;
import com.neowave.screening.util.User;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

public class TcpServerHandler extends ChannelInboundHandlerAdapter {
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg) {
		System.out.println(msg.getClass().toString());
		ByteBuf buf = (ByteBuf) msg;
		byte[] bytes = new byte[buf.readableBytes()];
		buf.readBytes(bytes);		
		buf.release();
		
		User u = HessianTcpClient.deserialization(bytes);
		System.out.println("u.name : " + u.getName());
		System.out.println("u.age : " + u.getAge());
		System.out.println("u.birth : " + u.getBirth());
		
		
		byte[] datas = HessianTcpClient.reply(u);
		try {
			ctx.channel().writeAndFlush(Unpooled.wrappedBuffer(datas)).sync();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}		
	}

	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
		cause.printStackTrace();
		ctx.close();	
	}
}
