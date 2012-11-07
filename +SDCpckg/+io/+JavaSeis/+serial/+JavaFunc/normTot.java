package beta.javaseis.examples.io;

import java.util.Arrays;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException;

public class normTot {

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
  
  public static double FileNorm(String path,int norm) throws SeisException {
	  
	  Seisio sio = new Seisio(path);
	  sio.open("r");
	   
      double finallala = 0.0;
      double normComp = 0.0;
      
      double exp = 1/(double)norm ;
      
      long[] Axis = sio.getGridDefinition().getAxisLengths() ;
	  
      for(int j=0;j<Axis[3];j++) {
     
    	   for(int i=0;i<Axis[2];i++) {
    	   
    	       int[] pos = {0,0,i,j} ;
    	   
	           System.out.println(Arrays.toString(pos));
	       
	           
	           if (norm == 1 || norm == 0 || norm ==2) {
	           
	               normComp += sliceNormComponent(sio,pos,norm) ;
	           
	           } else if (norm == 999 || norm == -999) {
	        	   
	        	   normComp = sliceNormComponent(sio,pos,norm) ;
	           }
    	   }
	    }     
	    
    sio.close() ;
	
    if (norm == 999) {
    	
    	finallala = normComp ;
    	
    } else if (norm == -999) {
    	
    	finallala = normComp ;
    	
    } else if (norm == 0 || norm == 1 || norm == 2) {
    
      finallala = Math.pow(normComp,exp);
    
    }
    
    return finallala ;
}
  
}
  

