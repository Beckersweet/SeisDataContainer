package beta.javaseis.examples.io;

import java.util.Iterator;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException;

public class normTot {

  public static double sliceNormComponent(Seisio sio, int[] position,int norm) throws SeisException {
 
	    int ntrc = sio.readFrame(position) ;
	//  System.out.println(Arrays.toString(position));
	    
	    double f = 0.0 ;
	//  int nbElt = 0 ;
	    double min = 999.00;
		double min2 = 999.00;
	    		
		double max = -999.00;
		double max2 = -999.00;
		
	    float[][] trc = sio.getTraceDataArray();
	    
	    for (int j=0; j<ntrc; j++) {
	    	
	    	double[] vals = new double[trc[j].length] ;
	    	
	        for (int i=0; i<trc[j].length; i++) {
    		    
	//        	nbElt+=1;
	        	
    			if(norm == -999) {
    		    	
    				vals[i]=Math.abs((double)(trc[j][i]));
    				min2 = Math.min(min2, vals[i]);
    				  
    				min = Math.min(min,min2); 
    				       
    				f = (double)min ;
    			
    		    } else if (norm == 999) {
    		    
    				vals[i]=Math.abs((double)(trc[j][i]));
    				max2 = Math.max(max2, vals[i]);
    			
    				max = Math.min(max,max2); 
    				    
    		        f = (double)max ;
    		      
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
	    
	    double f = 0.0 ;
        double finallala = 0.0;
        
        double min = 999.00;
		double min2 = 999.00;
		
		double max = -999.00;
		double max2 = -999.00;
	
	     // Define number of Hypercubes, Volumes, Frames & Traces
	     long[] Axis = sio.getGridDefinition().getAxisLengths() ;
	    	  
	     System.out.println("nbSam = " + Axis[0]) ; // 250
	     System.out.println("nbTrc = " + Axis[1]) ; // 30
	     System.out.println("nbFra = " + Axis[2]) ; // 100
	     System.out.println("nbVol = " + Axis[3]) ; // 10
	    
	     
	     int[] pos = {0,0,0,0};
	     
	     int ntrc = sio.readFrame(pos);
	     
	     float[][] trc = sio.getTraceDataArray();
	    
	 
	   System.out.println("number of traces " + ntrc);
	    
	   if(norm == -999) {
		   
		   for (int j=0; j<ntrc; j++) {
			   
			   double[] vals = new double[trc[j].length] ;
			   
		        for (int i=0; i<trc[j].length; i++) {
		        	
		        	  vals[i]=Math.abs((double)(trc[j][i]));
		              min2 = Math.min(min2, vals[i]);
		        	
		        }
		        
		       min = Math.min(min,min2); 
		     
		      }
		   
		//   f = (double)min;
		   
		   
	   } else if (norm == 999) {
		   
               for (int j=0; j<ntrc; j++) {
			   
			       double[] vals = new double[trc[j].length] ;
			   
		           for (int i=0; i<trc[j].length; i++) {
		        	
		        	  vals[i]=Math.abs((double)(trc[j][i]));
		        	  max2 = Math.max(max2, vals[i]);
		        	
		        }
		        
		           max = Math.min(max,max2); 
		          
		      } 
		   
          //  f = (double)max;
		   
	   } else if (norm == 0) {
		   
		   for (int j=0; j<ntrc; j++) {
		        for (int i=0; i<trc[j].length; i++) {
		        	
		        	f+=(double)(1);
		       
		        	
		        }
		      }
		   
	   } else if (norm == 1) { 
			   
		   for (int j=0; j<ntrc; j++) {
		        for (int i=0; i<trc[j].length; i++) {
		        	
		        	f+=(double)(trc[j][i]);
		       
		        	
		        }
		      }	   
			   
      } else if (norm == 2) {
		   
		   
	   
	    for (int j=0; j<ntrc; j++) {
	        for (int i=0; i<trc[j].length; i++) {
	        	
	        	f+=(double)(trc[j][i]*trc[j][i]);
	       
	        	
	        }
	      }
	   
       }
	    
	    Iterator<int[]> frames = sio.frameIterator();
	   
	    // Loop over frames and calculate Norm value
	    while (frames.hasNext()) {
	    //  nbF+=1	;
	    	
	      frames.next();
	     
	      ntrc = sio.getTracesInFrame();
	      
	      if(norm == -999) {
			  
			   for (int j=0; j<ntrc; j++) {
				   
				   double[] vals = new double[trc[j].length] ;
				   
			        for (int i=0; i<trc[j].length; i++) {
			        	
			        	  vals[i]=Math.abs((double)(trc[j][i]));
			              min2 = Math.min(min2, vals[i]);
			        	
			        }
			        
			       min = Math.min(min,min2); 
			       
			      }
			   
			   finallala = min ;
			   
			   
	      } else if(norm == 999) {
	    	 
	               for (int j=0; j<ntrc; j++) {
				   
				       double[] vals = new double[trc[j].length] ;
				   
			           for (int i=0; i<trc[j].length; i++) {
			        	
			        	  vals[i]=Math.abs((double)(trc[j][i]));
			        	  max2 = Math.max(max2, vals[i]);
			        	
			        }
			        
			           max = Math.min(max,max2); 
			      } 
	               
	               
	             finallala = max ;  
	               
	      } else if (norm == 0) {
    		    

		      double exp = 1/(double)norm ;
	    	  
	    	  for (int j=0; j<ntrc; j++) {
				   for (int i=0; i<trc[j].length; i++) {
	    	  
    		    	f+=(double)(1);
    		    	
				   }
	    	  }
    		    
    			    finallala = Math.pow(f,exp) ; 
    		    	
    	  } else if (norm == 1) {
    		  

		     double exp = 1/(double)norm ;
    		  
    		  for (int j=0; j<ntrc; j++) {
				   for (int i=0; i<trc[j].length; i++) {
	    	  
    		    	
    		    	f+=(double)(trc[j][i]);
    		    	
				   }
    		  }
    		    
    			    finallala = Math.pow(f,exp) ; 
    			    
    		    	
    	  } else if (norm == 2) {
    	
	    	  for (int j=0; j<ntrc; j++) {
				   for (int i=0; i<trc[j].length; i++) {
    		  
    		    	f+=(double)(trc[j][i]*trc[j][i]);
				   }
	    	  }
    		    	finallala = Math.sqrt(f);
    		   
    		    	
    	   }
    			
	     }
	   
      		
	  
      	
	 // System.out.println("number of FRAMES " + nbF);  
	    
      sio.close() ;
	    
     // finallala = Math.sqrt(f);
      
      
      return finallala ;
	
 }



public static double fileNormInf(float [][] trc) throws SeisException {

       int   m = trc.length;
       int   n = trc[0].length;

	    //  double f = -999;
       double s = 0;
       
	      for (int i = 0; i < m; i++) {
	        
	         for (int j = 0; j < n; j++) {
	            s += Math.abs(trc[i][j]);
	         }
	       //  System.out.println(Arrays.toString(trc[i]));
	       //  f = Math.max(f,s);
	      }
	    
		return s ;
}



public static double fileNormPInf(float [][] trc) throws SeisException {
	  
 int   m = trc.length;
 int   n = trc[0].length;

  //  double f = 999;
      double s = 0;   
 
    for (int i = 0; i < m; i++) {
      // double s = 0;
       for (int j = 0; j < n; j++) {
          s += Math.abs(trc[i][j]);
       }
//  System.out.println(Arrays.toString(trc[i]));
     //  f = Math.min(f,s);
    }
    
    return s;
}





public static double fileNormScalar(float [][] trc, double norm) throws SeisException {
	  
 int   m = trc.length;
 int   n = trc[0].length;

   double f = 0.0;
   double s = 0.0;
    
    for (int i = 0; i < m; i++) {
     //  double s = 0;
       for (int j = 0; j < n; j++) {
      	f =  Math.abs(trc[i][j]);
        s += Math.pow(f,norm);
       }
      
    }
    
    return s;
}





  
}
  

