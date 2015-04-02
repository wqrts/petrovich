DECLARE
a varchar2( 100 ) := '����';
b varchar2( 100 ) := '������';
c varchar2( 100 ) := '��������';
d varchar2( 100 ) := 'instrumental';
e varchar2( 100 ) := 'male';
FUNCTION petrovich( pv_firstname IN OUT VARCHAR2, pv_lastname IN OUT VARCHAR2, 
                pv_middlename IN OUT VARCHAR2, p_gcase VARCHAR2, p_gender VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
/*
 * p_gcase IN nominative   genitive    dative    accusative  instrumental prepositional
 * �����      ������������ ����������� ��������� ����������� ������������ ����������
 * p_gender OPTIONAL IN male    female
   ���                  ������� �������
 */
  v_gender VARCHAR2( 20 );
  c_rules XMLTYPE := 
XMLTYPE('<?xml version="1.0"?>
<petrovich>
    <lastname>
        <exceptions>
            <exception gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>�����</test>
                    <test>�����</test>
                    <test>�����</test>
                    <test>������</test>
                    <test>�����</test>
                    <test>�������</test>
                    <test>������</test>
                    <test>���</test>
                    <test>�����</test>
                    <test>���</test>
                    <test>�������</test>
                    <test>�����</test>
                    <test>���</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
                <tags><first_word /></tags>
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>����</test>
                    <test>����</test>
                    <test>����</test>
                    <test>�����</test>
                    <test>�������</test>
                    <test>������</test>
                    <test>������</test>
                    <test>�����</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>������</test>
                    <test>������</test>
                    <test>����</test>
                    <test>������</test>
                    <test>�������</test>
                    <test>����������</test>
                    <test>�������</test>
                    <test>����</test>
                    <test>����</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>���</test>
                    <test>���</test>
                    <test>���</test>
                    <test>���</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </exception>
        </exceptions>
        <suffixes>
            <suffix gender="female">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>�����</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>���</test>
                    <test>���</test>
                </tests>
                <mods genitive="-��" dative="-��" accusative="-��" instrumental="-��" prepositional="-��" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--��" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>����</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--��" prepositional="--��" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-��" dative="-��" accusative="-�" instrumental="-��" prepositional="-��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>����</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>���</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>���</test>
                    <test>���</test>
                </tests>
                <mods genitive="-��" dative="-��" accusative="-�" instrumental="-��" prepositional="-��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>����</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--���" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>����</test>
                    <test>����</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--���" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>���</test>
                    <test>���</test>
                </tests>
                <mods genitive="-��" dative="-��" accusative="-��" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-��" dative="-��" accusative="-��" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>���</test>
                    <test>���</test>
                    <test>���</test>
                    <test>���</test>
                </tests>
                <mods genitive="--���" dative="--���" accusative="--���" instrumental="-�" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>���</test>
                    <test>��</test>
                </tests>
                <mods genitive="--���" dative="--���" accusative="--���" instrumental="-�" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--���" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--���" prepositional="--��" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
        </suffixes>
    </lastname>
    <firstname>
        <exceptions>
            <exception gender="androgynous">
                <tests>
                    <test>���</test>
                </tests>
                <mods genitive="--���" dative="--���" accusative="--���" instrumental="--����" prepositional="--���" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>���</test>
                </tests>
                <mods genitive="---����" dative="---����" accusative="---����" instrumental="---�����" prepositional="---����" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>�����</test>
                </tests>
                <mods genitive="--��" dative="--��" accusative="--��" instrumental="--���" prepositional="--��" />
            </exception>
            <exception gender="male">
                <tests>
                    <test>����</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="female">
                <tests>
                    <test>������</test>
                    <test>������</test>
                    <test>������</test>
                    <test>��������</test>
                    <test>�������</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
        </exceptions>
        <suffixes>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="" instrumental="�" prepositional="-�" />
            </suffix>
            <suffix gender="male">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                    <test>�</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
        </suffixes>
    </firstname>
    <middlename>
        <exceptions>
        </exceptions>
        <suffixes>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="�" dative="�" accusative="�" instrumental="��" prepositional="�" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>��</test>
                </tests>
                <mods genitive="-�" dative="-�" accusative="-�" instrumental="-��" prepositional="-�" />
            </suffix>
        </suffixes>
    </middlename>
</petrovich>
');
FUNCTION apply( p_name VARCHAR2, p_gcase VARCHAR2, p_gender VARCHAR2, p_name_order VARCHAR2, p_tag VARCHAR2 ) RETURN VARCHAR2 IS
  v_name VARCHAR2( 100 );
BEGIN
  v_name := p_name;
  
  BEGIN  
    SELECT p_name || exception_ INTO v_name FROM
    (
      SELECT EXTRACTVALUE( COLUMN_VALUE, '/exception/mods/@' || LOWER( p_gcase ) ) exception_
      FROM TABLE( XMLSEQUENCE( c_rules.EXTRACT('/petrovich/' || p_name_order || '/exceptions/exception' ) ) ) exceptions_
      WHERE EXTRACTVALUE( COLUMN_VALUE, '/exception/@gender' ) IN( LOWER( p_gender ), 'androgynous' )
      AND EXISTS 
      (
        SELECT NULL FROM TABLE( XMLSEQUENCE( exceptions_.COLUMN_VALUE.EXTRACT( '/exception/tests/test' ) ) ) test_
        WHERE LOWER( p_name ) LIKE '%' || EXTRACTVALUE( test_.COLUMN_VALUE, '/test' ) 
      )
      AND 
      ( 
        exceptions_.COLUMN_VALUE.EXISTSNODE( '/exception/tags' ) = 0 OR
        ( p_tag IS NOT NULL AND exceptions_.COLUMN_VALUE.EXISTSNODE( '/exception/tags/' || p_tag ) = 1 ) 
      )
      AND ROWNUM = 1
    );
  EXCEPTION WHEN NO_DATA_FOUND THEN
    BEGIN
      SELECT p_name || suffix_ INTO v_name FROM
      (
        SELECT EXTRACTVALUE( COLUMN_VALUE, '/suffix/mods/@' || LOWER( p_gcase ) ) suffix_
        FROM TABLE( XMLSEQUENCE( c_rules.EXTRACT('/petrovich/' || p_name_order || '/suffixes/suffix' ) ) ) suffixes_
        WHERE EXTRACTVALUE( COLUMN_VALUE, '/suffix/@gender' ) IN( LOWER( p_gender ), 'androgynous' )
        AND EXISTS 
        ( 
          SELECT NULL FROM TABLE( XMLSEQUENCE( suffixes_.COLUMN_VALUE.EXTRACT( '/suffix/tests/test' ) ) ) test_
          WHERE LOWER( p_name ) LIKE '%' || EXTRACTVALUE( test_.COLUMN_VALUE, '/test' ) 
        )
        AND 
        ( 
          suffixes_.COLUMN_VALUE.EXISTSNODE( '/suffix/tags' ) = 0 OR
          ( p_tag IS NOT NULL AND suffixes_.COLUMN_VALUE.EXISTSNODE( '/suffix/tags/' || p_tag ) = 1 )
        )
        AND ROWNUM = 1
      );
    EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
    END;
  END;

WHILE( INSTR( v_name, '-' ) > 0 ) LOOP
  v_name := REGEXP_REPLACE( v_name, '[[:alpha:]]-', '' );
END LOOP;

RETURN v_name;

END apply;

FUNCTION inflect( p_name VARCHAR2, p_gcase VARCHAR2, p_gender VARCHAR2, p_name_order VARCHAR2 ) RETURN VARCHAR2 IS
  v_name VARCHAR2( 100 );
  v_dash_pos NUMBER;
  v_second_dash_pos NUMBER;
BEGIN
  v_dash_pos := INSTR( p_name, '-' );
  v_name := LTRIM( p_name, '-' );
  v_second_dash_pos := INSTR( v_name, '-' );
  
  IF( v_dash_pos = 0 ) THEN
    RETURN apply( p_name, p_gcase, p_gender, p_name_order, 'first_word' );
  ELSIF( v_dash_pos = 1 AND v_second_dash_pos = 0 ) THEN
    RETURN apply( v_name, p_gcase, p_gender, p_name_order, NULL );
  ELSE
    RETURN apply( SUBSTR( v_name, 1, v_second_dash_pos - 1 ), p_gcase, p_gender, p_name_order, CASE WHEN v_dash_pos = 1 THEN NULL ELSE 'first_word' END )
            || '-' || inflect( SUBSTR( v_name, v_second_dash_pos ), p_gcase, p_gender, p_name_order );
  END IF;

END inflect;

BEGIN

  v_gender :=
    CASE
      WHEN( LOWER( p_gender ) IN( 'male', 'female' ) ) THEN LOWER( p_gender ) 
      WHEN( LOWER( SUBSTR( pv_middlename, -2 ) ) = '��' OR LOWER( SUBSTR( pv_middlename, -4 ) ) = '����' ) THEN 'male'
      WHEN( LOWER( SUBSTR( pv_middlename, -2 ) ) = '��' OR LOWER( SUBSTR( pv_middlename, -4 ) ) = '����' ) THEN 'female'
      ELSE 'androgynous'
    END;

  IF( p_gcase IS NOT NULL AND LOWER( p_gcase ) != 'nominative' ) THEN
    IF( pv_firstname IS NOT NULL ) THEN
      pv_firstname := inflect( pv_firstname, p_gcase, v_gender, 'firstname' );
    END IF;
    IF( pv_lastname IS NOT NULL ) THEN
      pv_lastname := inflect( pv_lastname, p_gcase, v_gender, 'lastname' );
    END IF;
    IF( pv_middlename IS NOT NULL ) THEN
      pv_middlename := inflect( pv_middlename, p_gcase, v_gender, 'middlename' );
    END IF;
  END IF;
  
  RETURN TRIM( TRIM( pv_lastname || ' ' || pv_firstname ) || ' ' || pv_middlename );
END petrovich;

BEGIN
  DBMS_OUTPUT.PUT_LINE( petrovich( a, b, c, d, e ) );
END;