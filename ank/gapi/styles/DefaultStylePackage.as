// Action script...

// [Initial MovieClip Action of sprite 20499]
#initclip 20
if (!ank.gapi.styles.DefaultStylePackage)
{
    if (!ank)
    {
        _global.ank = new Object();
    } // end if
    if (!ank.gapi)
    {
        _global.ank.gapi = new Object();
    } // end if
    if (!ank.gapi.styles)
    {
        _global.ank.gapi.styles = new Object();
    } // end if
    var _loc1 = (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).prototype;
    ASSetPropFlags(_loc1, null, 1);
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).Label = {labelfont: "_sans", labelembedfonts: false, labelalign: "center", labelsize: 10, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).LabelBlack = {labelfont: "_sans", labelembedfonts: false, labelalign: "center", labelsize: 10, labelcolor: 0, labelbold: true, labelitalic: false};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).TextInput = {labelfont: "_sans", labelembedfonts: false, labelalign: "left", labelsize: 10, labelcolor: 0, labelbold: true, labelitalic: false};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).Button = {labelupstyle: "Label", labeloverstyle: "LabelBlack", labeldownstyle: "Label", bgcolor: 16736512, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 13421772, highlightdowncolor: 11509893};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ScrollBar = {sbarrowbgcolor: 12499352, sbarrowcolor: 5327420, sbthumbcolor: 5327420, sbtrackcolor: -1};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).TextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, bold: false, italic: false, scrollbarstyle: "ScrollBar"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ChatArea = {font: "_sans", embedfonts: false, align: "left", size: 10, bold: false, italic: false, scrollbarstyle: "ScrollBar"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).CellRenderer = {defaultstyle: "LabelBlack", leftstyle: "LabelBlack", rightstyle: "LabelBlack"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).List = {cellrendererstyle: "CellRenderer", scrollbarstyle: "ScrollBar", cellbgcolor: [16772812, 15654331], cellselectedcolor: 16750865, cellovercolor: 13421704};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ContainerGrid = {containerbackground: "DefaultBackground", containerhighlight: "DefaultHighlight", scrollbarstyle: "ScrollBar", labelstyle: "Label"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).LookSelectorGrid = {containerbackground: "LookSelectorBackground", containerhighlight: "LookSelectorHighlight", scrollbarstyle: "ScrollBar", labelstyle: "Label"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).Container = {labelstyle: "Label"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).Window = {titlestyle: "Label", cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ProgressBar = {bgcolor: 5327420, upcolor: 16737792};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ToolTip = {font: "_sans", embedfonts: false, size: 10, color: 16777215, bold: false, italic: false, bgcolor: 0, bgalpha: 70};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).PopupMenu = {bordercolor: 16777215, backgroundcolor: 5327420, foregroundcolor: 14012330, itembgcolor: 5327420, itemovercolor: 16737792, itemstaticbgcolor: 5327420, labelstaticstyle: "Label", labelenabledstyle: "Label", labeldisabledstyle: "Label"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).VolumeSlider = {oncolor: 16777215, offcolor: 13421772};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).CircleChrono = {bgcolor: 16777215};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).StylizedRectangle = {cornerradius: {tl: 0, tr: 13, br: 0, bl: 0}, bgcolor: 16777215};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).MapNavigator = {buttonstyle: "Button", bordercolor: 12104079, gridcolor: 12104079, bgcolor: 15066553};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).DataGrid = {labelstyle: "Label", liststyle: "List", titlebgcolor: "0x22FF00"};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ConsoleLogger = {font: "_sans", embedfonts: false, size: 12};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).Fps = {labelstyle: "Label", backalpha: 50, backcolor: 16711680};
    (_global.ank.gapi.styles.DefaultStylePackage = function ()
    {
        super();
    }).ComboBox = {labelstyle: "LabelBlack", buttonstyle: "Button", liststyle: "List", listbordercolor: 5128232, bgcolor: 16777215, bordercolor: 5128232, highlightcolor: 13421772};
} // end if
#endinitclip
