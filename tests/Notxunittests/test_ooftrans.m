function test_ooftrans(trials)
    labs = matlabpool('size');
    for t=1:trials

        all = tic;
        ds = randi([labs 16],1,randi([1 3],1,1));
        de = randi([labs 16],1,randi([1 3],1,1));
        ds = [2 3];
        de = [4];

        lds = length(ds);
        lde = length(de);
        dIn = [ds de];
        dOut = [de ds];
        pIn = [prod(ds) prod(de)];
        pOut = [prod(de) prod(ds)];

        dds = prod(ds(1:end-1))*SDCpckg.utils.defaultDistribution(ds(end));
        dde = prod(de(1:end-1))*SDCpckg.utils.defaultDistribution(de(end));

        D = 1:prod(dIn);
        D = reshape(D,dIn);
        In = reshape(D,pIn);
        D = distributed(D);

        spmd % prepare ooc dummy and its transpose
            c = codistributor1d.defaultPartition(ds(end));
            c = codistributor1d(lds,c,dIn);
            Ds = redistribute(D,c); 
            c = codistributor1d(1,dde,pOut);
            De = codistributed.zeros(pOut,c);
        end

        tds=ConDir();
        SDCpckg.io.NativeBin.dist.FileWrite(path(tds),D,0);
        tdd=ConDir();
        tdds=ConDistDirs();
        SDCpckg.io.NativeBin.dist.FileDistribute(path(tds),path(tdd),path(tdds),lds)
        tdt=ConDir();
        oofcs = tic;
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tds),path(tdt),lds)
        oofcs = toc(oofcs);
        dummy = SDCpckg.io.NativeBin.dist.FileRead(path(tdt));
        assert(isequal(In',reshape(dummy,pOut)),'error in serial')
        tddt=ConDir();
        tddts=ConDistDirs();
        oofcd = tic;
        SDCpckg.io.NativeBin.dist.FileTranspose(path(tdd),path(tddt),path(tddts))%,partition
        oofcd = toc(oofcd);
        tdg = ConDir();
        SDCpckg.io.NativeBin.dist.FileGather(path(tddt),path(tdg));
        dummy = SDCpckg.io.NativeBin.serial.FileRead(path(tdg));
        assert(isequal(In',reshape(dummy,pOut)),'error in distributed')
        %return

        trans = tic;
        De = test_ooftrans_helper(Ds,De);
        trans = toc(trans);

        De = gather(De);
        Out = In';
        assert(isequal(De,Out));
        all = toc(all);
        fprintf('trial=%2d lelm=%5d relm=%5d oofcs=%5.2f oofcd=%5.2f inc=%5.2f all=%5.2f\n',t,prod(ds),prod(de),oofcs,oofcd,trans,all)
    end
end

function De = test_ooftrans_helper(Ds,De)

    labs = matlabpool('size');
    hdri = SDCpckg.basicHeaderStructFromX(Ds);
    hdri = SDCpckg.addDistHeaderStructFromX(hdri,Ds);
    %hdri.distribution

    ds = hdri.size(1:hdri.distribution.dim);
    pds = prod(ds);
    pds1 = prod(ds(1:end-1));
    dds = pds1*SDCpckg.utils.defaultDistribution(ds(end));
    irng = zeros(labs,2);
    indx_rng = hdri.distribution.indx_rng;
    for l = 1:labs
        irng(l,1) = (indx_rng{l}(1)-1)*pds1+1;
        irng(l,2) = (indx_rng{l}(2))*pds1;
    end

    de = hdri.size(hdri.distribution.dim+1:end);
    pde = prod(de);
    pde1 = prod(de(1:end-1));
    dde = pde1*SDCpckg.utils.defaultDistribution(de(end));

    spmd
        lDs = getLocalPart(Ds);
        lDs = lDs(:)';
        lDe = getLocalPart(De);
        for s=1:pds
            if s>=irng(labindex,1) & s<=irng(labindex,2)
                lp = lDs(s-irng(labindex,1)+1:dds(labindex):end);
                lp = lp';
            else
                lp = zeros(0,1);
            end
            for l=1:labs
                if s>=irng(l,1) & s<=irng(l,2); sender = l; end
            end
            cin = zeros(1,labs); cin(1,sender) = pde;
            cin = codistributor1d(1,cin,[pde 1]);
            LP = codistributed.build(lp,cin,'noCommunication');
            cin = codistributor1d(1,dde,[pde 1]);
            LP = redistribute(LP,cin);
            De(:,s)=LP;
        end
    end
end
