package beta.javaseis.examples.io;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException; 

public class PartNorm {
	
	
	public static double sliceNormComponent(Seisio sio, int[] position,int norm) throws SeisException {
		 
	    int ntrc = sio.readFrame(position) ;
	//  System.out.println(Arrays.toString(position));
	    
	    double f = 0.0 ;
	//  int nbElt = 0 ;
	
		double min2 = 999.00;
		double max2 = -999.00;
		
	    float[][] trc = sio.getTraceDataArray();
	    
	    for (int j=0; j<ntrc; j++) {
	    	
	    	double[] vals = new double[trc[j].length] ;
	    	
	        for (int i=0; i<trc[j].length; i++) {
	
    			if(norm == -999) {
    		    	
    				vals[i]=Math.abs((double)(trc[j][i]));
    				min2 = Math.min(min2, vals[i]);
    				       
    				f = (double)min2 ;
    			
    		    } else if (norm == 999) {
    		    
    				vals[i]=Math.abs((double)(trc[j][i]));
    				max2 = Math.max(max2, vals[i]);
    				    
    		        f = (double)max2 ;
    		      
    		    } else if (norm == 0) {
    		    
    		    	f+=(double)(1);
    		    	
    		    } else if (norm == 1) {
    		    	
    		    	f+=(double)(trc[j][i]);
    		    	
    		    } else if (norm == 2) {
    		    	
    		    	f+=(double)(trc[j][i]*trc[j][i]);
    		    	
    		    }
      		
	        }
	    }
	
	//    System.out.println("nbElt " + nbElt);  
	
	  return f ;
	
  
}
	
	
   public static double TwoDArrayNormMinusInf(float [][] trc) throws SeisException {
	  
	         int   ntrc = trc.length;
	         double min2 = 999;
	         double f = 0.0 ;
	      //   int   n = trc[0].length;

	         for (int j=0; j<ntrc; j++) {
	 	    	
	 	    	double[] vals = new double[trc[j].length] ;
	 	    	
	 	        for (int i=0; i<trc[j].length; i++) {
	 	
	     				vals[i]=Math.abs((double)(trc[j][i]));
	     				min2 =  Math.min(min2, vals[i]);
	     				       
	     				f = (double)min2 ;
		         }
	 	        
	         } 
		      
		      return f;
   }
   
   public static double ArrayNormMinusInf(float [] trc) throws SeisException {
		  
       int   ntrc = trc.length;
      // int   n = trc[0].length;

	      double min2 = 999;
	      double f = 0.0;
	      
	      for (int j=0; j<ntrc; j++) {
		    	
		    	double[] vals = new double[trc.length] ;
		    	
	    		vals[j]=Math.abs((double)(trc[j]));
	    	    min2 = Math.min(min2, vals[j]);
	    				       
	    	    f = (double)min2 ;
	      }
	      
	      return f;
}
   
   public static double TwoDArrayNormPlusInf(float [][] trc) throws SeisException {
		  
	   int   ntrc = trc.length;
       double max2 = -999;
       double f = 0.0 ;
    //   int   n = trc[0].length;

       for (int j=0; j<ntrc; j++) {
	    	
	    	double[] vals = new double[trc[j].length] ;
	    	
	        for (int i=0; i<trc[j].length; i++) {
	
   				vals[i]=Math.abs((double)(trc[j][i]));
   				max2 =  Math.max(max2, vals[i]);
   				       
   				f = (double)max2 ;
	         }
	        
       } 
       
    return f ;   
       
 }


  
   
   public static double ArrayNormPlusInf(float [] trc) throws SeisException {
		  
	         int   ntrc = trc.length;
	      // int   n = trc[0].length;

		      double max2 = -999;
		      double f = 0.0;
		      
		      for (int j=0; j<ntrc; j++) {
			    	
			    	double[] vals = new double[trc.length] ;
			    	
		    		vals[j]=Math.abs((double)(trc[j]));
		    	    max2 = Math.max(max2, vals[j]);
		    				       
		    	    f = (double)max2 ;
		      }
		      
		      return f;
}
   
   
   public static double TwoDArrayNormScalar(float [][] trc, double norm) throws SeisException {
		  
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
   
  
   public static double ArrayNormScalar(float [] trc, double norm) throws SeisException {
		  
       int   m = trc.length;
       
	     double s = 0;
	      
	      for (int i = 0; i < m; i++) {
	      
	        //	f =  Math.abs(trc[i]);
	            s += Math.pow(Math.abs(trc[i]),norm);
	      
	      }
	      
	      return s;
}
   
  
   
  
}