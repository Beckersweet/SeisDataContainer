package slim.javaseis.utils;

import java.nio.ByteOrder;
import java.util.HashMap;

import org.javaseis.array.ArrayUtil;
import org.javaseis.grid.GridDefinition;
import org.javaseis.io.Seisio;
import org.javaseis.properties.DataDefinition;
import org.javaseis.properties.TraceProperties;
import org.javaseis.util.SeisException;

import edu.mines.jtk.util.Parameter;

/**
 * This class inherits from JavaSeis Seisio class. It has been created to enable
 * more flexibility in the use of JavaSeis in the SeisDataContainer project.
 * This class notably gives the possibility to store supplementary SDC header
 * properties that may not be stored in the classical Seisio attributes.
 * 
 * @author Sebastien Pacteau
 * @version December 11, 2012
 */

public class SeisioSDC extends Seisio {

	private static final long serialVersionUID = 1L;

	/**
	 * @param path
	 *     		The JavaSeis file-structure path.
	 * @throws SeisException
	 */
	public SeisioSDC(String path) throws SeisException {
		super(path);
	}

	/**
	 * @param path
	 *      	The JavaSeis file path.
	 * @param gridDefinition
	 *     		The JavaSeis grid definition
	 * @throws SeisException
	 */
	public SeisioSDC(String path, GridDefinition gridDefinition)
			throws SeisException {
		super(path, gridDefinition);
	}

	/**
	 * @param path
	 *          The JavaSeis file-structure path.
	 * @param gridDefinition
	 *         	The JavaSeis grid definition.
	 * @param dataDefinition
	 *       	The JavaSeis data definition.
	 * @param headerDefinition
	 *			The JavaSeis header definition
	 * @param props
	 *			Supplementary file properties to add
	 * @throws SeisException
	 */
	public SeisioSDC(String path, GridDefinition gridDefinition,
			DataDefinition dataDefinition, TraceProperties headerDefinition,
			HashMap<String, Object> props) throws SeisException {
		super(path, gridDefinition, dataDefinition, headerDefinition);

		// Adding of the supplementary properties
		try {
			addFileProperties(props);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param path
	 *    		The JavaSeis file-structure path.
	 * @param ndim
	 *     		The number of dimensions
	 * @param idim
	 *      	The length of each dimension (?)
	 * @param byteOrder
	 *       	The byte order (big- or little-endian).
	 * @throws SeisException
	 */
	public SeisioSDC(String path, int ndim, int[] idim, ByteOrder byteOrder)
			throws SeisException {
		super(path, ndim, idim, byteOrder);
	}

	/** Method enabling to add file properties to the SeisioSDC object
	 * @param props
	 * 			File properties to add to the SeisioSDC object (stored in the
	 * 			_filePropertiesParset attribute)
	 */
	public void addFileProperties(HashMap<String, Object> props)
			throws Exception {
		int nbprops = props.size();
		Object[] fieldnames = props.keySet().toArray();
		for (int k = 0; k < nbprops; k++) {
			String key = (String) fieldnames[k];
			Object value = props.get(key);
			String supplPropType = value.getClass().getName();
			// boolean
			if (supplPropType.equals("java.lang.Boolean"))
				_filePropertiesParset.setBoolean(key, (Boolean) value);
			else if (supplPropType.equals("[Z"))
				_filePropertiesParset.setBooleans(key, (boolean[]) value);
			// double
			else if (supplPropType.equals("java.lang.Double"))
				_filePropertiesParset.setDouble(key, (Double) value);
			else if (supplPropType.equals("[D"))
				_filePropertiesParset.setDoubles(key, (double[]) value);
			// float
			else if (supplPropType.equals("java.lang.float"))
				_filePropertiesParset.setFloat(key, (Float) value);
			else if (supplPropType.equals("[F"))
				_filePropertiesParset.setFloats(key, (float[]) value);
			// int
			else if (supplPropType.equals("java.lang.Integer"))
				_filePropertiesParset.setInt(key, (Integer) value);
			else if (supplPropType.equals("[I"))
				_filePropertiesParset.setInts(key, (int[]) value);
			// long
			else if (supplPropType.equals("java.lang.Long"))
				_filePropertiesParset.setLong(key, (Long) value);
			else if (supplPropType.equals("[J"))
				_filePropertiesParset.setLongs(key, (long[]) value);
			// String
			else if (supplPropType.equals("java.lang.String"))
				_filePropertiesParset.setString(key, (String) value);
			else if (supplPropType.equals("[Ljava.lang.String;"))
				_filePropertiesParset.setStrings(key, (String[]) value);
			else
				throw new Exception(String.format("Unknown data type '%s'\n"
						+ "Allowed data types are single values or arrays of "
						+ "boolean, double, float, int, long or String",
						supplPropType));
		}
	}

	/** Method enabling to get the file properties in a HashMap object.
	 * @param propNames
	 * 			List of the names of the file properties to get
	 * 
	 * The native properties' names that can be specified in the list are:
	 * 
	 * 		SeisioSDC.COMMENTS;
	 * 		SeisioSDC.JAVASEIS_VERSION;
	 * 		SeisioSDC.DATA_TYPE;
	 * 		SeisioSDC.TRACE_FORMAT;
	 * 		SeisioSDC.BYTE_ORDER;
	 * 		SeisioSDC.MAPPED;
	 * 		SeisioSDC.DATA_DIMENSIONS;
	 * 		SeisioSDC.AXIS_LABELS;
	 * 		SeisioSDC.AXIS_UNITS;
	 * 		SeisioSDC.AXIS_DOMAINS;
	 * 		SeisioSDC.AXIS_LENGTHS;
	 * 		SeisioSDC.LOGICAL_ORIGINS;
	 * 		SeisioSDC.LOGICAL_DELTAS;
	 * 		SeisioSDC.PHYSICAL_ORIGINS;
	 * 		SeisioSDC.PHYSICAL_DELTAS;
	 * 		SeisioSDC.HEADER_LENGTH_BYTES;
	 * 
	 * 		BinGrid.BIN_GRID.
	 * 		
	 * SDC additional parameters' names (subject to potential changes in case of
	 * modification of SDC header fields' names):
	 * 
	 * 		"varName";
	 * 		"varUnits";
	 * 		"complex";
	 * 		"distributedIO".
	 * 
	 * @return Hash map containing the values of the properties whose names 
	 * 			have been specified in input
	 */			
	public HashMap<String,Object> getFileProperties(String[] propNames){
		//Number of required properties
		int nbProps=propNames.length;
		//Initialization of the hashMap
		HashMap<String,Object> hashMap=new HashMap<String,Object>();
		for (int k=0;k<nbProps;k++){
			Parameter parameter=_filePropertiesParset.getParameter(propNames[k]);
			int type=parameter.getType();
			switch(type){
			case 0: hashMap.put(propNames[k],null);break;
			case 1: hashMap.put(propNames[k],parameter.getBooleans());break;
			case 2: hashMap.put(propNames[k],parameter.getInts());break;
			case 3: hashMap.put(propNames[k],parameter.getLongs());break;
			case 4: hashMap.put(propNames[k],parameter.getFloats());break;
			case 5: hashMap.put(propNames[k],parameter.getDoubles());break;
			case 6: hashMap.put(propNames[k],parameter.getStrings());break;
			}
		}
		return hashMap;
	}

	/**
	 * Write data from a Matlab multidimensional array to an open JavaSeis 
	 * dataset.
	 * Shape must be conformable with the JavaSeis dataset axis lengths for the 
	 * subset that will be written. The multidimensional array must have at 
	 * least 2 and not more than 5 dimensions.
	 * The first "n" elements of the position array are ignored, where "n" is 
	 * the number of dimensions of the multidimensional.
	 * @param <T>
	 * 
	 * @param a multidimensional array containing data to be written
	 * @param position starting position in the JavaSeis dataset
	 * @param lengths of the Matlab multidimensional array with JavaSeis
	 * dimension conventions (i.e. same dimensions' lengths as the ones
	 * obtained using Matlab's function 'size' excepted for the 2 first lengths
	 * which are swapped)
	 * @throws SeisException on errors
	 */
	public void writeMatlabMultiArray(float[][][] a, int[] position)
			throws SeisException {
		/* Check lengths of the multidimensional array for conformance with 
		data on disk*/
		int[] alen = new int[3];
		alen[0]=a[0][0].length; //Number of samples per trace
		alen[1]=a[0].length; //Number of traces per frame
		alen[2]=a.length; //Number of frames
		long[] dlen = _gridDefinition.getAxisLengths();
		if (3 > _gridDefinition.getNumDimensions()) {
			throw new SeisException("MultiArray dimensions exceeds dataset dimensions");
		}
		for (int i = 0; i < 3; i++) {
			if (alen[i] != dlen[i])
				throw new SeisException("MultiArray size does not match dataset");
			position[i] = 0;
		}
		// Calculate number of frames to write
		int nframe = alen[2];

		// Loop and read frames into the multidimensional array
		int[] apos = new int[3];
		for (int i = 0; i < nframe; i++) {
			this.setTraceDataArray(a[position[2]]);
			writeFrame(position, _traceData.length);
			apos[2]++;
			if (apos[2] >= alen[2]) {
				apos[2] = 0;
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 3);
		}
	}

	public void writeMatlabMultiArray(float[][][][] a, int[] position)
			throws SeisException {
		/* Check lengths of the multidimensional array for conformance with 
		data on disk*/
		int[] alen = new int[4];
		alen[0]=a[0][0][0].length; //Number of samples per trace
		alen[1]=a[0][0].length; //Number of traces per frame
		alen[2]=a[0].length; //Number of frames per volume
		alen[3]=a.length; //Number of volumes

		long[] dlen = _gridDefinition.getAxisLengths();
		if (4 > _gridDefinition.getNumDimensions()) {
			throw new SeisException("MultiArray dimensions exceeds dataset dimensions");
		}
		for (int i = 0; i < 4; i++) {
			if (alen[i] != dlen[i])
				throw new SeisException("MultiArray size does not match dataset");
			position[i] = 0;
		}
		// Calculate number of frames to write
		int nframe = 1;
		for (int i = 2; i < 4; i++)
			nframe *= alen[i];

		// Loop and read frames into the multidimensional array
		int[] apos = new int[4];
		for (int i = 0; i < nframe; i++) {
			this.setTraceDataArray(a[position[3]][position[2]]);
			writeFrame(position,_traceData.length);
			apos[2]++;
			if (apos[2] >= alen[2]) {
				apos[2] = 0;
				apos[3]++;
				if (apos[3] >= alen[3]) {
					apos[3] = 0;
				}
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 4);
		}
	}

	public void writeMatlabMultiArray(float[][][][][] a, int[] position)
			throws SeisException {
		/* Check lengths of the multidimensional array for conformance with 
		data on disk*/
		int[] alen = new int[5];
		alen[0]=a[0][0][0][0].length;
		alen[1]=a[0][0][0].length;
		alen[2]=a[0][0].length;
		alen[3]=a[0].length;
		alen[4]=a.length;
		long[] dlen = _gridDefinition.getAxisLengths();
		if (5 > _gridDefinition.getNumDimensions()) {
			throw new SeisException("MultiArray dimensions exceeds dataset dimensions");
		}
		for (int i = 0; i < 5; i++) {
			if (alen[i] != dlen[i])
				throw new SeisException("MultiArray size does not match dataset");
			position[i] = 0;
		}
		// Calculate number of frames to write
		int nframe = 1;
		for (int i = 2; i < 5; i++)
			nframe *= alen[i];

		// Loop and read frames into the multidimensional array
		int[] apos = new int[5];
		for (int i = 0; i < nframe; i++) {
			this.setTraceDataArray(a[position[3]][position[3]][position[2]]);
			writeFrame(position, _traceData.length);
			apos[2]++;
			if (apos[2] >= alen[2]) {
				apos[2] = 0;
				apos[3]++;
				if (apos[3] >= alen[3]) {
					apos[3] = 0;
					apos[4]++;
				}
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 5);
		}
	}

	/**
	 * Reads data from an open JavaSeis dataset into a Matlab multidimensional
	 * array.
	 * Shape must be greater than or equal to the
	 * JavaSeis dataset axis lengths for the subset that will be read. The
	 * multidimensional array must have at least 2 and not more than 5 
	 * dimensions.
	 * The first "n" elements of the position array are ignored, where "n"
	 * is the number of dimensions of the multidimensional array.
	 * @param <T>
	 * @param a multidimensional array that will contain data on output
	 * @param position starting position in the JavaSeis dataset
	 * @throws SeisException on errors
	 */
	public Object readMatlabMultiArray(int asize,int[] position) 
			throws SeisException {

		/* Check size of the required multi array for conformance with data on 
		disk */
		if (asize > _gridDefinition.getNumDimensions()) {
			throw new SeisException("MultiArray dimensions exceeds dataset dimensions");
		}
		// Definition of the output
		Object a=null;
		// Call of the convenient method to read data from Trace file
		switch (asize){
		case 3:
			a=read3DArray(position);break;
		case 4:
			a=read4DArray(position);break;
		case 5:
			a=read5DArray(position);break;
		}
		return a;
	}

	private float[][][] read3DArray(int[] position) throws SeisException{
		long[] dlen = _gridDefinition.getAxisLengths();
		float[][][] a=new float[(int)dlen[2]][(int)dlen[1]][(int)dlen[0]];

		// Calculate number of frames to read
		int nframe = (int) dlen[2];

		//Dimensions of a frame
		int frame_width=(int) dlen[1];
		int frame_length=(int) dlen[0];

		// Loop and read frames into the multidimensional array
		int[] apos = new int[3];
		for (int i = 0; i < nframe; i++) {
			readFrame(position);
			for (int j=0;j<frame_width;j++){
				System.arraycopy(_traceData[j],0,a[position[2]][j],0,
						frame_length);
			}
			apos[2]++;
			if (apos[2] >= dlen[2]) {
				apos[2] = 0;
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 3);
		}
		return a;
	}

	private float[][][][] read4DArray(int[] position) throws SeisException {
		long[] dlen = _gridDefinition.getAxisLengths();
		float[][][][] a=new float[(int)dlen[3]][(int)dlen[2]][(int)dlen[1]]
				[(int)dlen[0]];

		// Calculate number of frames to read
		int nframe = 1;
		for (int i = 2; i < 4; i++)
			nframe *= dlen[i];

		//Dimensions of a frame
		int frame_width=(int) dlen[1];
		int frame_length=(int) dlen[0];

		// Loop and read frames into the multiarray
		int[] apos = new int[4];
		for (int i = 0; i < nframe; i++) {
			readFrame(position);
			for (int j=0;j<frame_width;j++){
				System.arraycopy(_traceData[j],0,a[position[3]][position[2]][j],
						0,frame_length);
			}
			apos[2]++;
			if (apos[2] >= dlen[2]) {
				apos[2] = 0;
				apos[3]++;
				if (apos[3] >= dlen[3]) {
					apos[3] = 0;
				}
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 4);
		}
		return a;
	}

	private float[][][][][] read5DArray(int[] position) throws SeisException {
		long[] dlen = _gridDefinition.getAxisLengths();
		float[][][][][] a=new float[(int)dlen[4]][(int)dlen[3]][(int)dlen[2]]
				[(int)dlen[1]][(int)dlen[0]];

		// Calculate number of frames to read
		int nframe = 1;
		for (int i = 2; i < 5; i++)
			nframe *= dlen[i];

		//Dimensions of a frame
		int frame_width=(int) dlen[1];
		int frame_length=(int) dlen[0];

		// Loop and read frames into the multiarray
		int[] apos = new int[5];
		position[0] = position[1] = 0;
		for (int i = 0; i < nframe; i++) {
			readFrame(position);
			for (int j=0;j<frame_width;j++){
				System.arraycopy(_traceData[j],0,a[position[4]][position[3]]
						[position[2]][j],
						0,frame_length);
			}
			apos[2]++;
			if (apos[2] >= dlen[2]) {
				apos[2] = 0;
				apos[3]++;
				if (apos[3] >= dlen[3]) {
					apos[3] = 0;
					apos[4]++;
				}
			}
			ArrayUtil.arraycopy(apos, 0, position, 0, 5);
		}
		return a;
	}
}
