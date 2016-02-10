# Copyright (C) 2012-2013 Robert Schwarz
#   see file 'LICENSE' for details.

cdef extern from "scip/scip.h":
    # SCIP internal types
    ctypedef enum SCIP_RETCODE:
        SCIP_OKAY               =   1
        SCIP_ERROR              =   0
        SCIP_NOMEMORY           =  -1
        SCIP_READERROR          =  -2
        SCIP_WRITEERROR         =  -3
        SCIP_NOFILE             =  -4
        SCIP_FILECREATEERROR    =  -5
        SCIP_LPERROR            =  -6
        SCIP_NOPROBLEM          =  -7
        SCIP_INVALIDCALL        =  -8
        SCIP_INVALIDDATA        =  -9
        SCIP_INVALIDRESULT      = -10
        SCIP_PLUGINNOTFOUND     = -11
        SCIP_PARAMETERUNKNOWN   = -12
        SCIP_PARAMETERWRONGTYPE = -13
        SCIP_PARAMETERWRONGVAL  = -14
        SCIP_KEYALREADYEXISTING = -15
        SCIP_MAXDEPTHLEVEL      = -16

    ctypedef enum SCIP_VARTYPE:
        SCIP_VARTYPE_BINARY     = 0
        SCIP_VARTYPE_INTEGER    = 1
        SCIP_VARTYPE_IMPLINT    = 2
        SCIP_VARTYPE_CONTINUOUS = 3

    ctypedef enum SCIP_OBJSENSE:
        SCIP_OBJSENSE_MAXIMIZE = -1
        SCIP_OBJSENSE_MINIMIZE =  1

    ctypedef enum SCIP_RESULT:
        SCIP_DIDNOTRUN   =   1
        SCIP_DELAYED     =   2
        SCIP_DIDNOTFIND  =   3
        SCIP_FEASIBLE    =   4
        SCIP_INFEASIBLE  =   5
        SCIP_UNBOUNDED   =   6
        SCIP_CUTOFF      =   7
        SCIP_SEPARATED   =   8
        SCIP_NEWROUND    =   9
        SCIP_REDUCEDDOM  =  10
        SCIP_CONSADDED   =  11
        SCIP_CONSCHANGED =  12
        SCIP_BRANCHED    =  13
        SCIP_SOLVELP     =  14
        SCIP_FOUNDSOL    =  15
        SCIP_SUSPENDED   =  16
        SCIP_SUCCESS     =  17

    ctypedef enum SCIP_STATUS:
        SCIP_STATUS_UNKNOWN        =  0
        SCIP_STATUS_USERINTERRUPT  =  1
        SCIP_STATUS_NODELIMIT      =  2
        SCIP_STATUS_TOTALNODELIMIT =  3
        SCIP_STATUS_STALLNODELIMIT =  4
        SCIP_STATUS_TIMELIMIT      =  5
        SCIP_STATUS_MEMLIMIT       =  6
        SCIP_STATUS_GAPLIMIT       =  7
        SCIP_STATUS_SOLLIMIT       =  8
        SCIP_STATUS_BESTSOLLIMIT   =  9
        SCIP_STATUS_RESTARTLIMIT   = 10
        SCIP_STATUS_OPTIMAL        = 11
        SCIP_STATUS_INFEASIBLE     = 12
        SCIP_STATUS_UNBOUNDED      = 13
        SCIP_STATUS_INFORUNBD      = 14

    ctypedef enum SCIP_PARAMSETTING:
        SCIP_PARAMSETTING_DEFAULT = 0
        SCIP_PARAMSETTING_AGGRESSIVE = 1
        SCIP_PARAMSETTING_FAST = 2
        SCIP_PARAMSETTING_OFF = 3

    ctypedef bint SCIP_Bool

    ctypedef long SCIP_Longint

    ctypedef float SCIP_Real

    ctypedef struct SCIP:
        pass

    ctypedef struct SCIP_VAR:
        pass

    ctypedef struct SCIP_CONS:
        pass

    ctypedef struct SCIP_ROW:
        pass

    ctypedef struct SCIP_SOL:
        pass

    ctypedef struct FILE:
        pass

    ctypedef struct SCIP_PRICER:
        pass

    ctypedef struct SCIP_PRICERDATA:
        pass

    ctypedef struct SCIP_SEPA:
        pass

    ctypedef struct SCIP_SEPADATA:
        pass

    ctypedef struct SCIP_CONSHDLR:
        pass

    ctypedef struct SCIP_CONSHDLRDATA:
        pass

    ctypedef struct SCIP_CONSDATA:
        pass

    # General SCIP Methods
    SCIP_RETCODE SCIPcreate(SCIP** scip)
    SCIP_RETCODE SCIPfree(SCIP** scip)
    void SCIPsetMessagehdlrQuiet(SCIP* scip, SCIP_Bool quiet)

    # Global Problem Methods
    SCIP_RETCODE SCIPcreateProbBasic(SCIP* scip, char* name)
    SCIP_RETCODE SCIPfreeProb(SCIP* scip)
    SCIP_RETCODE SCIPaddVar(SCIP* scip, SCIP_VAR* var)
    SCIP_RETCODE SCIPdelVar(SCIP* scip, SCIP_VAR* var, SCIP_Bool* deleted)
    SCIP_RETCODE SCIPaddCons(SCIP* scip, SCIP_CONS* cons)
    SCIP_RETCODE SCIPdelCons(SCIP* scip, SCIP_CONS* cons)
    SCIP_RETCODE SCIPsetObjsense(SCIP* scip, SCIP_OBJSENSE objsense)
    SCIP_OBJSENSE SCIPgetObjsense(SCIP* scip)
    SCIP_RETCODE SCIPsetObjlimit(SCIP* scip, SCIP_Real objlimit)
    SCIP_RETCODE SCIPsetPresolving(SCIP* scip, SCIP_PARAMSETTING paramsetting, SCIP_Bool quiet)
    SCIP_RETCODE SCIPwriteOrigProblem(SCIP* scip, char* filename, char* extension, SCIP_Bool genericnames)
    SCIP_STATUS SCIPgetStatus(SCIP* scip)

    # Solve Methods
    SCIP_RETCODE SCIPsolve(SCIP* scip)
    SCIP_RETCODE SCIPfreeTransform(SCIP* scip)

    # Variable Methods
    SCIP_RETCODE SCIPcreateVarBasic(SCIP* scip,
                                    SCIP_VAR** var,
                                    char* name,
                                    SCIP_Real lb,
                                    SCIP_Real ub,
                                    SCIP_Real obj,
                                    SCIP_VARTYPE vartype)
    SCIP_RETCODE SCIPchgVarObj(SCIP* scip, SCIP_VAR* var, SCIP_Real newobj)
    SCIP_RETCODE SCIPchgVarLb(SCIP* scip, SCIP_VAR* var, SCIP_Real newbound)
    SCIP_RETCODE SCIPchgVarUb(SCIP* scip, SCIP_VAR* var, SCIP_Real newbound)
    SCIP_RETCODE SCIPcaptureVar(SCIP* scip, SCIP_VAR* var)
    SCIP_RETCODE SCIPaddPricedVar(SCIP* scip, SCIP_VAR* var, SCIP_Real score)
    SCIP_RETCODE SCIPreleaseVar(SCIP* scip, SCIP_VAR** var)
    SCIP_RETCODE SCIPtransformVar(SCIP* scip, SCIP_VAR* var, SCIP_VAR** transvar)
    SCIP_VAR** SCIPgetVars(SCIP* scip)
    const char* SCIPvarGetName(SCIP_VAR* var)
    int SCIPgetNVars(SCIP* scip)

    # Constraint Methods
    SCIP_RETCODE SCIPcaptureCons(SCIP* scip, SCIP_CONS* cons)
    SCIP_RETCODE SCIPreleaseCons(SCIP* scip, SCIP_CONS** cons)
    SCIP_RETCODE SCIPtransformCons(SCIP* scip, SCIP_CONS* cons, SCIP_CONS** transcons)
    SCIP_CONS** SCIPgetConss(SCIP* scip)
    const char* SCIPconsGetName(SCIP_CONS* cons)
    int SCIPgetNConss(SCIP* scip)

    # Primal Solution Methods
    SCIP_SOL** SCIPgetSols(SCIP* scip)
    int SCIPgetNSols(SCIP* scip)
    SCIP_SOL* SCIPgetBestSol(SCIP* scip)
    SCIP_Real SCIPgetSolVal(SCIP* scip, SCIP_SOL* sol, SCIP_VAR* var)
    SCIP_RETCODE SCIPwriteVarName(SCIP* scip, FILE* outfile, SCIP_VAR* var, SCIP_Bool vartype)
    SCIP_Real SCIPgetSolOrigObj(SCIP* scip, SCIP_SOL* sol)
    SCIP_Real SCIPgetSolTransObj(SCIP* scip, SCIP_SOL* sol)

    # Dual Solution Methods
    SCIP_Real SCIPgetDualbound(SCIP* scip)

    # Variable pricer functions
    SCIP_RETCODE SCIPincludePricerBasic(SCIP* scip, SCIP_PRICER** pricerptr, char* name, char* desc,
                                        int priority, SCIP_Bool delay,
                                        SCIP_RETCODE (*scipPricerRedcost)(SCIP*, SCIP_PRICER*, SCIP_Real*, SCIP_Bool*, SCIP_RESULT*),
                                        SCIP_RETCODE (*scipPricerFarkas)(SCIP*, SCIP_PRICER*, SCIP_RESULT*),
                                        SCIP_PRICERDATA* pricerdata)

    SCIP_RETCODE SCIPactivatePricer(SCIP* scip, SCIP_PRICER* pricer)
    SCIP_RETCODE SCIPsetPricerInit(SCIP* scip, SCIP_PRICER* pricer, SCIP_RETCODE (*scipPricerInit)(SCIP*, SCIP_PRICER*))
    SCIP_PRICERDATA* SCIPpricerGetData(SCIP_PRICER* pricer)

    # Separator Methods
    SCIP_RETCODE SCIPincludeSepaBasic(SCIP* scip,
                                      SCIP_SEPA** sepa,
                                      const char* name,
                                      const char* desc,
                                      int priority,
                                      int freq,
                                      SCIP_Real maxbounddist,
                                      SCIP_Bool usessubscip,
                                      SCIP_Bool delay,
                                      SCIP_RETCODE (*sepaexeclp) (SCIP* scip, SCIP_SEPA* sepa, SCIP_RESULT* result),
                                      SCIP_RETCODE (*sepaexecsol) (SCIP* scip, SCIP_SEPA* sepa, SCIP_SOL* sol, SCIP_RESULT* result),
                                      SCIP_SEPADATA* sepadata)

    # Constraint Handler Methods
    SCIP_RETCODE SCIPincludeConshdlrBasic(SCIP* scip,
                                          SCIP_CONSHDLR** conshdlrptr,
                                          const char* name,
                                          const char* desc,
                                          int enfopriority,
                                          int chckpriority,
                                          int eagerfreq,
                                          SCIP_Bool needscons,
                                          SCIP_RETCODE (*scipConshandlerEnfoLP) (SCIP* scip, SCIP_CONSHDLR* conshdlr, SCIP_CONS** conss, int nconss, int nusefulconss, SCIP_Bool solinfeasible, SCIP_RESULT* result),
                                          SCIP_RETCODE (*scipConshandlerEnfoPS) (SCIP* scip, SCIP_CONSHDLR* conshdlr, SCIP_CONS** conss, int nconss, int nusefulconss, SCIP_Bool solinfeasible, SCIP_Bool objinfeasible, SCIP_RESULT* result),
                                          SCIP_RETCODE (*scipConshandlercheck) (SCIP* scip, SCIP_CONSHDLR* conshdlr, SCIP_CONS** conss, int nconss, SCIP_SOL* sol, SCIP_Bool checkintegrality, SCIP_Bool checklprows, SCIP_Bool printreason, SCIP_RESULT* result),
                                          SCIP_RETCODE (*scipConshandlerLock) (SCIP* scip, SCIP_CONSHDLR* conshdlr, SCIP_CONS* cons, int nlockspos, int nlocksneg),
                                          SCIP_CONSHDLRDATA* conshdlrdata)

    # Numerical Methods
    SCIP_Real SCIPinfinity(SCIP* scip)

    # Statistic Methods
    SCIP_RETCODE SCIPprintStatistics(SCIP* scip, FILE* outfile)


    # Parameter Functions
    SCIP_RETCODE SCIPsetBoolParam(SCIP* scip, char* name, SCIP_Bool value)
    SCIP_RETCODE SCIPsetIntParam(SCIP* scip, char* name, int value)
    SCIP_RETCODE SCIPsetLongintParam(SCIP* scip, char* name, SCIP_Longint value)
    SCIP_RETCODE SCIPsetRealParam(SCIP* scip, char* name, SCIP_Real value)
    SCIP_RETCODE SCIPsetCharParam(SCIP* scip, char* name, char value)
    SCIP_RETCODE SCIPsetStringParam(SCIP* scip, char* name, char* value)
    SCIP_RETCODE SCIPreadParams(SCIP* scip, char* file)
    SCIP_RETCODE SCIPreadProb(SCIP* scip, char* file, char* extension)


cdef extern from "scip/scipdefplugins.h":
    SCIP_RETCODE SCIPincludeDefaultPlugins(SCIP* scip)

cdef extern from "scip/cons_linear.h":
    SCIP_RETCODE SCIPcreateConsLinear(SCIP* scip,
                                      SCIP_CONS** cons,
                                      char* name,
                                      int nvars,
                                      SCIP_VAR** vars,
                                      SCIP_Real* vals,
                                      SCIP_Real lhs,
                                      SCIP_Real rhs,
                                      SCIP_Bool initial,
                                      SCIP_Bool separate,
                                      SCIP_Bool enforce,
                                      SCIP_Bool check,
                                      SCIP_Bool propagate,
                                      SCIP_Bool local,
                                      SCIP_Bool modifiable,
                                      SCIP_Bool dynamic,
                                      SCIP_Bool removable,
                                      SCIP_Bool stickingatnode)
    SCIP_RETCODE SCIPaddCoefLinear(SCIP* scip,
                                   SCIP_CONS* cons,
                                   SCIP_VAR* var,
                                   SCIP_Real val)

    SCIP_Real SCIPgetDualsolLinear(SCIP* scip, SCIP_CONS* cons)
    SCIP_Real SCIPgetDualfarkasLinear(SCIP* scip, SCIP_CONS* cons)

cdef extern from "scip/cons_quadratic.h":
    SCIP_RETCODE SCIPcreateConsQuadratic(SCIP* scip,
                                         SCIP_CONS** cons,
                                         const char* name,
                                         int nlinvars,
                                         SCIP_VAR** linvars,
                                         SCIP_Real* lincoefs,
                                         int nquadterms,
                                         SCIP_VAR** quadvars1,
                                         SCIP_VAR** quadvars2,
                                         SCIP_Real* quadcoeffs,
                                         SCIP_Real lhs,
                                         SCIP_Real rhs,
                                         SCIP_Bool initial,
                                         SCIP_Bool separate,
                                         SCIP_Bool enforce,
                                         SCIP_Bool check,
                                         SCIP_Bool propagate,
                                         SCIP_Bool local,
                                         SCIP_Bool modifiable,
                                         SCIP_Bool dynamic,
                                         SCIP_Bool removable)
    SCIP_RETCODE SCIPaddLinearVarQuadratic(SCIP* scip,
                                           SCIP_CONS* cons,
                                           SCIP_VAR* var,
                                           SCIP_Real coef)
    SCIP_RETCODE SCIPaddBilinTermQuadratic(SCIP* scip,
                                           SCIP_CONS* cons,
                                           SCIP_VAR* var1,
                                           SCIP_VAR* var2,
                                           SCIP_Real coef)

cdef extern from "scip/cons_sos1.h":
    SCIP_RETCODE SCIPcreateConsSOS1(SCIP* scip,
                                    SCIP_CONS** cons,
                                    const char* name,
                                    int nvars,
                                    SCIP_VAR** vars,
                                    SCIP_Real* weights,
                                    SCIP_Bool initial,
                                    SCIP_Bool separate,
                                    SCIP_Bool enforce,
                                    SCIP_Bool check,
                                    SCIP_Bool propagate,
                                    SCIP_Bool local,
                                    SCIP_Bool dynamic,
                                    SCIP_Bool removable,
                                    SCIP_Bool stickingatnode)

    SCIP_RETCODE SCIPaddVarSOS1(SCIP* scip,
                                SCIP_CONS* cons,
                                SCIP_VAR* var,
                                SCIP_Real weight)

    SCIP_RETCODE SCIPappendVarSOS1(SCIP* scip,
                                   SCIP_CONS* cons,
                                   SCIP_VAR* var)


cdef extern from "scip/cons_sos2.h":
    SCIP_RETCODE SCIPcreateConsSOS2(SCIP* scip,
                                    SCIP_CONS** cons,
                                    const char* name,
                                    int nvars,
                                    SCIP_VAR** vars,
                                    SCIP_Real* weights,
                                    SCIP_Bool initial,
                                    SCIP_Bool separate,
                                    SCIP_Bool enforce,
                                    SCIP_Bool check,
                                    SCIP_Bool propagate,
                                    SCIP_Bool local,
                                    SCIP_Bool dynamic,
                                    SCIP_Bool removable,
                                    SCIP_Bool stickingatnode)

    SCIP_RETCODE SCIPaddVarSOS2(SCIP* scip,
                                SCIP_CONS* cons,
                                SCIP_VAR* var,
                                SCIP_Real weight)

    SCIP_RETCODE SCIPappendVarSOS2(SCIP* scip,
                                   SCIP_CONS* cons,
                                   SCIP_VAR* var)
