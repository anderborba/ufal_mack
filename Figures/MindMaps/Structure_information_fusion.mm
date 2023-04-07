<map version="freeplane 1.7.0">
<!--To view this file, download free mind mapping software Freeplane from http://freeplane.sourceforge.net -->
<node TEXT="Fusion of Edge Location Evidence from Partial Information in PolSAR Imagery" FOLDED="false" ID="ID_1506436616" CREATED="1592040618323" MODIFIED="1592595052813" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle" zoom="0.75">
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
<hook NAME="AutomaticEdgeColor" COUNTER="7" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Introduction" POSITION="right" ID="ID_1377942773" CREATED="1592040676295" MODIFIED="1592594638338">
<edge COLOR="#ff0000"/>
<node TEXT="Why?" ID="ID_1153865468" CREATED="1592040707244" MODIFIED="1592040716166">
<node TEXT="Relevance" ID="ID_497709681" CREATED="1592040735088" MODIFIED="1592040740030"/>
<node TEXT="Originality" ID="ID_1333486899" CREATED="1592040741973" MODIFIED="1592040747042"/>
</node>
<node TEXT="What?" ID="ID_1265779166" CREATED="1592040721633" MODIFIED="1592040724268"/>
<node TEXT="How?" ID="ID_1334621999" CREATED="1592040724795" MODIFIED="1592040732211"/>
</node>
<node TEXT="Methodology" POSITION="right" ID="ID_453302421" CREATED="1592040682314" MODIFIED="1592041804218">
<edge COLOR="#0000ff"/>
<node TEXT="Sharp Edge Model" ID="ID_1846525982" CREATED="1592041255665" MODIFIED="1592594644491"/>
<node TEXT="Marginal Models" ID="ID_709933409" CREATED="1592040756756" MODIFIED="1592594648022">
<node TEXT="Univariate" ID="ID_834683364" CREATED="1592040780256" MODIFIED="1592040783610">
<node TEXT="Gamma" ID="ID_1120005622" CREATED="1592040795592" MODIFIED="1592595019100">
<node TEXT="HH" ID="ID_1812083630" CREATED="1592576097380" MODIFIED="1592576099603"/>
<node TEXT="HV" ID="ID_1732097195" CREATED="1592576105799" MODIFIED="1592576111523"/>
<node TEXT="VV" ID="ID_858770354" CREATED="1592576111958" MODIFIED="1592576113825"/>
</node>
<node TEXT="Product of Intensities" ID="ID_540876929" CREATED="1592040799348" MODIFIED="1592040809208">
<node TEXT="HH x HV" ID="ID_1146059201" CREATED="1592576115673" MODIFIED="1592576120324"/>
<node TEXT="HH x VV" ID="ID_1660635512" CREATED="1592576120798" MODIFIED="1592576124196"/>
<node TEXT="HV x VV" ID="ID_1437020690" CREATED="1592576124610" MODIFIED="1592576129471"/>
</node>
<node TEXT="Intensity Ratio" ID="ID_46505368" CREATED="1592054298276" MODIFIED="1592054319600">
<node TEXT="HH / HV" ID="ID_270823560" CREATED="1592576132252" MODIFIED="1592576158424"/>
<node TEXT="HH / VV" ID="ID_578759992" CREATED="1592576138368" MODIFIED="1592576155283"/>
<node TEXT="HV / VV" ID="ID_1729266492" CREATED="1592576142978" MODIFIED="1592576151086"/>
</node>
</node>
<node TEXT="Bivariate: Two Intensities" ID="ID_1821329703" CREATED="1592040783812" MODIFIED="1592040794267">
<node TEXT="(HH,HV)" ID="ID_1485560637" CREATED="1592576162394" MODIFIED="1592576169521"/>
<node TEXT="(HH,VV)" ID="ID_63713651" CREATED="1592576170018" MODIFIED="1592576177802"/>
<node TEXT="(HV,VV)" ID="ID_1542269137" CREATED="1592576178252" MODIFIED="1592576183334"/>
</node>
<node TEXT="Trivariate: Three Intensities" ID="ID_585544023" CREATED="1592575565856" MODIFIED="1592575577015"/>
<node TEXT="Parameter Estimation" ID="ID_186542533" CREATED="1592040759050" MODIFIED="1592041380025" HGAP_QUANTITY="14.74999997764826 pt" VSHIFT_QUANTITY="4.499999865889553 pt"/>
</node>
<node TEXT="Edge Point Estimation" ID="ID_1920386486" CREATED="1592041391084" MODIFIED="1592594660526"/>
<node TEXT="Fusion" ID="ID_1312805327" CREATED="1592040762876" MODIFIED="1592594976443">
<node TEXT="Mean" ID="ID_826172628" CREATED="1592041414305" MODIFIED="1592041416557"/>
<node TEXT="PCA" ID="ID_51604469" CREATED="1592041417141" MODIFIED="1592041419953"/>
<node TEXT="ROC" ID="ID_1733764640" CREATED="1592041420144" MODIFIED="1592041422161"/>
<node TEXT="DWT" ID="ID_278768542" CREATED="1592041422315" MODIFIED="1592594976442"/>
<node TEXT="SWT" ID="ID_141441834" CREATED="1592041429943" MODIFIED="1592041433466"/>
<node TEXT="SVD" ID="ID_505702837" CREATED="1592041433925" MODIFIED="1592041436547"/>
</node>
</node>
<node TEXT="Results" POSITION="right" ID="ID_662563328" CREATED="1592040699685" MODIFIED="1592040701487">
<edge COLOR="#00ff00"/>
<node TEXT="Accuracy and Precision in Edge Detection" ID="ID_657986661" CREATED="1592576961975" MODIFIED="1592594664483"/>
<node TEXT="Comparison of Fusion Techniques with Simulated Data" ID="ID_1297858638" CREATED="1592041784436" MODIFIED="1592041839552" HGAP_QUANTITY="14.749999977648258 pt" VSHIFT_QUANTITY="1.4999999552965178 pt"/>
<node TEXT="Application to Actual Data" ID="ID_1380502300" CREATED="1592041454412" MODIFIED="1592041852523"/>
</node>
<node TEXT="Discussion" POSITION="right" ID="ID_424149476" CREATED="1592040701641" MODIFIED="1592040705075">
<edge COLOR="#ff00ff"/>
</node>
</node>
</map>
