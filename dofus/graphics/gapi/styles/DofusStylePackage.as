// Action script...

// [Initial MovieClip Action of sprite 20824]
#initclip 89
if (!dofus.graphics.gapi.styles.DofusStylePackage)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.styles)
    {
        _global.dofus.graphics.gapi.styles = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).prototype;
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ScrollBar = {sbarrowbgcolor: 10447155, sbarrowcolor: 16777215, sbthumbcolor: 4139540, sbtrackcolor: 10447155};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ItemSetToolTip = {font: "_sans", embedfonts: false, size: 10, color: 16692022, bold: false, italic: false, bgcolor: 0, bgalpha: 70};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).EtherealToolTip = {font: "_sans", embedfonts: false, size: 10, color: 9091054, bold: false, italic: false, bgcolor: 0, bgalpha: 70};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VerticalChrono = {bgcolor: 0, bgalpha: 50};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeVerticalChrono = {bgcolor: 16737792, bgalpha: 100};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).AlertTextArea = {font: "Font1", embedfonts: true, color: 5327420, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCenterHudgeTextArea = {font: "Font2", embedfonts: true, align: "center", size: 15, color: 0, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueTextArea = {font: "_sans", embebfonts: false, align: "left", size: 12, color: 0, bold: false, italic: false, scrollbarstyle: "LightBrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownTextArea = {font: "_sans", embebfonts: false, align: "left", size: 12, color: 0, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).PopupTextArea = {font: "Font1", embebfonts: true, align: "center", size: 12, color: 0, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).AnswerTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 0, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).CenterSecretQuestionTextArea = {font: "verdana", embedfonts: false, align: "center", size: 12, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).CenterPopupTextArea = {font: "Font1", embedfonts: true, align: "center", size: 12, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RightPopupTextArea = {font: "Font1", embedfonts: true, align: "right", size: 12, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LeftPopupTextArea = {font: "Font1", embedfonts: true, align: "left", size: 12, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteJustifiedSmallTextArea = {font: "Font1", embedfonts: true, align: "justify", size: 10, color: 16777215, bold: false, italic: false, scrollbarstyle: "ChatDebugScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownJustifiedSmallTextArea = {font: "Font1", embedfonts: true, align: "justify", size: 10, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownJustifiedSmallBoldTextArea = {font: "Font1", embedfonts: true, align: "justify", size: 10, color: 2697513, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreyLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 11182717, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 16777215, bold: false, italic: false, scrollbarstyle: "ChatDebugScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLoginLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 4729614, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 12648448, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCenterSmallTextArea = {font: "Font1", embedfonts: true, align: "center", size: 10, color: 12648448, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftMediumTextArea = {font: "Font1", embedfonts: true, align: "left", size: 12, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueRightSmallTextArea = {font: "Font1", embedfonts: true, align: "right", size: 10, color: 26265, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeLeftSmallTextArea = {font: "Font1", embedfonts: true, align: "left", size: 10, color: 16737792, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterSmallTextArea = {font: "Font1", embedfonts: true, align: "center", size: 10, color: 5327420, bold: false, italic: false, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChatTextArea = {font: "verdana", embedfonts: false, align: "left", size: 10, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChatDebugTextArea = {font: "_typewriter", embedfonts: false, align: "left", size: 11, scrollbarstyle: "ChatDebugScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).KnownledgeBaseTextArea = {font: "verdana", embedfonts: false, align: "left", size: 11, color: 5327420, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).FloatingTipsTextArea = {font: "verdana", embedfonts: false, align: "left", size: 10, color: 5327420, scrollbarstyle: "BrownScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteMediumBoldTextArea = {font: "Font2", embedfonts: true, align: "justify", size: 10, color: 16777215, bold: true, italic: false, scrollbarstyle: "ChatDebugScrollBar"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChatDebugScrollBar = {sbarrowbgcolor: -1, sbarrowcolor: 16777215, sbthumbcolor: 16777215, sbtrackcolor: -1};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownScrollBar = {sbarrowbgcolor: 12499352, sbarrowcolor: 5327420, sbthumbcolor: 5327420, sbtrackcolor: 12499352};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownScrollBar = {sbarrowbgcolor: 12499352, sbarrowcolor: 5327420, sbthumbcolor: 5327420, sbtrackcolor: 12499352};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RegisterListScrollBar = {sbarrowbgcolor: 14733762, sbarrowcolor: 12361336, sbthumbcolor: 12361336, sbtrackcolor: 14733762};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ServersListScrollBar = {sbarrowbgcolor: 14733762, sbarrowcolor: 12361336, sbthumbcolor: 12361336, sbtrackcolor: 14733762};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NewsListScrollBar = {sbarrowbgcolor: -1, sbarrowcolor: 7958362, sbthumbcolor: 7958362, sbtrackcolor: -1};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).YellowScrollBar = {sbarrowbgcolor: 12499352, sbarrowcolor: 5327420, sbthumbcolor: 5327420, sbtrackcolor: 12499352};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SubscribeButton = {labelupstyle: "WhiteCenterMediumBoldLabel", labeloverstyle: "WhiteCenterMediumBoldLabel", labeldownstyle: "WhiteCenterMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChooseServerSubscribeButton = {labelupstyle: "BrownCenterMediumLabel", labeloverstyle: "BrownCenterMediumLabel", labeldownstyle: "BrownCenterMediumLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownTransparentButton = {labelupstyle: "BrownLoginRightMediumLabel", labeloverstyle: "OrangeRightMediumLabel", labeldownstyle: "BrownLoginRightMediumLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownTransparentBoldButton = {labelupstyle: "BrownLoginRightMediumBoldLabel", labeloverstyle: "OrangeRightMediumBoldLabel", labeldownstyle: "BrownLoginRightMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LanguageButton = {labelupstyle: "WhiteCenterMediumBoldLabel", labeldownstyle: "WhiteCenterMediumBoldLabel", bgcolor: 7958362, bgdowncolor: 7958362, disabledtransform: {ra: 70, rb: 12, ga: 70, gb: 11, ba: 70, bb: 4}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DecorationButton = {labelupstyle: "BrownCenterBigBoldLabel", labeldownstyle: "BrownCenterBigBoldLabel", bgcolor: 16644334, bordercolor: 11767396, highlightcolor: 0, bgdowncolor: 16736512, borderdowncolor: 11767396, highlightdowncolor: 0, disabledtransform: {ra: 70, rb: 12, ga: 70, gb: 11, ba: 70, bb: 4}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeWhiteBorderButton = {labelupstyle: "WhiteCenterMediumLabel", labeldownstyle: "WhiteCenterMediumLabel", bgcolor: 16736512, bordercolor: 16777215, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 16777215, highlightdowncolor: 11509893, disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeWhiteBorderSpellButton = {labelupstyle: "WhiteLeftMediumLabel", labeldownstyle: "WhiteLeftMediumLabel", bgcolor: 16736512, bordercolor: 16777215, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 16777215, highlightdowncolor: 11509893};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MouthButton = {bgcolor: 16737792, bordercolor: 16777215, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 16777215, highlightdowncolor: 11509893};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TransparentButtonWithDisabled = {labelupstyle: "BrownCenterSmallLabel", labeldownstyle: "OrangeCenterSmallLabel", disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TransparentWhiteButton = {labelupstyle: "WhiteCenterSmallLabel", labeldownstyle: "OrangeCenterSmallLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TransparentButton = {labelupstyle: "BrownCenterSmallLabel", labeldownstyle: "OrangeCenterSmallLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MapButton = {bgcolor: 14012330, bgdowncolor: 16736512};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BigStoreButton = {labelupstyle: "BrownRightSmallLabel", labeloverstyle: "WhiteRightSmallLabel", labeldownstyle: "WhiteRightSmallLabel", bgdowncolor: 16750865};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChatCommandButton = {labelupstyle: "BrownCenterSmallLabel", labeldownstyle: "BrownCenterSmallLabel", labeloverstyle: "WhiteCenterSmallLabel", bgcolor: 12499352, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 12499352, borderdowncolor: 13421772, highlightdowncolor: 11509893};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeButton = {labelupstyle: "WhiteCenterSmallLabel", labeldownstyle: "WhiteCenterSmallLabel", bgcolor: 16736512, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 13421772, highlightdowncolor: 11509893, disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeButtonNoDisabled = {labelupstyle: "WhiteCenterSmallLabel", labeldownstyle: "WhiteCenterSmallLabel", bgcolor: 16736512, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 13421772, highlightdowncolor: 11509893};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MiddleBrownTabButton = {labelupstyle: "BrownCenterSmallBoldLabel", labeldownstyle: "WhiteCenterSmallLabel", bgcolor: 12499352, bordercolor: 14341816, bgdowncolor: 5327420, borderdowncolor: 14341816};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownTabButton = {labelupstyle: "BrownCenterSmallBoldLabel", labeldownstyle: "WhiteCenterSmallLabel", bgcolor: 11840653, bordercolor: 14341816, bgdowncolor: 5327420, borderdowncolor: 14341816};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownTabButton = {labelupstyle: "BrownCenterSmallBoldLabel", labeldownstyle: "BrownCenterSmallLabel", bgcolor: 14078385, bordercolor: 14341816, bgdowncolor: 11840653, borderdowncolor: 14341816};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeCheckButton = {bordercolor: 14012330, bgcolor: 16750848, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 16750848, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).PurpleCheckButton = {bordercolor: 14012330, bgcolor: 6697881, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 6697881, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GrayCheckButton = {bordercolor: 14012330, bgcolor: 7566195, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 7566195, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).PinkCheckButton = {bordercolor: 14012330, bgcolor: 15411662, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 15411662, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NoobCheckButton = {bordercolor: 14012330, bgcolor: 204, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 204, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCheckButton = {bordercolor: 14012330, bgcolor: 6697728, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 6697728, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenCheckButton = {bordercolor: 14012330, bgcolor: 39168, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 39168, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCheckButton = {bordercolor: 14012330, bgcolor: 12648448, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 12648448, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCheckButton = {bordercolor: 14012330, bgcolor: 0, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 0, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueCheckButton = {bordercolor: 14012330, bgcolor: 26367, highlightcolor: 16777215, borderdowncolor: 14012330, bgdowncolor: 26367, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenMapHintCheckButton = {bordercolor: 11840653, bgcolor: 39168, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 39168, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedMapHintCheckButton = {bordercolor: 11840653, bgcolor: 11075584, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 11075584, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueMapHintCheckButton = {bordercolor: 11840653, bgcolor: 26367, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 26367, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BeigeMapHintCheckButton = {bordercolor: 11840653, bgcolor: 15920610, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 15920610, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VioletMapHintCheckButton = {bordercolor: 11840653, bgcolor: 6724044, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 6724044, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).YellowMapHintCheckButton = {bordercolor: 11840653, bgcolor: 16776960, highlightcolor: 0, bordercolor: 11840653, bgdowncolor: 16776960, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeMapHintCheckButton = {bordercolor: 11840653, bgcolor: 16750848, highlightcolor: 0, borderdowncolor: 11840653, bgdowncolor: 16750848, highlightdowncolor: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCheckButton = {bordercolor: 5327420, bgcolor: 16777215, highlightcolor: 0, borderdowncolor: 5327420, bgdowncolor: 16777215, highlightdowncolor: 0, disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownCheckButton = {bordercolor: 5327420, bgcolor: 11840653, highlightcolor: 0, borderdowncolor: 5327420, bgdowncolor: 11840653, highlightdowncolor: 0, disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCrossButton = {bgcolor: 6181958, highlightcolor: 16777215, bgdowncolor: 9996662, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCrossButton = {labelupstyle: "BlackCenterSmallLabel", labeldownstyle: "BrownCenterSmallLabel", bgcolor: 16777215, highlightcolor: 16777215, bgdowncolor: 10066329, highlightdowncolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).FilterButton = {bgcolor: 16736512, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 13421772, highlightdowncolor: 11509893};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SmallSquareButton = {bgcolor: 16736512, bordercolor: 5128232, highlightcolor: 15508082, bgdowncolor: 5327420, borderdowncolor: 13421772, highlightdowncolor: 11509893, disabledtransform: {ra: 70, rb: 0, ga: 70, gb: 0, ba: 70, bb: 0}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftSansLabel = {labelfont: "_sans", labelembedfonts: false, labelalign: "left", labelsize: 10, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackLeftDebugLabel = {labelfont: "_typewriter", labelembedfonts: false, labelalign: "left", labelsize: 11, labelcolor: 0, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackLeftDebugNoColorLabel = {labelfont: "_typewriter", labelembedfonts: false, labelalign: "left", labelsize: 11, labelcolor: 0, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RightTitleLabel = {labelfont: "_sans", labelalign: "right", labelsize: 12, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LeftTitleLabel = {labelfont: "_sans", labelalign: "left", labelsize: 12, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).CenterBoldLabel = {labelfont: "_sans", labelalign: "center", labelsize: 12, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).PriceLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 12, labelcolor: 2299660, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).KamaLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).FilterLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 5327420, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownMediumCenterLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 12, labelcolor: 5327420, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackLeftListLabel = {labelfont: "_sans", labelalign: "left", labelsize: 11, labelcolor: 0, labelbold: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCenterListLabel = {labelfont: "_sans", labelalign: "center", labelsize: 11, labelcolor: 0, labelbold: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackRightListLabel = {labelfont: "_sans", labelalign: "right", labelsize: 11, labelcolor: 0, labelbold: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftListLabel = {labelfont: "_sans", labelalign: "left", labelsize: 11, labelcolor: 16777215, labelbold: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightListLabel = {labelfont: "_sans", labelalign: "right", labelsize: 11, labelcolor: 16777215, labelbold: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteExtraHugeBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 40, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownHugeLeftBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 20, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteHugeCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 15, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteNormalCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 12, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteMediumCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 14, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenNormalCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 12, labelcolor: 65280, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackNormalCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 12, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackHugeCenterBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 15, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 13, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLoginLeftBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 13, labelcolor: 4729614, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 13, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 13, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 13, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackLeftMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteJustifiedSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "justify", labelsize: 10, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteJustifiedMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "justify", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ItemSetLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 16692022, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).EtherealLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 9091054, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 16750848, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftVeryTinyLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 15459275, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterVerySmallLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 9, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightVerySmallLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 9, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftVerySmallLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftBoldMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 15, labelcolor: 5327420, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftBoldMediumSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 13, labelcolor: 5327420, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftMediumSecretAnswerLabel = {labelfont: "Webdings", labelembedfonts: false, labelalign: "left", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownLeftMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 4729614};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCenterMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 16711680, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCenterMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 11, labelcolor: 16711680, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 255, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenLeftMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 11, labelcolor: 26112, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeRightMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 12, labelcolor: 16737792, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeRightMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 12, labelcolor: 16737792, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLoginRightMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 4729614, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLoginRightMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 4729614, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightMediumBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackRightMediumLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 11, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 0, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCenterHugeLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 15, labelcolor: 2696735, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 16736512, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightVerySmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 9, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownRightSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 11380094, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 7798784, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 11141120, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCenterBigBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 15, labelcolor: 15597568, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedCenterVerySmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 9, labelcolor: 11141120, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterVeryTinyLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 5, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 26112, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).YellowCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 16776960, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 170, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 26112, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkGrayLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 6710886, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GrayLeftSmallBoldLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 15395039, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenLeftSmallBoldLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 26112, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedLeftSmallBoldLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 12648448, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreyLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 11182717, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ItemSetLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 11102721, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).EtherealLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 1993932, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 13260, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueRightSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 26265, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 16737792, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownLeftSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 11380094, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCenterSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 16777215, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteRightSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 16777215, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RedRightSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 12648448, labelbold: true, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "left", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownCenterSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "center", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightSmallBoldLabel = {labelfont: "Font2", labelembedfonts: true, labelalign: "right", labelsize: 10, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownRightExtraSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "right", labelsize: 9, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftExtraSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownLeftExtraSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 4729614, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlueLeftExtraSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 255, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreenLeftExtraSmallLabel = {labelfont: "Font1", labelembedfonts: true, labelalign: "left", labelsize: 9, labelcolor: 26112, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownLeftPixelLabel = {labelfont: "Font3", labelembedfonts: true, labelalign: "left", labelsize: 8, labelcolor: 5327420, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownLeftPixelLabel = {labelfont: "Font3", labelembedfonts: true, labelalign: "left", labelsize: 8, labelcolor: 11380094, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).GreyBrownLeftPixelLabel = {labelfont: "Font3", labelembedfonts: true, labelalign: "left", labelsize: 8, labelcolor: 11380094, labelbold: false, labelitalic: false};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackCellRenderer = {defaultstyle: "BlackLeftListLabel", leftstyle: "BlackLeftListLabel", rightstyle: "BlackRightListLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteCellRenderer = {defaultstyle: "WhiteLeftListLabel", leftstyle: "WhiteLeftListLabel", rightstyle: "WhiteRightListLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownList = {cellrendererstyle: "WhiteCellRenderer", scrollbarstyle: "BrownScrollBar", cellbgcolor: [8683882, 9736310], cellselectedcolor: 16750865, cellovercolor: 6249548};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NpcDialogList = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "YellowScrollBar", cellbgcolor: 16777166, cellselectedcolor: 16777166, cellovercolor: 16750848};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).IndexList = {cellrendererstyle: "BlackCellRenderer", cellbgcolor: -1, cellselectedcolor: -1, cellovercolor: 16750848};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NewsList = {scrollbarstyle: "NewsListScrollBar", cellbgcolor: -1, cellselectedcolor: -1, cellovercolor: 15526886};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ServersList = {cellrendererstyle: "WhiteLeftSansLabel", scrollbarstyle: "ServersListScrollBar", cellbgcolor: 0, cellselectedcolor: 16750865, cellovercolor: 13421772};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ComboBoxRegisterList = {cellrendererstyle: "BrownLeftSmallLabel", scrollbarstyle: "RegisterListScrollBar", cellbgcolor: 15000545, cellselectedcolor: 10392448, cellovercolor: 7299402};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ComboBoxServersList = {cellrendererstyle: "BrownLeftSmallLabel", scrollbarstyle: "ServersListScrollBar", cellbgcolor: 16777215, cellselectedcolor: 16750865, cellovercolor: 11767396};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownList = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [11840653, 13221789], cellselectedcolor: 16750865, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownList2 = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [13221789, 14012330], cellselectedcolor: 16750865, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownListNoSelect = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [11840653, 13221789], cellselectedcolor: -1, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownListNoSelectNoOver = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [11840653, 13221789], cellselectedcolor: -1, cellovercolor: -1};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownUniformList = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [14341816], cellselectedcolor: 16750865, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownList = {cellrendererstyle: "BlackCellRenderer", scrollbarstyle: "LightBrownScrollBar", cellbgcolor: 13221789, cellselectedcolor: 16750865, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SpellLightBrownList = {scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [14078385, 14934218], cellselectedcolor: -1, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).HousesLightBrownList = {scrollbarstyle: "LightBrownScrollBar", cellbgcolor: [14078385, 14934218], cellselectedcolor: 16750865, cellovercolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownListInventory = {bgtitlecolor: 5195833, bordercolor: 16777215, bgfiltercolor: 12433815, bgcolor: 6380360, liststyle: "BrownList", titlestyle: "LeftTitleLabel", buttonstyle: "FilterButton", pricestyle: "PriceLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownListInventory = {bgtitlecolor: 5327420, bordercolor: 16777215, bgfiltercolor: 14012330, bgcolor: 9208680, liststyle: "LightBrownList", titlestyle: "LeftTitleLabel", buttonstyle: "FilterButton", pricestyle: "PriceLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownItemViewer = {bgtitlecolor: 5195833, bordercolor: 16777215, bgcolor: 6380360, bgdescriptioncolor: 14931641, bgiconcolor: 15197135, liststyle: "BrownList", namestyle: "LeftTitleLabel", levelstyle: "RightTitleLabel", descriptionstyle: "BrownLeftSmallTextArea", pricestyle: "PriceLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownItemViewer = {bgtitlecolor: 5327420, bordercolor: 16777215, bgcolor: 9208680, bgdescriptioncolor: 14012330, bgiconcolor: 15197135, liststyle: "LightBrownList", namestyle: "LeftTitleLabel", levelstyle: "RightTitleLabel", descriptionstyle: "BrownLeftSmallTextArea", pricestyle: "PriceLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).Shop = {buttonstyle: "OrangeButton", shopitemviewerstyle: "BrownItemViewer", playeritemviewerstyle: "LightBrownItemViewer"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BoldItalicLabel = {labelfont: "_sans", labelalign: "center", labelsize: 13, labelcolor: 16777215, labelbold: true, labelitalic: true};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).InventoryGridContainer = {labelstyle: "WhiteLeftSansLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).InventoryGrid = {scrollbarstyle: "BrownScrollBar", containerbackground: "UI_InventoryGridBackground", containerhighlight: "UI_InventoryGridHighlight", containerstyle: "InventoryGridContainer", containermargin: 2};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SmileyGrid = {containerhighlight: "SmileyContainerHighlight", containermargin: 2};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExchangeGrid = {scrollbarstyle: "BrownScrollBar", containerbackground: "UI_ExchangeGridBackground", containerhighlight: "UI_ExchangeGridHighlight", containermargin: 2, containerstyle: "InventoryGridContainer"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SecureCraftGrid = {scrollbarstyle: "BrownScrollBar", containerbackground: "UI_SecureCraftGridBackground", containerhighlight: "UI_SecureCraftGridHighlight", containerstyle: "InventoryGridContainer"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SpellsGrid = {scrollbarstyle: "BrownScrollBar", containerbackground: "UI_SpellsContainerBackground", containerborder: "UI_SpellsContainerBorder", containerhighlight: "UI_SpellsContainerHighlight", containermargin: 2, containerstyle: "InventoryGridContainer"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).Inventory = {bgtitlecolor: 5327420, bordercolor: 16777215, bgcolor: 14012330, bggridcolor: 5327420, itenviewerstyle: "LightBrownItemViewer"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackTransparentWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 4735287, borderwidth: 3, backgroundcolor: [9931647, 986379], backgroundrotation: {matrixType: "box", x: 0, y: 0, w: undefined, h: undefined, r: 90 * 1.745329E-002}, backgroundalpha: [95, 100], titlecolor: 1906454, titleheight: 22, titlestyle: "WhiteCenterMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChatWhiteWindow = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 0, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownPanelWindow = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MediumBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 13221789, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownToDarkBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: [14012330, 9668204], backgroundrotation: {matrixType: "box", x: 0, y: 0, w: undefined, h: undefined, r: 90 * 1.745329E-002}, backgroundratio: [155, 255], titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VeryDarkBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 9668204, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 16052452, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindowRightBottom = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownBigStoreBuyWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 0}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownCrafterListWindow = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownItemSetWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 5327420, titleheight: 22, titlestyle: "ItemSetLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownNoBorderWindow = {cornerradius: {tl: 8, tr: 8, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 0, backgroundcolor: 13221789, titlecolor: 5327420, titleheight: 20, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindowNoTitle = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 14012330, titleheight: 13};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindowNoTitleRounded = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: [14012330, 13221789], backgroundrotation: {matrixType: "box", x: 0, y: 0, w: undefined, h: undefined, r: 0}, backgroundratio: [100, 156], titlecolor: 14012330, displaytitle: false, titleheight: 13};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindowNoTitleFullRound = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 14012330, titlecolor: 14012330, titleheight: 13};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).KeySymbolWindow = {cornerradius: {tl: 8, tr: 8, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 2, backgroundcolor: 14012330, titlecolor: 14012330, titleheight: 13};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownWindowPopup = {cornerradius: {tl: 5, tr: 5, br: 5, bl: 5}, bordercolor: 16777215, borderwidth: 2, backgroundcolor: 14012330, titlecolor: 14012330, titleheight: 5};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightOrangeWindowNoTitle = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 2, backgroundcolor: 16736512, titlecolor: 16736512, titleheight: 13};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownWindow = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 5327420, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownWindowStraightUp = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 3, backgroundcolor: 5327420, titlecolor: 5327420, titleheight: 22, titlestyle: "WhiteLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).JobBackgroundWindow = {cornerradius: {tl: 5, tr: 5, br: 0, bl: 0}, bordercolor: 16777215, borderwidth: 0, backgroundcolor: 14341816, titlecolor: 11840653, titleheight: 20, titlestyle: "LeftTitleLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NpcDialogWindow = {cornerradius: {tl: 5, tr: 5, br: 5, bl: 5}, bordercolor: 0, borderwidth: 2, backgroundcolor: 0, titlecolor: 16777166, titleheight: 5, titlestyle: "BlackLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NpcDialogWindowUp = {cornerradius: {tl: 4, tr: 4, br: 4, bl: 4}, bordercolor: 15132346, borderwidth: 5, backgroundcolor: 16777166, titlecolor: 16777166, titleheight: 25, titlestyle: "BlackLeftMediumBoldLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TranparentBackgroundHidder = {backgroundcolor: 0, backgroundalpha: 0};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBackgroundHidder = {backgroundcolor: 0, backgroundalpha: 10};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VeryDarkBackgroundHidder = {backgroundcolor: 0, backgroundalpha: 20};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VeryVeryDarkBackgroundHidder = {backgroundcolor: 0, backgroundalpha: 50};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BlackBackgroundHidder = {backgroundcolor: 0, backgroundalpha: 100};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).NormalJobViewer = {backgroundcolor: 14012330};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).SelectedJobViewer = {backgroundcolor: 16736512};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownProgressBar = {bgcolor: 5327420, upcolor: 16737792};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).EtherealNormalProgressBar = {bgcolor: 11840653, upcolor: 11840653};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).EtherealCriticalProgressBar = {bgcolor: 11840653, upcolor: 16711680};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownProgressBar = {bgcolor: 14012330, upcolor: 16737792};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownPopupMenu = {bordercolor: 16777215, backgroundcolor: 5327420, foregroundcolor: 14012330, itembgcolor: 14012330, itemovercolor: 16737792, itemstaticbgcolor: 5327420, labelstaticstyle: "LightBrownLeftPixelLabel", labelenabledstyle: "BrownLeftPixelLabel", labeldisabledstyle: "GreyBrownLeftPixelLabel"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeVolumeSlider = {oncolor: 16737792, offcolor: 11840653};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeChrono = {bgcolor: 16737792};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownStylizedAllRoundRectangle = {cornerradius: {tl: 12, tr: 12, br: 12, bl: 12}, bgcolor: 4735287};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DarkBrownStylizedBottomRoundRectangle = {cornerradius: {tl: 0, tr: 0, br: 12, bl: 12}, bgcolor: 11840653};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MediumDarkBrownStylizedAllRoundRectangle = {cornerradius: {tl: 15, tr: 15, br: 15, bl: 15}, bgcolor: 6379337};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BigStoreSellStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 10, bl: 10}, bgcolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteChatStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteBLRoundStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 0, bl: 10}, bgcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteSpellInfosStylizedRectangle = {cornerradius: {tl: 13, tr: 13, br: 0, bl: 0}, bgcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).WhiteSpellFullInfosStylizedRectangle = {cornerradius: {tl: 13, tr: 13, br: 13, bl: 13}, bgcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownChatStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 9208680};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownChatStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 14012330};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownSpellInfosStylizedRectangle = {cornerradius: {tl: 10, tr: 10, br: 0, bl: 0}, bgcolor: 15592412};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownSpellFullInfosStylizedRectangle = {cornerradius: {tl: 10, tr: 10, br: 10, bl: 10}, bgcolor: 15592412};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 15722712};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MediumBrownStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 11767396};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MediumBrownAllRoundStylizedRectangle = {cornerradius: {tl: 5, tr: 5, br: 5, bl: 5}, bgcolor: 12499352};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownAllRoundStylizedRectangle = {cornerradius: {tl: 10, tr: 10, br: 10, bl: 10}, bgcolor: 5327420};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownTopRoundStylizedRectangle = {cornerradius: {tl: 10, tr: 10, br: 0, bl: 0}, bgcolor: 5327420};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownAllRoundStylizedRectangle = {cornerradius: {tl: 8, tr: 8, br: 8, bl: 8}, bgcolor: 11767396};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownAllRoundStylizedRectangle = {cornerradius: {tl: 7, tr: 7, br: 7, bl: 7}, bgcolor: 16644329};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ExtraLightBrownButtomLeftRoundStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 0, bl: 7}, bgcolor: 15066553, alpha: 50};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).QuiteBrownButtomRoundStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 10, bl: 10}, bgcolor: 9668204};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ShortcutsBrownButtomRoundStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 10, bl: 10}, bgcolor: 13221789};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LoginBackStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 14472630};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LoginBorderStylizedRectangle = {cornerradius: {tl: 0, tr: 10, br: 0, bl: 0}, bgcolor: 11767396};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DebugLogsStylizedRectangle = {cornerradius: {tl: 8, tr: 8, br: 0, bl: 0}, bgcolor: 0, alpha: 70};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DebugCommandLineStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 8, bl: 8}, bgcolor: 16777215, alpha: 70};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChooseServerStylizedRectangle = {cornerradius: {tl: 10, tr: 0, br: 10, bl: 10}, bgcolor: 16777215, alpha: 30};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).MovableBarStylizedRectangle = {cornerradius: {tl: 3, tr: 3, br: 3, bl: 3}, bgcolor: 12104079};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TopMovableBarStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 3, bl: 3}, bgcolor: 12104079};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LeftMovableBarStylizedRectangle = {cornerradius: {tl: 0, tr: 3, br: 3, bl: 0}, bgcolor: 12104079};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RightMovableBarStylizedRectangle = {cornerradius: {tl: 3, tr: 0, br: 0, bl: 3}, bgcolor: 12104079};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BottomMovableBarStylizedRectangle = {cornerradius: {tl: 3, tr: 3, br: 0, bl: 0}, bgcolor: 12104079};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VerticalDragOneMovableBarStylizedRectangle = {cornerradius: {tl: 3, tr: 3, br: 0, bl: 0}, bgcolor: 4139540};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).VerticalDragTwoMovableBarStylizedRectangle = {cornerradius: {tl: 0, tr: 0, br: 3, bl: 3}, bgcolor: 4139540};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).HorizontalDragOneMovableBarStylizedRectangle = {cornerradius: {tl: 3, tr: 0, br: 0, bl: 3}, bgcolor: 4139540};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).HorizontalDragTwoMovableBarStylizedRectangle = {cornerradius: {tl: 0, tr: 3, br: 3, bl: 0}, bgcolor: 4139540};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ChooseCharacterSprite = {overcolor: 16699273, selectedcolor: 15502850, desabledtransform: {ra: 70, rb: 12, ga: 70, gb: 11, ba: 70, bb: 4}};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightBrownDataGrid = {labelstyle: "WhiteCenterSmallLabel", liststyle: "LightBrownListNoSelect", titlebgcolor: "0x514A3C"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightTitleBrownDataGrid = {labelstyle: "WhiteCenterSmallLabel", liststyle: "LightBrownList", titlebgcolor: "0x93866C"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).TitleBrownDataGrid = {labelstyle: "WhiteNormalCenterBoldLabel", liststyle: "LightBrownList", titlebgcolor: "0x93866C"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).LightTitleBrownDataGridNoSelectNoOver = {labelstyle: "WhiteCenterSmallLabel", liststyle: "LightBrownListNoSelectNoOver", titlebgcolor: "0x93866C"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ServersDataGrid = {labelstyle: "WhiteCenterSmallLabel", liststyle: "LightBrownListNoSelectNoOver", titlebgcolor: "0x93866C"};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).BrownMap = {buttonstyle: "MapButton", bordercolor: 12104079, gridcolor: 12104079, bgcolor: 15195335};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeComboBox = {labelstyle: "BrownCenterSmallLabel", buttonstyle: "OrangeButton", liststyle: "ComboBoxServersList", listbordercolor: 12427128, bgcolor: 16777215, bordercolor: 12427128, highlightcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).OrangeLeftComboBox = {labelstyle: "BrownLeftSmallLabel", buttonstyle: "OrangeButton", liststyle: "ComboBoxServersList", listbordercolor: 12427128, bgcolor: 16777215, bordercolor: 12427128, highlightcolor: 16777215};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).RegisterLeftComboBox = {labelstyle: "BrownLeftSmallLabel", buttonstyle: "OrangeButton", liststyle: "ComboBoxRegisterList", listbordercolor: 10392448, bgcolor: 15066081, bordercolor: 10392448, highlightcolor: 15066081};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).ConsoleLogger = {font: "_sans", embedfonts: false, size: 12};
    (_global.dofus.graphics.gapi.styles.DofusStylePackage = function ()
    {
        super();
    }).DofusFps = {labelstyle: "WhiteCenterSmallLabel", backalpha: 50, backcolor: 0};
} // end if
#endinitclip
