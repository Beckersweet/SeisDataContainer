function test_suite = test_iCon_spgl1_complex
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
        
        A = iCon.randn(m,n) + i*randn(m,n);
        x = iCon.zeros(n,1);
        x(floor((n-1)*rand(k,1))+1) = iCon.randn(k,1) + i*randn(k,1); % inject k-sparse signal in random places
        b = A*x;
        
        % Set sparse recovery element-wise relative tolerance
        recov_tol = 3e-6;
        
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
    
    function testStandardCplxSPGL1(opt)
        spg_opts  = spgSetParms('verbosity' ,0);
        [x, r, g, info] = spgl1(opt.A, opt.b, [], 1e-5, [], spg_opts);
        norm(x-opt.x,inf);
        assertElementsAlmostEqual(x, opt.x, 'absolute', opt.recov_tol);
        assertTrue(info.iter < 58);
