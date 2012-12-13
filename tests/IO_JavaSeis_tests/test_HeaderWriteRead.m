%Test of the HeaderWrite and HeaderRead functions
dirname=[pwd '/TestHeaderWriteRead'];
mkdir(dirname);

Written_SDCheader=SDCpckg.basicHeaderStruct([10 10],'double',1,'varName',...
    'velocity','varUnits','m/s','origin',[1 2],'delta',[7 7],'unit',...
    {'m','m'},'label',{'x','y'})
SDCpckg.io.JavaSeis.serial.HeaderWrite(dirname,header);

Read_SDCheader=SDCpckg.io.JavaSeis.serial.HeaderRead(dirname)

%Deletion of the TestHeaderWriteRead directory if wished by the user
disp 'Delete test directory ? [y/n]';
decision_not_made=true;
while decision_not_made
    decision=input('','s');
    if strcmp(decision,'y')
        rmdir(dirname,'s');
        decision_not_made=false;
    elseif strcmp(decision,'n')
        decision_not_made=false;
    end
end