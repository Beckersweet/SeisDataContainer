package slim.javaseis.utils;

import java.nio.ByteOrder;
import java.util.HashMap;

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

	/** Method enabling to get the file properties in a HashMap object
	 * @param propNames
	 * 			List of the names of the file properties to get
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
}
