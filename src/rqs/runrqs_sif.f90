! THIS VERSION: GALAHAD 2.3 - 05/01/2009 AT 16:30 GMT.

!-*-*-*-*-*-*-  G A L A H A D   R U N R Q S _ S I F  *-*-*-*-*-*-*-*-

!  Nick Gould, Dominique Orban and Philippe Toint, for GALAHAD productions
!  Copyright reserved
!  November 24th 2008

   PROGRAM RUNRQS_SIF
   USE GALAHAD_USERQS_double

!  Main program for the SIF interface to RQS, a solver for the regularised
!  quadratic mninimization subproblem

!  Problem insif characteristics

   INTEGER, PARAMETER :: errout = 6
   INTEGER, PARAMETER :: insif = 55
   CHARACTER ( LEN = 16 ) :: prbdat = 'OUTSDIF.d'
   INTEGER :: iostat

!  Open the data input file

   OPEN( insif, FILE = prbdat, FORM = 'FORMATTED', STATUS = 'OLD',             &
         IOSTAT = iostat )
   IF ( iostat > 0 ) THEN
     WRITE( errout,                                                            &
       "( ' ERROR: could not open file OUTSDIF.d on unit ', I2 )" ) insif
     STOP
   END IF
   REWIND insif

!  Call the SIF interface

   CALL USE_RQS( insif )

!  Close the data input file

   CLOSE( insif )
   STOP

!  End of RUNRQS_SIF

   END PROGRAM RUNRQS_SIF
