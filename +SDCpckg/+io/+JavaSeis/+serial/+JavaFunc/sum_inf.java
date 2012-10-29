package beta.javaseis.examples.io;

import java.util.Arrays;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException;
import jama.Matrix ; 

public class sum_inf {
	
	
   public static double fileNormInf(float [][] trc) throws SeisException {
	  
	         int   m = trc.length;
	         int   n = trc[0].length;

		      double f = -999;
		      
		      for (int i = 0; i < m; i++) {
		         double s = 0;
		         for (int j = 0; j < n; j++) {
		            s += Math.abs(trc[i][j]);
		         }
		       //  System.out.println(Arrays.toString(trc[i]));
		         f = Math.max(f,s);
		      }
		      
		      return f;
   }
   
   public static double fileNormVectInf(float [] trc) throws SeisException {
		  
       int   m = trc.length;
      // int   n = trc[0].length;

	      double f = -999;
	      
	      for (int i = 0; i < m; i++) {
	         double s = 0;
	  //       for (int j = 0; j < n; j++) {
	            s += Math.abs(trc[i]);
	  //       }
	  //     System.out.println(Arrays.toString(trc[i]));
	         f = Math.max(f,s);
	      }
	      
	      return f;
}
   
   public static double fileNormPInf(float [][] trc) throws SeisException {
		  
       int   m = trc.length;
       int   n = trc[0].length;

	      double f = 999;
	      
	      for (int i = 0; i < m; i++) {
	         double s = 0;
	         for (int j = 0; j < n; j++) {
	            s += Math.abs(trc[i][j]);
	         }
	  //  System.out.println(Arrays.toString(trc[i]));
	         f = Math.min(f,s);
	      }
	      
	      return f;
}

  
   
   public static double fileNormVectPInf(float [] trc) throws SeisException {
		  
       int   m = trc.length;
     //  int   n = trc[0].length;

	      double f = 999;
	      
	      for (int i = 0; i < m; i++) {
	         double s = 0;
	      
	            s += Math.abs(trc[i]);
	    
	  //  System.out.println(Arrays.toString(trc[i]));
	         f = Math.min(f,s);
	      }
	      
	      return f;
}
   
   
   public static double fileNormScalar(float [][] trc, double norm) throws SeisException {
		  
       int   m = trc.length;
       int   n = trc[0].length;

	     double f = 0.0;
	     double s = 0;
	      
	      for (int i = 0; i < m; i++) {
	       //  double s = 0;
	         for (int j = 0; j < n; j++) {
	        	f =  Math.abs(trc[i][j]);
	            s += Math.pow(f,norm);
	         }
	        
	      }
	      
	      return s;
}
   
  
   public static double fileNormVectScalar(float [] trc, double norm) throws SeisException {
		  
       int   m = trc.length;
     //  int   n = trc[0].length;

	  //   double f = 0.0;
	     double s = 0;
	      
	      for (int i = 0; i < 840; i++) {
	      
	        //	f =  Math.abs(trc[i]);
	            s += Math.pow(Math.abs(trc[i]),norm);
	      
	        
	      }
	      
	      return s;
}
   
  
}
