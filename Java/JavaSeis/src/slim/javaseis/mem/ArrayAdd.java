package beta.javaseis.examples.io;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException; 

public class ArrayAdd {
	
	public static double[][] sliceAddComponent(Seisio sio,Seisio sio2,int[] position) throws SeisException {
		 
	//    int ntrc = sio.readFrame(position) ;
	    int ntrc2 = sio2.readFrame(position) ;
	    
	//    System.out.println("ntrc" + ntrc + " ... ") ;
	//    System.out.println("ntrc2" + ntrc2 + " ... ") ;
	    
   //	  System.out.println(Arrays.toString(position)) ;
		
	    float[][] trc = sio.getTraceDataArray() ;
	    float[][] trc2 = sio2.getTraceDataArray() ;
	    
	   // double[] vals = {0} ;
	    double[] vals2 = {0} ;
	    
	    double[][] NewSlice= new double[ntrc2][];
	   
	    for (int n = 0;n<NewSlice.length;n++){
	    	
	    	NewSlice[n] = new double[n+1];
	    }
	    
	    /*
	    for (int j=0; j<ntrc; j++) {
	    	
	    	vals = new double[trc[j].length] ;
	    	
	    	//System.out.println("ntrcL" + trc[j].length + " ... ") ;
	    	
	        for (int i=0; i<trc[j].length; i++) {
	        	
	        	vals[i] = (double)trc[j][i] ;
	     
    	       	
	        }
	    } 
	    */
	    
         for (int j=0; j<ntrc2; j++) {
	    	
	    	vals2 = new double[trc2[j].length] ;
	    	//System.out.println("ntrc2L" + trc2[j].length + " ... ") ;
	    	
	        for (int i=0; i<trc2[j].length; i++) {
	        	
	          // bug 
    	      // vals[i][j] = trc[i][j] + trc2[i][j] ;
    	      // System.out.println(Arrays.toString(vals[i]));
	        	
	        //	vals[i][j] = (double)trc[i][j] ;
	        	vals2[i] = (double)trc2[j][i] + (double)trc[j][i];
	        	// System.out.println(Arrays.toString(vals2)) ;
    	       	
	        }
	        
	        NewSlice[j] = vals2 ;
	       // System.out.println(Arrays.toString(NewSlice[j])) ;
	    } 
         
	
	
	  return NewSlice ;
	
	} 
}