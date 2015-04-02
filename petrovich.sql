DECLARE
a varchar2( 100 ) := 'Иван';
b varchar2( 100 ) := 'Иванов';
c varchar2( 100 ) := 'Иванович';
d varchar2( 100 ) := 'instrumental';
e varchar2( 100 ) := 'male';

FUNCTION petrovich( pv_firstname IN OUT VARCHAR2, pv_lastname IN OUT VARCHAR2, 
                pv_middlename IN OUT VARCHAR2, p_gcase VARCHAR2, p_gender VARCHAR2 DEFAULT NULL) RETURN VARCHAR2 IS
/*
 * p_gcase IN nominative   genitive    dative    accusative  instrumental prepositional
 * падеж      именительный родительный дательный винительный творительный предложный
 * p_gender OPTIONAL IN male    female
   пол                  мужской женский
 */
  v_gender VARCHAR2( 20 );
  c_rules XMLTYPE := 
XMLTYPE('<?xml version="1.0"?>
<petrovich>
    <lastname>
        <exceptions>
            <exception gender="androgynous">
                <tests>
                    <test>бонч</test>
                    <test>абдул</test>
                    <test>белиц</test>
                    <test>гасан</test>
                    <test>дюссар</test>
                    <test>дюмон</test>
                    <test>книппер</test>
                    <test>корвин</test>
                    <test>ван</test>
                    <test>шолом</test>
                    <test>тер</test>
                    <test>призван</test>
                    <test>мелик</test>
                    <test>вар</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
                <tags><first_word /></tags>
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>дюма</test>
                    <test>тома</test>
                    <test>дега</test>
                    <test>люка</test>
                    <test>ферма</test>
                    <test>гамарра</test>
                    <test>петипа</test>
                    <test>шандра</test>
                    <test>скаля</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>гусь</test>
                    <test>ремень</test>
                    <test>камень</test>
                    <test>онук</test>
                    <test>богода</test>
                    <test>нечипас</test>
                    <test>долгопалец</test>
                    <test>маненок</test>
                    <test>рева</test>
                    <test>кива</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>вий</test>
                    <test>сой</test>
                    <test>цой</test>
                    <test>хой</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </exception>
        </exceptions>
        <suffixes>
            <suffix gender="female">
                <tests>
                    <test>б</test>
                    <test>в</test>
                    <test>г</test>
                    <test>д</test>
                    <test>ж</test>
                    <test>з</test>
                    <test>й</test>
                    <test>к</test>
                    <test>л</test>
                    <test>м</test>
                    <test>н</test>
                    <test>п</test>
                    <test>р</test>
                    <test>с</test>
                    <test>т</test>
                    <test>ф</test>
                    <test>х</test>
                    <test>ц</test>
                    <test>ч</test>
                    <test>ш</test>
                    <test>щ</test>
                    <test>ъ</test>
                    <test>ь</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>гава</test>
                    <test>орота</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>ска</test>
                    <test>цка</test>
                </tests>
                <mods genitive="-ой" dative="-ой" accusative="-ую" instrumental="-ой" prepositional="-ой" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>ая</test>
                </tests>
                <mods genitive="--ой" dative="--ой" accusative="--ую" instrumental="--ой" prepositional="--ой" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ская</test>
                </tests>
                <mods genitive="--ой" dative="--ой" accusative="--ую" instrumental="--ой" prepositional="--ой" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>на</test>
                </tests>
                <mods genitive="-ой" dative="-ой" accusative="-у" instrumental="-ой" prepositional="-ой" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>иной</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>уй</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ца</test>
                </tests>
                <mods genitive="-ы" dative="-е" accusative="-у" instrumental="-ей" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>рих</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ом" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ия</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>иа</test>
                    <test>аа</test>
                    <test>оа</test>
                    <test>уа</test>
                    <test>ыа</test>
                    <test>еа</test>
                    <test>юа</test>
                    <test>эа</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>их</test>
                    <test>ых</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>о</test>
                    <test>е</test>
                    <test>э</test>
                    <test>и</test>
                    <test>ы</test>
                    <test>у</test>
                    <test>ю</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ова</test>
                    <test>ева</test>
                </tests>
                <mods genitive="-ой" dative="-ой" accusative="-у" instrumental="-ой" prepositional="-ой" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>га</test>
                    <test>ка</test>
                    <test>ха</test>
                    <test>ча</test>
                    <test>ща</test>
                    <test>жа</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-у" instrumental="-ой" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ца</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-у" instrumental="-ей" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>а</test>
                </tests>
                <mods genitive="-ы" dative="-е" accusative="-у" instrumental="-ой" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ь</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ия</test>
                </tests>
                <mods genitive="-и" dative="-и" accusative="-ю" instrumental="-ей" prepositional="-и" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>я</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-ю" instrumental="-ей" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ей</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ян</test>
                    <test>ан</test>
                    <test>йн</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ом" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ынец</test>
                    <test>обец</test>
                </tests>
                <mods genitive="--ца" dative="--цу" accusative="--ца" instrumental="--цем" prepositional="--це" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>онец</test>
                    <test>овец</test>
                </tests>
                <mods genitive="--ца" dative="--цу" accusative="--ца" instrumental="--цом" prepositional="--це" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ай</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>гой</test>
                    <test>кой</test>
                </tests>
                <mods genitive="-го" dative="-му" accusative="-го" instrumental="-им" prepositional="-м" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ой</test>
                </tests>
                <mods genitive="-го" dative="-му" accusative="-го" instrumental="-ым" prepositional="-м" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ах</test>
                    <test>ив</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ом" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ший</test>
                    <test>щий</test>
                    <test>жий</test>
                    <test>ний</test>
                </tests>
                <mods genitive="--его" dative="--ему" accusative="--его" instrumental="-м" prepositional="--ем" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>кий</test>
                    <test>ый</test>
                </tests>
                <mods genitive="--ого" dative="--ому" accusative="--ого" instrumental="-м" prepositional="--ом" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ий</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-и" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ок</test>
                </tests>
                <mods genitive="--ка" dative="--ку" accusative="--ка" instrumental="--ком" prepositional="--ке" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ец</test>
                </tests>
                <mods genitive="--ца" dative="--цу" accusative="--ца" instrumental="--цом" prepositional="--це" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ц</test>
                    <test>ч</test>
                    <test>ш</test>
                    <test>щ</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ем" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>в</test>
                    <test>н</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ым" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>б</test>
                    <test>г</test>
                    <test>д</test>
                    <test>ж</test>
                    <test>з</test>
                    <test>к</test>
                    <test>л</test>
                    <test>м</test>
                    <test>п</test>
                    <test>р</test>
                    <test>с</test>
                    <test>т</test>
                    <test>ф</test>
                    <test>х</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ом" prepositional="е" />
            </suffix>
        </suffixes>
    </lastname>
    <firstname>
        <exceptions>
            <exception gender="androgynous">
                <tests>
                    <test>лев</test>
                </tests>
                <mods genitive="--ьва" dative="--ьву" accusative="--ьва" instrumental="--ьвом" prepositional="--ьве" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>пётр</test>
                </tests>
                <mods genitive="---етра" dative="---етру" accusative="---етра" instrumental="---етром" prepositional="---етре" />
            </exception>
            <exception gender="androgynous">
                <tests>
                    <test>павел</test>
                </tests>
                <mods genitive="--ла" dative="--лу" accusative="--ла" instrumental="--лом" prepositional="--ле" />
            </exception>
            <exception gender="male">
                <tests>
                    <test>шота</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
            <exception gender="female">
                <tests>
                    <test>рашель</test>
                    <test>нинель</test>
                    <test>николь</test>
                    <test>габриэль</test>
                    <test>даниэль</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </exception>
        </exceptions>
        <suffixes>
            <suffix gender="androgynous">
                <tests>
                    <test>е</test>
                    <test>ё</test>
                    <test>и</test>
                    <test>о</test>
                    <test>у</test>
                    <test>ы</test>
                    <test>э</test>
                    <test>ю</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>б</test>
                    <test>в</test>
                    <test>г</test>
                    <test>д</test>
                    <test>ж</test>
                    <test>з</test>
                    <test>й</test>
                    <test>к</test>
                    <test>л</test>
                    <test>м</test>
                    <test>н</test>
                    <test>п</test>
                    <test>р</test>
                    <test>с</test>
                    <test>т</test>
                    <test>ф</test>
                    <test>х</test>
                    <test>ц</test>
                    <test>ч</test>
                    <test>ш</test>
                    <test>щ</test>
                    <test>ъ</test>
                </tests>
                <mods genitive="" dative="" accusative="" instrumental="" prepositional="" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>ь</test>
                </tests>
                <mods genitive="-и" dative="-и" accusative="" instrumental="ю" prepositional="-и" />
            </suffix>
            <suffix gender="male">
                <tests>
                    <test>ь</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>га</test>
                    <test>ка</test>
                    <test>ха</test>
                    <test>ча</test>
                    <test>ща</test>
                    <test>жа</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-у" instrumental="-ой" prepositional="-е" />
            </suffix>
            <suffix gender="female">
                <tests>
                    <test>ша</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-у" instrumental="-ей" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>а</test>
                </tests>
                <mods genitive="-ы" dative="-е" accusative="-у" instrumental="-ой" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ия</test>
                </tests>
                <mods genitive="-и" dative="-и" accusative="-ю" instrumental="-ей" prepositional="-и" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>я</test>
                </tests>
                <mods genitive="-и" dative="-е" accusative="-ю" instrumental="-ей" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ей</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>ий</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-и" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>й</test>
                </tests>
                <mods genitive="-я" dative="-ю" accusative="-я" instrumental="-ем" prepositional="-е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>б</test>
                    <test>в</test>
                    <test>г</test>
                    <test>д</test>
                    <test>ж</test>
                    <test>з</test>
                    <test>к</test>
                    <test>л</test>
                    <test>м</test>
                    <test>н</test>
                    <test>п</test>
                    <test>р</test>
                    <test>с</test>
                    <test>т</test>
                    <test>ф</test>
                    <test>х</test>
                    <test>ц</test>
                    <test>ч</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ом" prepositional="е" />
            </suffix>
        </suffixes>
    </firstname>
    <middlename>
        <exceptions>
        </exceptions>
        <suffixes>
            <suffix gender="androgynous">
                <tests>
                    <test>ич</test>
                </tests>
                <mods genitive="а" dative="у" accusative="а" instrumental="ем" prepositional="е" />
            </suffix>
            <suffix gender="androgynous">
                <tests>
                    <test>на</test>
                </tests>
                <mods genitive="-ы" dative="-е" accusative="-у" instrumental="-ой" prepositional="-е" />
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
      WHEN( LOWER( SUBSTR( pv_middlename, -2 ) ) = 'ич' OR LOWER( SUBSTR( pv_middlename, -4 ) ) = 'оглы' ) THEN 'male'
      WHEN( LOWER( SUBSTR( pv_middlename, -2 ) ) = 'на' OR LOWER( SUBSTR( pv_middlename, -4 ) ) = 'кызы' ) THEN 'female'
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
