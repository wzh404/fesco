package com.neowave.screening.util;

 import java.security.MessageDigest;  
import java.util.Formatter;

 /**  
  * 对密码进行加密和验证的类 
  */  
 public class CipherUtil{  
       
     private final static String[] hexDigits = {"0", "1", "2", "3", "4",  
         "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"};  
       
     /** * 把inputString加密     */  
     public static String generatePassword(String inputString){  
         return encodeByMD5(inputString);  
     }  
       
      
     public static boolean validatePassword(String password, String inputString){  
         if(password.equals(encodeByMD5(inputString))){  
             return true;  
         } else{  
             return false;  
         }  
     }  
     public static String returnEncodeByMde(String originString){
    	 return encodeByMD5(originString);
     }
     /**  对字符串进行MD5加密     */  
     private static String encodeByMD5(String originString){  
         if (originString != null){  
             try{  
                 MessageDigest md = MessageDigest.getInstance("MD5");  
                 //使用指定的字节数组对摘要进行最后更新，然后完成摘要计算  
                 byte[] results = md.digest(originString.getBytes());  
                 //将得到的字节数组变成字符串返回  
                 String resultString = byteArrayToHexString(results);  
                 String pass =  resultString.toUpperCase();  
                 return pass;
             } catch(Exception ex){  
                 ex.printStackTrace();  
             }  
         }  
         return null;  
     }  
       
   
     private static String byteArrayToHexString(byte[] b){  
         StringBuffer resultSb = new StringBuffer();  
         for (int i = 0; i < b.length; i++){  
             resultSb.append(byteToHexString(b[i]));  
         }  
         return resultSb.toString();  
     }  
       
     /** 将一个字节转化成十六进制形式的字符串     */  
     private static String byteToHexString(byte b){  
         int n = b;  
         if (n < 0)  
             n = 256 + n;  
         int d1 = n / 16;  
         int d2 = n % 16;  
         return hexDigits[d1] + hexDigits[d2];  
     } 
     
     public static byte[] intToByteArray(int i) {  
 		byte[] result = new byte[4];  
 		
 		//由高位到低位
 		result[0] = (byte)((i >> 24) & 0xFF);
 		result[1] = (byte)((i >> 16) & 0xFF);
 		result[2] = (byte)((i >> 8) & 0xFF);
 		result[3] = (byte)(i & 0xFF);
 		
 		return result;		
 	}
     
     /**
      * 
      * intXToByteArray:<br/>
      * 
      * TODO(字节顺序：Big-endian).<br/>
      *
      * @author Administrator
      * @param i
      * @return
      * @since JDK 1.6
      */
     public static byte[] intXToByteArray(int i) {  
  		byte[] result = new byte[4];  
  		
  		//由高位到低位
  		result[3] = (byte)((i >> 24) & 0xFF);
  		result[2] = (byte)((i >> 16) & 0xFF);
  		result[1] = (byte)((i >> 8) & 0xFF);
  		result[0] = (byte)(i & 0xFF);
  		
  		return result;		
  	}
 	
 	public static int byteArrayToInt(byte[] bytes) {
 		int value= 0;
 		
 		//由高位到低位 		
 		for (int i = 0; i < 4; i++) {
 			int shift= (4 - 1 - i) * 8;
 			value += (bytes[i] & 0x000000FF) << shift;//往高位游
 		}
 		
 		return value;		
 	}
 	
 	public static int byteArrayToIntX(byte[] bytes) {
 		int value= 0;
 		
 		//由高位到低位 		
 		for (int i = 3; i >=0; i--) {
 			int shift= i * 8;
 			value += (bytes[i] & 0xFF) << shift;
 			//System.out.println(i + ":" + value + ":" + bytes[i]);
 		}
 		
 		return value;		
 	}

 	public static String bytesToHexString(byte[] bytes) { 
 	    StringBuilder sb = new StringBuilder(bytes.length * 2);  
 	  
 	    Formatter formatter = new Formatter(sb);  
 	    for (byte b : bytes) {  
 	        formatter.format("%02x", b);
 	    }  
 	  
 	    return sb.toString();  
 	}
 	
 	public static byte[] hexStringToBytes(String hex){
 		String sf = "0x" + hex;
 		int intf = Integer.decode(sf);
	    
	    byte[] bf = CipherUtil.intToByteArray(intf);
	    
	    return bf;
 	}
 	
 	public static int getInteger(String hex, String priKey){
	    byte[] bf = hexStringToBytes(hex);
	    byte[] key = hexStringToBytes(priKey);
	    for (int i = 0; i < 4; i++){
	    	bf[i] = (byte) (bf[i] ^ key[i]);
	    }
	    int k = CipherUtil.byteArrayToIntX(bf);
	    
	    return k;
 	}
     
    public static void main(String[] args){
    	byte[] b1 = intXToByteArray(1);
    	
    	//byte[] b = intToByteArray(19);
    	//System.out.println(bytesToHexString(b));
    	
    	byte[] k = hexStringToBytes("10203040");
    	
    	byte[] bf = new byte[4];
    	for (int i = 0; i < 4; i++){
	    	bf[i] = (byte) (b1[i] ^ k[i]);
	    }
    	
    	String a = "A";
    	String b = "B";
    	String ab = "AB";
    	
    }
 }  