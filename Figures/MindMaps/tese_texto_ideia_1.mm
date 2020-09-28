<map version="freeplane 1.8.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="Fusão de Evidências em Canais de Intensidades para Detecção de Bordas em Imagens PolSAR" FOLDED="false" ID="ID_1506436616" CREATED="1592040618323" MODIFIED="1601297627077" STYLE="oval" TEXT_SHORTENED="true">
<font SIZE="18"/>
<hook NAME="MapStyle" zoom="2.0">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" fit_to_viewport="false"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24.0 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ICON_SIZE="12.0 pt" COLOR="#000000" STYLE="fork">
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important">
<icon BUILTIN="yes"/>
</stylenode>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10.0 pt" SHAPE_VERTICAL_MARGIN="10.0 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="9" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Introdução" POSITION="right" ID="ID_1377942773" CREATED="1592040676295" MODIFIED="1601297648499">
<edge COLOR="#ff0000"/>
<node TEXT="Por quê?" ID="ID_1153865468" CREATED="1592040707244" MODIFIED="1601297686999">
<node TEXT="Relevância" ID="ID_497709681" CREATED="1592040735088" MODIFIED="1601297724019"/>
<node TEXT="Originalidade" ID="ID_1333486899" CREATED="1592040741973" MODIFIED="1601297769053"/>
</node>
<node TEXT="O que?" ID="ID_1265779166" CREATED="1592040721633" MODIFIED="1601297753052"/>
<node TEXT="Como?" ID="ID_1334621999" CREATED="1592040724795" MODIFIED="1601297759638"/>
</node>
<node TEXT="Metodologia" POSITION="right" ID="ID_453302421" CREATED="1592040682314" MODIFIED="1601301135272">
<edge COLOR="#0000ff"/>
<node TEXT=" Formação da imagem - Aspectos teóricos - Formação do Speckle" ID="ID_1004220497" CREATED="1601301227893" MODIFIED="1601301261750"/>
<node TEXT="Modelos" ID="ID_1597456562" CREATED="1592639604614" MODIFIED="1601300971308">
<node TEXT="Univariado" ID="ID_834683364" CREATED="1592040780256" MODIFIED="1601298686070">
<node TEXT="Gamma" ID="ID_1120005622" CREATED="1592040795592" MODIFIED="1592594275364">
<node TEXT="HH" ID="ID_1812083630" CREATED="1592576097380" MODIFIED="1592576099603"/>
<node TEXT="HV" ID="ID_1732097195" CREATED="1592576105799" MODIFIED="1592576111523"/>
<node TEXT="VV" ID="ID_858770354" CREATED="1592576111958" MODIFIED="1592576113825"/>
</node>
<node TEXT="Produto of Intensidades" ID="ID_540876929" CREATED="1592040799348" MODIFIED="1601298703563">
<node TEXT="HH x HV" ID="ID_1146059201" CREATED="1592576115673" MODIFIED="1592576120324"/>
<node TEXT="HH x VV" ID="ID_1660635512" CREATED="1592576120798" MODIFIED="1592576124196"/>
<node TEXT="HV x VV" ID="ID_1437020690" CREATED="1592576124610" MODIFIED="1592576129471"/>
</node>
<node TEXT="Razão de intensidades" ID="ID_46505368" CREATED="1592054298276" MODIFIED="1601298729992">
<node TEXT="HH / HV" ID="ID_270823560" CREATED="1592576132252" MODIFIED="1592576158424"/>
<node TEXT="HH / VV" ID="ID_578759992" CREATED="1592576138368" MODIFIED="1592576155283"/>
<node TEXT="HV / VV" ID="ID_1729266492" CREATED="1592576142978" MODIFIED="1592576151086"/>
</node>
<node TEXT="Span (HH, HV, VV)" ID="ID_411721143" CREATED="1601300827746" MODIFIED="1601300853816"/>
</node>
<node TEXT="Bivariada: Duas Intensidades" ID="ID_1821329703" CREATED="1592040783812" MODIFIED="1601298755805">
<node TEXT="(HH,HV)" ID="ID_1485560637" CREATED="1592576162394" MODIFIED="1592576169521"/>
<node TEXT="(HH,VV)" ID="ID_63713651" CREATED="1592576170018" MODIFIED="1592576177802"/>
<node TEXT="(HV,VV)" ID="ID_1542269137" CREATED="1592576178252" MODIFIED="1592576183334"/>
</node>
<node TEXT="Estimativas dos parâmetros - MLE" ID="ID_186542533" CREATED="1592040759050" MODIFIED="1601298851085" HGAP_QUANTITY="14.74999997764826 pt" VSHIFT_QUANTITY="4.499999865889553 pt"/>
</node>
<node TEXT="Fusão de evidências" ID="ID_1920386486" CREATED="1592041391084" MODIFIED="1601298036175"/>
</node>
<node TEXT="Resultados" POSITION="right" ID="ID_662563328" CREATED="1592040699685" MODIFIED="1601301765707">
<edge COLOR="#00ff00"/>
<node TEXT="Aplicações em imagen simuladas de duas folhas" ID="ID_657986661" CREATED="1592576961975" MODIFIED="1601300196337" TEXT_SHORTENED="true"/>
<node TEXT="Aplicações em imagens Reais" ID="ID_507065939" CREATED="1601299463514" MODIFIED="1601301307178">
<node TEXT="Evidências e fusão para as pdf&apos;s Gamma de intensidades (Resultados do artigo na GRSL)" ID="ID_598209623" CREATED="1601300334963" MODIFIED="1601300506343">
<node TEXT="Região 1 de Flevoland" ID="ID_902733928" CREATED="1601300733162" MODIFIED="1601300768506"/>
<node TEXT="Região 2 de Flevoland" ID="ID_319932517" CREATED="1601300769534" MODIFIED="1601300782235"/>
<node TEXT="Região de San Francisco" ID="ID_1657808015" CREATED="1601300790174" MODIFIED="1601300806878"/>
</node>
<node TEXT="Evidências e fusão usando usando outras PDF&apos;s" ID="ID_341756413" CREATED="1601300385462" MODIFIED="1601301018079" HGAP_QUANTITY="15.499999955296518 pt" VSHIFT_QUANTITY="28.499999150633837 pt">
<node TEXT="Região 1 de Flevoland com 7 PDF&apos;s" ID="ID_797493718" CREATED="1601300595323" MODIFIED="1601300642405"/>
<node TEXT="Regiao 2 de Flevoland com 4 PDF&apos;s" ID="ID_1434693257" CREATED="1601300643396" MODIFIED="1601300679046"/>
<node TEXT="Regiao de San francisco com 7 PDF&apos;s" ID="ID_1169186820" CREATED="1601300644983" MODIFIED="1601301012696" HGAP_QUANTITY="15.499999955296518 pt" VSHIFT_QUANTITY="5.249999843537812 pt"/>
</node>
</node>
</node>
<node TEXT="Conclusões / Discussões" POSITION="right" ID="ID_424149476" CREATED="1592040701641" MODIFIED="1601298970208">
<edge COLOR="#ff00ff"/>
</node>
</node>
</map>
