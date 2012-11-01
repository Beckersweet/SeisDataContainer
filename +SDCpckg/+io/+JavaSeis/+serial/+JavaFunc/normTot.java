package beta.javaseis.examples.io;

import java.io.File;

import java.util.Arrays;

import beta.javaseis.array.ElementType;
import beta.javaseis.array.IMultiArray;
import beta.javaseis.array.MultiArray;
import beta.javaseis.grid.GridDefinition;
import beta.javaseis.io.Seisio;
import beta.javaseis.parset.ParameterSetIO;
import beta.javaseis.util.SeisException;

import edu.mines.jtk.util.ArrayMath;
import edu.mines.jtk.util.ParameterSet;

/*
 *  Norm Test Case :
 *  Create a  JS datasets containing Random numbers
 *  Loop Over the Slices of the Dataset
 *  Calculate the Norm Component (sum) for the current Slice
 *  Gather All Norm Components to calculate the final Norm. 
 *  
 */


public class normTot {

  /**
   * @param args
   * @throws SeisException 
   */
  public static void main(String[] args) throws SeisException {    

	 // Create Random File - DATASET of size  [250, 30, 100, 10]
	 createRandomFile(args) ;  
	  
     // Convert arguments to a ParameterSet object for easy access
     ParameterSet parset = ParameterSetIO.argsToParameters( args );
    
     // Get path name for new dataset - default to "jsCreateTest" in User.home
     String path = parset.getString("path", System.getProperty("user.home") + File.separator + 
        "jsCreateTest" );

     System.out.println("Calculate Norm frame value of JavaSeis dataset\nPath: " + path );
   
    
     Seisio sio = new Seisio(path);
     sio.open("r");
 
     // Define number of Hypercubes, Volumes, Frames & Traces
     long[] Axis = sio.getGridDefinition().getAxisLengths() ;
  
     System.out.println("Axis1 = " + Axis[0]) ; // 250
     System.out.println("Axis2 = " + Axis[1]) ; // 30
     System.out.println("Axis3 = " + Axis[2]) ; // 100
     System.out.println("Axis4 = " + Axis[3]) ; // 10
    
     double normComp = 0.0 ; 
     int norm = 2 ;
 
     int i;
     int j;
  
     //for(myslice_m to myslice_m+n)
     for(j=0;j<Axis[3];j++) {
	     for(i=0;i<Axis[2];i++)  {
	
	    	int[] pos = new int[] {0,0,i,j} ;
     	//	int[] dims = new int[] {0,1} ;
		
            normComp += sliceNormComponent(sio,pos,norm);
       
            System.out.println("NormComp frame Value of dataset = " + normComp) ;
     
     	}
       }
  //end
      double normTot = 0 ;
  
      if(norm == 1 || norm == 0 || norm == 2) {
         //norm scalar   
	     double exp = 1/(double)norm ;
	     normTot = Math.pow(normComp,exp) ; 
	     //System.out.println("Norm frame Value of dataset lalala = " + normComp) ;
   
      } else if (norm == 999) {
	    // norm inf
	     normTot = Math.max(normComp,-999.00);
	     //System.out.println("Norm frame Value of dataset = " + normTot) ;
   
      } else if (norm == -999) {
	    // norm -inf 
	     normTot = Math.min(normComp,999.00) ;
	     //System.out.println("Norm frame Value of dataset = " + normTot) ;
	
  }
  
   
   System.out.println("Norm frame Value of dataset = " + normTot) ;
   
   sio.close() ;
   
  }
  
  public static void createRandomFile(String[] args) throws SeisException {
	
	  // Convert arguments to a ParameterSet object for easy access
	    ParameterSet parset = ParameterSetIO.argsToParameters(args);
	    // Get path name for new dataset - default to "jsCreateTest" in User.home
	    String path = parset.getString("path", System.getProperty("user.home")
	        + File.separator + "jsCreateTest");

	    System.out
	        .println("Create JavaSeis CDP dataset with random numbers\nPath: "
	            + path);

	  
	  // Get the size of the dataset to be created
	    int[] size = parset.getInts("size", new int[] { 250, 30, 100, 10 });
	    if (size.length != 4) {
	      throw new RuntimeException(
	          "Wrong number of elements for size - should be 4");
	    }

	    System.out.println("Size: " + Arrays.toString(size));
	    // Get the spacing of the dataset to be created

	    double[] deltas = parset.getDoubles("deltas",
	        new double[] { 4, 100, 25, 50 });
	    if (deltas.length != 4) {
	      throw new RuntimeException(
	          "Wrong number of elements for deltas - should be 4");
	    }

	    long[] ldeltas = parset.getLongs("ldeltas", new long[] { 4, 4, 1, 2 });
	    if (ldeltas.length != 4) {
	      throw new RuntimeException(
	          "Wrong number of elements for ldeltas - should be 4");
	    }

	    // Get the origins of the dataset to be created
	    double[] origins = parset
	        .getDoubles("origins", new double[] { 0, 0, 0, 0 });
	    if (origins.length != 4) {
	      throw new RuntimeException(
	          "Wrong number of elements for origins - should be 4");
	    }

	    long[] lorigins = parset.getLongs("lorigins", new long[] { 0, 1, 1, 1 });
	    if (lorigins.length != 4) {
	      throw new RuntimeException(
	          "Wrong number of elements for lorigins - should be 4");
	    }

	    // Make a GridDefinition
	    GridDefinition grid = GridDefinition.standardGrid(GridDefinition.CDP, size,
	        lorigins, ldeltas, origins, deltas);

	    // Be sure that it doesn't already exist (which is an error).
	    Seisio.delete(path);

	    // Attempt to create
	    Seisio sio = new Seisio(path, grid);
	    sio.create();
	    System.out.println("Created " + path);
	    // Use a MultiArray to hold data for writing

	    IMultiArray frm = MultiArray.factory(2, ElementType.FLOAT, 1, size);

	    float[] trc = new float[size[0]];
	    // Loop and write random numbers
	    int[] position = new int[4];
	    for (int volume = 0; volume < size[3]; volume++) {
	      System.out.println("Writing volume " + volume + " ... ");
	      position[3] = volume;
	      for (int frame = 0; frame < size[2]; frame++) {
	        position[2] = frame;
	        for (int trace = 0; trace < size[1]; trace++) {
	          ArrayMath.rand(trc);
	          position[1] = trace;
	          frm.putTrace(trc, position);
	        }
	        position[0] = position[1] = 0;
	        sio.writeMultiArray(frm, position);
	      }
	    }

	    // Close and that's all, folks !
	    sio.close();
	    System.out.println("Write complete - yeah");
	  
  }
  
  
  public static double sliceNormComponent(Seisio sio, int[] position,int norm) throws SeisException {
	 
     
	  //  Seisio sio = new Seisio(path);
	  //  sio.open("r");
	    sio.readFrame(position) ;
	  
	    
	    double f = 0.0 ;
	   
	    		
	    float[][] trc = sio.getTraceDataArray();
	    
    
    		    
    			if(norm == -999) {
    		    	
    				f  = fileNormInf(trc) ;
    				
    		    } else if (norm == 999) {
    		    	
    		    	f  = fileNormPInf(trc) ;
    		    	
    		    } else if (norm == 0) {
    		    
    		        f = fileNormScalar(trc,0) ;
    		    	
    		    } else if (norm == 1) {
    		    	
    		    	 f = fileNormScalar(trc,1) ;
    		    	
    		    } else if (norm == 2) {
    		    	
    		     f = fileNormScalar(trc,2) ;
    		    	
    		    }
      		
      	
	//  sio.close() ;
	    
	
	  return f ;
	
  
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





  
}
  

