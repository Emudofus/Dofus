// Action script...

// [Initial MovieClip Action of sprite 1007]
#initclip 224
class dofus.graphics.gapi.ui.Options extends ank.gapi.core.UIAdvancedComponent
{
    var _eaDisplayStyles, api, unloadThis, addToQueue, _lblGeneral, _lblDetailLevel, _lblAudio, _lblOptimize, _lblDisplay, _winBackground, _lblMusic, _lblSounds, _btnClose2, _btnDefault, _btnShortcuts, _btnClearCache, _lblGrid, _lblTransparency, _lblSpriteInfos, _lblSpriteMove, _lblMapInfos, _lblAutoHideSmileys, _lblStringCourse, _lblPointsOverHead, _lblChatEffects, _lblBuff, _lblGuildMessageSound, _lblStartTurnSound, _lblBannerShortcuts, _lblTipsOnStart, _lblCreaturesMode, _lblDisplayStyle, _lblDisplayStyle2, _btnClose, _vsMusic, _vsSounds, _vsCreaturesMode, _btnMuteMusic, _btnMuteSounds, _btnGrid, _btnTransparency, _btnSpriteInfos, _btnSpriteMove, _btnMapInfos, _btnAutoHideSmileys, _btnStringCourse, _btnPointsOverHead, _btnChatEffects, _btnBuff, _btnGuildMessageSound, _btnStartTurnSound, _btnBannerShortcuts, _btnTipsOnStart, _cbDisplayStyle, _lblCreaturesModeValue;
    function Options()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.ui.Options.CLASS_NAME);
        _eaDisplayStyles = new ank.utils.ExtendedArray();
        _eaDisplayStyles.push({label: api.lang.getText("DISPLAYSTYLE_NORMAL"), style: "normal"});
        if (System.capabilities.screenResolutionY > 950)
        {
            _eaDisplayStyles.push({label: api.lang.getText("DISPLAYSTYLE_MEDIUM"), style: "medium"});
        } // end if
        _eaDisplayStyles.push({label: api.lang.getText("DISPLAYSTYLE_MAXIMIZED"), style: "maximized"});
    } // End of the function
    function callClose()
    {
        this.unloadThis();
        return (true);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initTexts()
    {
        _lblGeneral.__set__text(api.lang.getText("OPTIONS_GENERAL"));
        _lblDetailLevel.__set__text(api.lang.getText("OPTIONS_DETAILLEVEL"));
        _lblAudio.__set__text(api.lang.getText("OPTIONS_AUDIO"));
        _lblOptimize.__set__text(api.lang.getText("OPTIONS_OPTIMIZE"));
        _lblDisplay.__set__text(api.lang.getText("OPTIONS_DISPLAY"));
        _winBackground.__set__title(api.lang.getText("OPTIONS"));
        _lblMusic.__set__text(api.lang.getText("MUSICS"));
        _lblSounds.__set__text(api.lang.getText("SOUNDS"));
        _btnClose2.__set__label(api.lang.getText("CLOSE"));
        _btnDefault.__set__label(api.lang.getText("DEFAULT"));
        _btnShortcuts.__set__label(api.lang.getText("KEYBORD_SHORTCUT"));
        _btnClearCache.__set__label(api.lang.getText("CLEAR_CACHE"));
        _lblGrid.__set__text(api.lang.getText("OPTION_GRID") + (api.lang.getKeyboardShortcut("GRID") != undefined ? (" (" + api.lang.getKeyboardShortcut("GRID").k + ")") : ("")));
        _lblTransparency.__set__text(api.lang.getText("OPTION_TRANSPARENCY") + (api.lang.getKeyboardShortcut("TRANSPARENCY") != undefined ? (" (" + api.lang.getKeyboardShortcut("TRANSPARENCY").k + ")") : ("")));
        _lblSpriteInfos.__set__text(api.lang.getText("OPTION_SPRITEINFOS") + (api.lang.getKeyboardShortcut("SPRITEINFOS") != undefined ? (" (" + api.lang.getKeyboardShortcut("SPRITEINFOS").k + ")") : ("")));
        _lblSpriteMove.__set__text(api.lang.getText("OPTION_SPRITEMOVE"));
        _lblMapInfos.__set__text(api.lang.getText("OPTION_MAPINFOS") + (api.lang.getKeyboardShortcut("COORDS") != undefined ? (" (" + api.lang.getKeyboardShortcut("COORDS").k + ")") : ("")));
        _lblAutoHideSmileys.__set__text(api.lang.getText("OPTION_AUTOHIDESMILEYS"));
        _lblStringCourse.__set__text(api.lang.getText("OPTION_STRINGCOURSE") + (api.lang.getKeyboardShortcut("STRINGCOURSE") != undefined ? (" (" + api.lang.getKeyboardShortcut("STRINGCOURSE").k + ")") : ("")));
        _lblPointsOverHead.__set__text(api.lang.getText("OPTION_POINTSOVERHEAD"));
        _lblChatEffects.__set__text(api.lang.getText("OPTION_CHATEFFECTS"));
        _lblBuff.__set__text(api.lang.getText("OPTION_BUFF") + (api.lang.getKeyboardShortcut("BUFF") != undefined ? (" (" + api.lang.getKeyboardShortcut("BUFF").k + ")") : ("")));
        _lblGuildMessageSound.__set__text(api.lang.getText("OPTION_GUILDMESSAGESOUND"));
        _lblStartTurnSound.__set__text(api.lang.getText("OPTION_STARTTURNSOUND"));
        _lblBannerShortcuts.__set__text(api.lang.getText("OPTION_BANNERSHORTCUTS"));
        _lblTipsOnStart.__set__text(api.lang.getText("OPTION_TIPSONSTART"));
        _lblCreaturesMode.__set__text(api.lang.getText("OPTION_CREATURESMODE"));
        _lblDisplayStyle.__set__text(api.lang.getText("OPTION_DISPLAYSTYLE"));
        _lblDisplayStyle2.__set__text(api.lang.getText("OPTION_DISPLAYSTYLE2"));
    } // End of the function
    function addListeners()
    {
        _btnClose.addEventListener("click", this);
        _btnClose2.addEventListener("click", this);
        _btnShortcuts.addEventListener("click", this);
        _btnClearCache.addEventListener("click", this);
        _vsMusic.addEventListener("change", this);
        _vsSounds.addEventListener("change", this);
        _vsCreaturesMode.addEventListener("change", this);
        _btnMuteMusic.addEventListener("click", this);
        _btnMuteSounds.addEventListener("click", this);
        _btnDefault.addEventListener("click", this);
        _btnGrid.addEventListener("click", this);
        _btnTransparency.addEventListener("click", this);
        _btnSpriteInfos.addEventListener("click", this);
        _btnSpriteMove.addEventListener("click", this);
        _btnMapInfos.addEventListener("click", this);
        _btnAutoHideSmileys.addEventListener("click", this);
        _btnStringCourse.addEventListener("click", this);
        _btnPointsOverHead.addEventListener("click", this);
        _btnChatEffects.addEventListener("click", this);
        _btnBuff.addEventListener("click", this);
        _btnGuildMessageSound.addEventListener("click", this);
        _btnStartTurnSound.addEventListener("click", this);
        _btnBannerShortcuts.addEventListener("click", this);
        _btnTipsOnStart.addEventListener("click", this);
        api.kernel.OptionsManager.addEventListener("optionChanged", this);
        _cbDisplayStyle.addEventListener("itemSelected", this);
    } // End of the function
    function initData()
    {
        _btnShortcuts.__set__enabled(api.lang.getKeyboardShortcuts() != undefined);
        _vsMusic.__set__value(api.sounds.getVolumeMusic());
        _vsSounds.__set__value(api.sounds.getVolumeSound());
        _btnMuteMusic.__set__selected(api.sounds.getMuteMusic());
        _btnMuteSounds.__set__selected(api.sounds.getMuteSound());
        var _loc2 = api.kernel.OptionsManager;
        _btnGrid.__set__selected(_loc2.getOption("Grid"));
        _btnTransparency.__set__selected(_loc2.getOption("Transparency"));
        _btnSpriteInfos.__set__selected(_loc2.getOption("SpriteInfos"));
        _btnSpriteMove.__set__selected(_loc2.getOption("SpriteMove"));
        _btnMapInfos.__set__selected(_loc2.getOption("MapInfos"));
        _btnAutoHideSmileys.__set__selected(_loc2.getOption("AutoHideSmileys"));
        _btnStringCourse.__set__selected(_loc2.getOption("StringCourse"));
        _btnPointsOverHead.__set__selected(_loc2.getOption("PointsOverHead"));
        _btnChatEffects.__set__selected(_loc2.getOption("ChatEffects"));
        _btnBuff.__set__selected(_loc2.getOption("Buff"));
        _btnGuildMessageSound.__set__selected(_loc2.getOption("GuildMessageSound"));
        _btnStartTurnSound.__set__selected(_loc2.getOption("StartTurnSound"));
        _btnBannerShortcuts.__set__selected(_loc2.getOption("BannerShortcuts"));
        _btnTipsOnStart.__set__selected(_loc2.getOption("TipsOnStart"));
        _vsCreaturesMode.__set__value(_loc2.getOption("CreaturesMode"));
        _lblCreaturesModeValue.__set__text(_loc2.getOption("CreaturesMode"));
        _cbDisplayStyle.__set__dataProvider(_eaDisplayStyles);
        this.selectDisplayStyle(System.capabilities.playerType == "StandAlone" ? ("normal") : (_loc2.getOption("DisplayStyle")));
        var _loc3 = System.capabilities.playerType == "PlugIn" || System.capabilities.playerType == "ActiveX";
        _cbDisplayStyle.__set__enabled(_loc3);
        var _loc4 = new Color(_cbDisplayStyle);
        _loc4.setTransform(_loc3 ? ({ra: 100, rb: 0, ga: 100, gb: 0, ba: 100, bb: 0}) : ({ra: 30, rb: 149, ga: 30, gb: 145, ba: 30, bb: 119}));
    } // End of the function
    function selectDisplayStyle(sStyleName)
    {
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < _eaDisplayStyles.length; ++_loc2)
        {
            if (_eaDisplayStyles[_loc2].style == sStyleName)
            {
                _loc3 = _loc2;
                break;
            } // end if
        } // end of for
        _cbDisplayStyle.__set__selectedIndex(_loc3);
    } // End of the function
    function click(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnMuteMusic":
            {
                api.sounds.setMuteMusic(oEvent.target.selected);
                break;
            } 
            case "_btnMuteSounds":
            {
                api.sounds.setMuteSound(oEvent.target.selected);
                break;
            } 
            case "_btnClose":
            case "_btnClose2":
            {
                this.callClose();
                break;
            } 
            case "_btnDefault":
            {
                api.kernel.OptionsManager.loadDefault();
                break;
            } 
            case "_btnShortcuts":
            {
                api.ui.loadUIComponent("Shortcuts", "Shortcuts", undefined, {bAlwaysOnTop: true});
                break;
            } 
            case "_btnClearCache":
            {
                api.kernel.askClearCache();
                break;
            } 
            case "_btnGrid":
            {
                api.kernel.OptionsManager.setOption("Grid", oEvent.target.selected);
                break;
            } 
            case "_btnTransparency":
            {
                api.kernel.OptionsManager.setOption("Transparency", oEvent.target.selected);
                break;
            } 
            case "_btnSpriteInfos":
            {
                api.kernel.OptionsManager.setOption("SpriteInfos", oEvent.target.selected);
                break;
            } 
            case "_btnSpriteMove":
            {
                api.kernel.OptionsManager.setOption("SpriteMove", oEvent.target.selected);
                break;
            } 
            case "_btnMapInfos":
            {
                api.kernel.OptionsManager.setOption("MapInfos", oEvent.target.selected);
                break;
            } 
            case "_btnAutoHideSmileys":
            {
                api.kernel.OptionsManager.setOption("AutoHideSmileys", oEvent.target.selected);
                break;
            } 
            case "_btnStringCourse":
            {
                api.kernel.OptionsManager.setOption("StringCourse", oEvent.target.selected);
                break;
            } 
            case "_btnPointsOverHead":
            {
                api.kernel.OptionsManager.setOption("PointsOverHead", oEvent.target.selected);
                break;
            } 
            case "_btnChatEffects":
            {
                api.kernel.OptionsManager.setOption("ChatEffects", oEvent.target.selected);
                break;
            } 
            case "_btnBuff":
            {
                api.kernel.OptionsManager.setOption("Buff", oEvent.target.selected);
                break;
            } 
            case "_btnGuildMessageSound":
            {
                api.kernel.OptionsManager.setOption("GuildMessageSound", oEvent.target.selected);
                break;
            } 
            case "_btnStartTurnSound":
            {
                api.kernel.OptionsManager.setOption("StartTurnSound", oEvent.target.selected);
                break;
            } 
            case "_btnBannerShortcuts":
            {
                api.kernel.OptionsManager.setOption("BannerShortcuts", oEvent.target.selected);
                break;
            } 
            case "_btnTipsOnStart":
            {
                api.kernel.OptionsManager.setOption("TipsOnStart", oEvent.target.selected);
                break;
            } 
        } // End of switch
    } // End of the function
    function change(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_vsMusic":
            {
                api.sounds.setVolumeMusic(oEvent.target.value);
                break;
            } 
            case "_vsSounds":
            {
                api.sounds.setVolumeSound(oEvent.target.value);
                break;
            } 
            case "_vsCreaturesMode":
            {
                if (oEvent.target.value == oEvent.target.max)
                {
                    api.kernel.OptionsManager.setOption("CreaturesMode", Number.POSITIVE_INFINITY);
                }
                else
                {
                    api.kernel.OptionsManager.setOption("CreaturesMode", Math.floor(oEvent.target.value));
                } // end else if
                break;
            } 
        } // End of switch
    } // End of the function
    function optionChanged(oEvent)
    {
        switch (oEvent.key)
        {
            case "Grid":
            {
                _btnGrid.__set__selected(oEvent.value);
                break;
            } 
            case "Transparency":
            {
                _btnTransparency.__set__selected(oEvent.value);
                break;
            } 
            case "SpriteInfos":
            {
                _btnSpriteInfos.__set__selected(oEvent.value);
                break;
            } 
            case "SpriteMove":
            {
                _btnSpriteMove.__set__selected(oEvent.value);
                break;
            } 
            case "MapInfos":
            {
                _btnMapInfos.__set__selected(oEvent.value);
                break;
            } 
            case "AutoHideSmileys":
            {
                _btnAutoHideSmileys.__set__selected(oEvent.value);
                break;
            } 
            case "StringCourse":
            {
                _btnStringCourse.__set__selected(oEvent.value);
                break;
            } 
            case "PointsOverHead":
            {
                _btnPointsOverHead.__set__selected(oEvent.value);
                break;
            } 
            case "ChatEffects":
            {
                _btnChatEffects.__set__selected(oEvent.value);
                break;
            } 
            case "CreaturesMode":
            {
                _vsCreaturesMode.__set__value(oEvent.value);
                _lblCreaturesModeValue.__set__text(isFinite(oEvent.value) ? (oEvent.value) : (api.lang.getText("INFINIT")));
                break;
            } 
            case "Buff":
            {
                _btnBuff.__set__selected(oEvent.value);
                break;
            } 
            case "GuildMessageSound":
            {
                _btnGuildMessageSound.__set__selected(oEvent.value);
                break;
            } 
            case "StartTurnSound":
            {
                _btnStartTurnSound.__set__selected(oEvent.value);
                break;
            } 
            case "BannerShortcuts":
            {
                _btnBannerShortcuts.__set__selected(oEvent.value);
                break;
            } 
            case "TipsOnStart":
            {
                _btnTipsOnStart.__set__selected(oEvent.value);
                break;
            } 
            case "DisplayStyle":
            {
                this.selectDisplayStyle(oEvent.value);
                break;
            } 
        } // End of switch
    } // End of the function
    function itemSelected(oEvent)
    {
        var _loc2 = oEvent.target.selectedItem;
        if (_loc2.style == "normal")
        {
            api.kernel.OptionsManager.setOption("DisplayStyle", _loc2.style);
        }
        else
        {
            api.kernel.showMessage(api.lang.getText("OPTIONS_DISPLAY"), api.lang.getText("DO_U_CHANGE_DISPLAYSTYLE"), "CAUTION_YESNO", {name: "Display", listener: this, params: {style: _loc2.style}});
        } // end else if
    } // End of the function
    function yes(oEvent)
    {
        api.kernel.OptionsManager.setOption("DisplayStyle", oEvent.target.params.style);
    } // End of the function
    function no(oEvent)
    {
        this.selectDisplayStyle(api.kernel.OptionsManager.getOption("DisplayStyle"));
    } // End of the function
    static var CLASS_NAME = "Options";
} // End of Class
#endinitclip
