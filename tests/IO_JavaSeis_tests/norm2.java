package beta.javaseis.examples.io;

import beta.javaseis.util.SeisException;

public class norm2 {

   public static double fileNorm(int nbTrc, double [][] trc) throws SeisException {
	  
	    double norm = 0.0 ;
	    double sum = 0.0 ;	
	    
	    for (int j=0; j < nbTrc; j++) {
	        for (int i=0; i<trc[j].length; i++) {
	        
	            sum = sum + (double)(trc[j][i]*trc[j][i]);
	        }
	     }
	    
	    norm = Math.sqrt(sum);
	    
	   
   return norm ;
	  
  }
   
 
 
}
  
