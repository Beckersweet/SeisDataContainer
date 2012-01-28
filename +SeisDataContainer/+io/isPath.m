function bool = isPath(pathName)
% 
% ifExists(pathName)
% 
% Return true if the object pointed by path exists.
% 
import java.io.File;
a=File(pathName);
bool=a.exists();
end
