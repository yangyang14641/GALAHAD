PROGRAM GALAHAD_APS_EXAMPLE
   USE GALAHAD_APS_DOUBLE                        ! double precision version
   IMPLICIT NONE
   INTEGER, PARAMETER :: wp = KIND( 1.0D+0 ) ! set precision
   REAL ( KIND = wp ), PARAMETER :: one = 1.0_wp, two = 2.0_wp, ten = 10.0_wp
   REAL ( KIND = wp ), PARAMETER :: zero = 0.0_wp, eps = 0.0000000001_wp
   INTEGER, PARAMETER :: n = 99                  ! problem dimension
   INTEGER :: i, j, k, nn, pass
   TYPE ( SMT_type ) :: H
   LOGICAL :: new_H = .TRUE.
   REAL ( KIND = wp ), DIMENSION( n ) :: C, X
   REAL ( KIND = wp ) :: f, f1, f2, delta, tol
   TYPE ( APS_data_type ) :: data
   TYPE ( APS_control_type ) :: control
   TYPE ( APS_inform_type ) :: inform

   H%ne = 132                                 ! set up problem

   ALLOCATE( H%row( H%ne ), H%col( H%ne ), H%val( H%ne ), STAT = i )

!  ==============
!  Normal entries
!  ==============

   WRITE( 6, "( /, ' ==== normal exits ====== ', / )" )

! Initialize control parameters

   OPEN( UNIT = 23, STATUS = 'SCRATCH' )
   DO pass = 1, 11
      IF ( pass == 1 .OR. pass == 3 )                                          &
        CALL APS_initialize( data, control, inform )
      control%error = 23 ; control%out = 23 ; control%print_level = 10
      tol = SQRT( EPSILON( one ) )
      delta = one
      IF ( pass == 1 ) THEN
         j = 0 ; k = 0
         DO i = 1, 11
            H%row( j +  1 ) = k + 1 ; H%col( j +  1 ) = k + 1
            H%val( j +  1 ) = two
            H%row( j +  2 ) = k + 2 ; H%col( j +  2 ) = k + 1
            H%val( j +  2 ) = one
            H%row( j +  3 ) = k + 2 ; H%col( j +  3 ) = k + 2
            H%val( j +  3 ) = one
            H%row( j +  4 ) = k + 3 ; H%col( j +  4 ) = k + 3
            H%val( j +  4 ) = zero
            H%row( j +  5 ) = k + 4 ; H%col( j +  5 ) = k + 3
            H%val( j +  5 ) = one
            H%row( j +  6 ) = k + 4 ; H%col( j +  6 ) = k + 4
            H%val( j +  6 ) = zero
            H%row( j +  7 ) = k + 5 ; H%col( j +  7 ) = k + 5
            H%val( j +  7 ) = - one
            H%row( j +  8 ) = k + 5 ; H%col( j +  8 ) = k + 6
            H%val( j +  8 ) = - one
            H%row( j +  9 ) = k + 6 ; H%col( j +  9 ) = k + 6
            H%val( j +  9 ) = - two
            H%row( j + 10 ) = k + 7 ; H%col( j + 10 ) = k + 7
            H%val( j + 10 ) = one
            H%row( j + 11 ) = k + 8 ; H%col( j + 11 ) = k + 8
            H%val( j + 11 ) = eps
            H%row( j + 12 ) = k + 9 ; H%col( j + 12 ) = k + 9
            H%val( j + 12 ) = - ten
            j = j + 12 ; k = k + 9
         END DO
      END IF
      IF ( pass == 2 ) delta = 1000.0_wp
      IF ( pass == 3 ) THEN
         j = 0 ; k = 0
         DO i = 1, 11
            H%row( j +  1 ) = k + 1 ; H%col( j +  1 ) = k + 1
            H%val( j +  1 ) = two
            H%row( j +  2 ) = k + 2 ; H%col( j +  2 ) = k + 1
            H%val( j +  2 ) = one
            H%row( j +  3 ) = k + 2 ; H%col( j +  3 ) = k + 2
            H%val( j +  3 ) = one
            H%row( j +  4 ) = k + 3 ; H%col( j +  4 ) = k + 3
            H%val( j +  4 ) = two
            H%row( j +  5 ) = k + 4 ; H%col( j +  5 ) = k + 3
            H%val( j +  5 ) = one
            H%row( j +  6 ) = k + 4 ; H%col( j +  6 ) = k + 4
            H%val( j +  6 ) = one
            H%row( j +  7 ) = k + 5 ; H%col( j +  7 ) = k + 5
            H%val( j +  7 ) = two
            H%row( j +  8 ) = k + 5 ; H%col( j +  8 ) = k + 6
            H%val( j +  8 ) = one
            H%row( j +  9 ) = k + 6 ; H%col( j +  9 ) = k + 6
            H%val( j +  9 ) = one
            H%row( j + 10 ) = k + 7 ; H%col( j + 10 ) = k + 7
            H%val( j + 10 ) = one
            H%row( j + 11 ) = k + 8 ; H%col( j + 11 ) = k + 8
            H%val( j + 11 ) = one
            H%row( j + 12 ) = k + 9 ; H%col( j + 12 ) = k + 9
            H%val( j + 12 ) = one
            j = j + 12 ; k = k + 9
         END DO
      END IF
      IF ( pass == 4 ) delta = delta / two
      IF ( pass == 5 ) delta = 0.0001_wp
      IF ( pass == 6 ) THEN
         j = 0 ; k = 0
         DO i = 1, 11
            H%row( j +  1 ) = k + 1 ; H%col( j +  1 ) = k + 1
            H%val( j +  1 ) = two
            H%row( j +  2 ) = k + 2 ; H%col( j +  2 ) = k + 1
            H%val( j +  2 ) = one
            H%row( j +  3 ) = k + 2 ; H%col( j +  3 ) = k + 2
            H%val( j +  3 ) = one
            H%row( j +  4 ) = k + 3 ; H%col( j +  4 ) = k + 3
            H%val( j +  4 ) = two
            H%row( j +  5 ) = k + 4 ; H%col( j +  5 ) = k + 3
            H%val( j +  5 ) = one
            H%row( j +  6 ) = k + 4 ; H%col( j +  6 ) = k + 4
            H%val( j +  6 ) = one
            H%row( j +  7 ) = k + 5 ; H%col( j +  7 ) = k + 5
            H%val( j +  7 ) = two
            H%row( j +  8 ) = k + 5 ; H%col( j +  8 ) = k + 6
            H%val( j +  8 ) = one
            H%row( j +  9 ) = k + 6 ; H%col( j +  9 ) = k + 6
            H%val( j +  9 ) = one
            H%row( j + 10 ) = k + 7 ; H%col( j + 10 ) = k + 7
            H%val( j + 10 ) = one
            H%row( j + 11 ) = k + 8 ; H%col( j + 11 ) = k + 8
            H%val( j + 11 ) = one
            H%row( j + 12 ) = k + 9 ; H%col( j + 12 ) = k + 9
            H%val( j + 12 ) = zero
            j = j + 12 ; k = k + 9
         END DO
      END IF
      IF ( pass == 7 ) THEN
         delta = 0.1_wp
         j = 0 ; k = 0
         DO i = 1, 11
            H%row( j +  1 ) = k + 1 ; H%col( j +  1 ) = k + 1
            H%val( j +  1 ) = two
            H%row( j +  2 ) = k + 2 ; H%col( j +  2 ) = k + 1
            H%val( j +  2 ) = one
            H%row( j +  3 ) = k + 2 ; H%col( j +  3 ) = k + 2
            H%val( j +  3 ) = one
            H%row( j +  4 ) = k + 3 ; H%col( j +  4 ) = k + 3
            H%val( j +  4 ) = two
            H%row( j +  5 ) = k + 4 ; H%col( j +  5 ) = k + 3
            H%val( j +  5 ) = one
            H%row( j +  6 ) = k + 4 ; H%col( j +  6 ) = k + 4
            H%val( j +  6 ) = one
            H%row( j +  7 ) = k + 5 ; H%col( j +  7 ) = k + 5
            H%val( j +  7 ) = two
            H%row( j +  8 ) = k + 5 ; H%col( j +  8 ) = k + 6
            H%val( j +  8 ) = one
            H%row( j +  9 ) = k + 6 ; H%col( j +  9 ) = k + 6
            H%val( j +  9 ) = one
            H%row( j + 10 ) = k + 7 ; H%col( j + 10 ) = k + 7
            H%val( j + 10 ) = one
            H%row( j + 11 ) = k + 8 ; H%col( j + 11 ) = k + 8
            H%val( j + 11 ) = one
            H%row( j + 12 ) = k + 9 ; H%col( j + 12 ) = k + 9
            H%val( j + 12 ) = eps
            j = j + 12 ; k = k + 9
         END DO
      END IF
      IF ( pass == 8 ) delta = 100000.0_wp
      IF ( pass == 9 ) delta = 10.0_wp
      IF ( pass == 10 ) delta = 10.0_wp
      IF ( pass == 11 ) delta = 10000.0_wp

      IF ( pass == 2 ) THEN
         k = 0
         DO i = 1, 11
            C( k + 1 ) = one
            C( k + 2 : k + 9 ) = zero
            k = k + 9
         END DO
      ELSE IF ( pass == 10 ) THEN
         C( : n - 1 ) = 0.000000000001_wp ; C( n ) = one
      ELSE
         C = one
      END IF

      IF ( pass == 1 .OR. pass == 3 .OR. pass == 6 .OR. pass == 7 ) THEN
         CALL APS_solve( n, delta, C, H, new_H, f, X, data, control, inform )
      ELSE IF ( pass == 2 .OR. pass == 10 ) THEN
         CALL APS_resolve( n, delta, X, f, data, control, inform, C = C )
      ELSE
         CALL APS_resolve( n, delta, X, f, data, control, inform )
      END IF

      f1 = APS_objective( n, C, X, H )
      f2 = 0.5_wp * ( DOT_PRODUCT( C, X ) - inform%multiplier * delta * delta )
      IF ( ABS( f - f1 ) > tol * MAX( one, ABS( f ) ) .OR.                     &
           ABS( f - f2 ) > tol * MAX( one, ABS( f ) ) )                        &
         WRITE( 6, "( ' new  real f ', 3ES22.14 )" ) f, f1, f2

      IF ( pass == 1 .OR. pass == 3 .OR. pass == 6 .OR. pass == 7 ) THEN
         WRITE( 6, "( ' pass ', I3, ' APS_solve   exit status = ', I6 )" )    &
             pass, inform%status
      ELSE
         WRITE( 6, "( ' pass ', I3, ' APS_resolve exit status = ', I6 )" )    &
             pass, inform%status
      END IF
   END DO

!  =============
!  Error entries
!  =============

   WRITE( 6, "( /, ' ==== error exits ====== ', / )" )

! Initialize control parameters

   CALL APS_initialize( data, control, inform )
   DO pass = 1, 4
      delta = one
      control%error = 23 ; control%out = 23 ; control%print_level = 10
      inform%status = 1
      nn = n
      IF ( pass == 1 ) nn = 0
      IF ( pass == 2 ) delta = - one
      IF ( pass == 3 ) CYCLE
      IF ( pass == 4 ) H%ne = - 1

      C = one
      CALL APS_solve( nn, delta, C, H, new_H, f, X, data, control, inform )

      WRITE( 6, "( ' pass ', I3, ' APS_solve   exit status = ', I6 )" )       &
             pass, inform%status
   END DO
   CLOSE( unit = 23 )

   CALL APS_terminate( data, control, inform ) !  delete internal workspace
   STOP

CONTAINS

   FUNCTION APS_objective( n, C, X, H )
   REAL ( KIND = wp ) :: APS_objective
   INTEGER :: n
   TYPE ( ZD11_type ) :: H
   REAL ( KIND = wp ), DIMENSION( n ) :: C, X, HX
   INTEGER :: i, j, k
   HX = 0.0_wp
   DO k = 1, H%ne
      i = H%row( k ) ; j = H%col( k )
      HX( i ) = HX( i ) + H%val( k ) * X( j )
      IF ( i /= j ) HX( j ) = HX( j ) + H%val( k ) * X( i )
   END DO
   APS_objective = DOT_PRODUCT( C, X ) + 0.5_wp * DOT_PRODUCT( X, HX )
   RETURN
   END FUNCTION APS_objective

END PROGRAM GALAHAD_APS_EXAMPLE