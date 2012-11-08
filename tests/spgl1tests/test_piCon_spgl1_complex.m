function test_suite = test_piCon_spgl1_complex
initTestSuite;

    % BEGIN INITIALIZATION

    function opt = setup
        % Make sure environment is pristine
        clear all
        clear functions
        
        % Fix random generator for repeatable experiments
        defaultStream = RandStream.getDefaultStream;
        savedState = defaultStream.State;
        RandStream.setDefaultStream(RandStream('mt19937ar','seed',8888));
        
        % Make test cases
        m = 300;
        n = 1000;
        k = 20;
        
        A = complex(randn(m,n), randn(m,n));
        x = zeros(n,1);
        x(floor((n-1)*rand(k,1))+1) = complex(randn(k,1), randn(k,1)); % inject k-sparse signal in random places
        b = A*x;
        
        % Set sparse recovery element-wise relative tolerance
        recov_tol = 1e-5;
        
        % Inject options into test cases
        opt.A = A;
        opt.b = b;
        opt.x = x;
        opt.recov_tol = recov_tol;
        opt.savedState = savedState;

    function teardown(opt)
        % Restore random stream and restore variables
        defaultStream.State = opt.savedState;
        clear opt
        clear all
        clear functions
    


    % BEGIN TESTS
    
    function testParallelVectorWorks(opt)
    
        init_x = piCon.zeros(length(opt.x),1);
        
        spg_opts  = spgSetParms('verbosity' ,     1, ...
                                'subspaceMin',    0);
        [x, r, g, info] = spgl1(opt.A, opt.b, [], 1e-5, init_x, spg_opts);
        
        assertElementsAlmostEqual(undist(x), opt.x, 'absolute', opt.recov_tol);
        assertTrue(info.iter < 80);
    
    function testParallelMatrixVectorWorks(opt)
        
        init_x = piCon.zeros(length(opt.x),1);
        A = piCon(opt.A);
        b = piCon(opt.b);
        
        spg_opts  = spgSetParms('verbosity' ,     1, ...
                                'subspaceMin',    0);
        [x, r, g, info] = spgl1(A, opt.b, [], 1e-5, init_x, spg_opts);

        assertElementsAlmostEqual(undist(x), opt.x, 'absolute', opt.recov_tol);
        assertTrue(info.iter < 80);

