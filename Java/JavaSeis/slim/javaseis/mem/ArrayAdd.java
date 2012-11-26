package slim.javaseis.mem;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException; 

public class ArrayAdd {
	
	public static double[][] sliceAddComponent(Seisio sio,Seisio sio2,int[] position) throws SeisException {
		 
	    int ntrc2 = sio2.readFrame(position) ;
		
	    float[][] trc = sio.getTraceDataArray() ;
	    float[][] trc2 = sio2.getTraceDataArray() ;
	   
	    double[] vals2 = {0} ;
	    
	    double[][] NewSlice= new double[ntrc2][];
	   
	    for (int n = 0;n<NewSlice.length;n++){
	    	
	    	NewSlice[n] = new double[n+1];
	    }
	    
         for (int j=0; j<ntrc2; j++) {
	    	
	    	vals2 = new double[trc2[j].length] ;
	    	
	        for (int i=0; i<trc2[j].length; i++) {
	        	
	        	vals2[i] = (double)trc2[j][i] + (double)trc[j][i];
    	       	
	        }
	        
	        NewSlice[j] = vals2 ;
	    
	    } 
	
	  return NewSlice ;
	
	} 
}