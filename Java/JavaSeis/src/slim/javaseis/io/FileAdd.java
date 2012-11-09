package slim.javaseis.io;

import java.util.Arrays;

import beta.javaseis.io.Seisio;
import beta.javaseis.util.SeisException;

public class FileAdd {

  public static double add(String path1,String path2) throws SeisException {
	  
	  Seisio sio1 = new Seisio(path1);
	  sio1.open("r");
	  
	  Seisio sio2 = new Seisio(path2);
	  sio2.open("r");
	   
      double finallala = 0.0;
    
      long[] Axis = sio1.getGridDefinition().getAxisLengths() ;
      long[] Axis2 = sio2.getGridDefinition().getAxisLengths() ;
      
      double [][][][]NewSlices = new double [(int) Axis[0]][(int) Axis[1]][(int) Axis[2]][(int) Axis[3]];
      
      // Axis must equal Axis2 
      System.out.println(Arrays.toString(Axis));
      System.out.println(Arrays.toString(Axis2));
	  
      int[] pos = new int[4];
      pos[1]=0;
      pos[2]=0;
      
      for(int j=0;j<Axis[3];j++) {
    	   for(int i=0;i<Axis[2];i++) {
    	   
    	       pos[3] = j ;
    	       pos[2] = i ;
	       
	           NewSlices[j][i]= slim.javaseis.io.ArrayAdd.sliceAddComponent(sio1,sio2,pos) ;
	        
	           
    	   }
      }
      
      for(int j=0;j<Axis[3];j++) {
   	      for(int i=0;i<Axis[2];i++) {
              for(int k=0;k<Axis[1];k++) {
	  
               System.out.println(Arrays.toString(NewSlices[j][i][k]));
          
	           }
   	       }
       }
      
	    
    sio1.close() ;
    sio2.close() ;
   
   
    return finallala ;
}
  
 
}