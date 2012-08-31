// Action script...

// [Initial MovieClip Action of sprite 901]
#initclip 113
class dofus.managers.OptionsManager extends dofus.utils.ApiElement
{
    var _so, dispatchEvent, api;
    function OptionsManager(oAPI)
    {
        super();
        this.initialize(oAPI);
    } // End of the function
    function initialize(oAPI)
    {
        super.initialize(oAPI);
        mx.events.EventDispatcher.initialize(this);
        _so = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
        if (_so.data.loaded == undefined)
        {
            _so.clear();
        } // end if
        for (var _loc4 in dofus.managers.OptionsManager.DEFAULT_VALUES)
        {
            if (_so.data[_loc4] == undefined)
            {
                _so.data[_loc4] = dofus.managers.OptionsManager.DEFAULT_VALUES[_loc4];
            } // end if
        } // end of for...in
        _so.flush();
    } // End of the function
    function loadDefault()
    {
        var _loc3 = _so.data.language;
        _so.clear();
        for (var _loc2 in dofus.managers.OptionsManager.DEFAULT_VALUES)
        {
            this.setOption(_loc2, dofus.managers.OptionsManager.DEFAULT_VALUES[_loc2]);
        } // end of for...in
        _so.data.language = _loc3;
    } // End of the function
    function setOption(sKey, mValue)
    {
        var _loc2 = this.saveValue(sKey, mValue);
        if (this.applyOption(sKey, _loc2))
        {
            this.dispatchEvent({type: "optionChanged", key: sKey, value: _loc2});
        } // end if
    } // End of the function
    function getOption(sKey)
    {
        return (this.loadValue(sKey));
    } // End of the function
    function applyAllOptions()
    {
        var _loc2 = _so.data;
        for (var _loc3 in _loc2)
        {
            this.applyOption(_loc3, _loc2[_loc3]);
        } // end of for...in
    } // End of the function
    function saveValue(sKey, mValue)
    {
        var _loc2 = _so.data;
        if (mValue == undefined)
        {
            if (typeof(_loc2[sKey]) == "boolean")
            {
                _loc2[sKey] = !_loc2[sKey];
            }
            else
            {
                _loc2[sKey] = true;
            } // end else if
        }
        else
        {
            _loc2[sKey] = mValue;
        } // end else if
        _so.flush();
        return (_loc2[sKey]);
    } // End of the function
    function loadValue(sKey)
    {
        return (_so.data[sKey]);
    } // End of the function
    function applyOption(sKey, mValue)
    {
        switch (sKey)
        {
            case "Grid":
            {
                if (mValue == true)
                {
                    api.gfx.drawGrid();
                }
                else
                {
                    api.gfx.removeGrid();
                } // end else if
                break;
            } 
            case "Transparency":
            {
                api.gfx.setSpriteGhostView(mValue);
                break;
            } 
            case "SpriteInfos":
            {
                if (mValue == false)
                {
                    api.ui.unloadUIComponent("SpriteInfos");
                    this.setOption("SpriteMove", false);
                } // end if
                break;
            } 
            case "SpriteMove":
            {
                if (mValue == false)
                {
                    api.gfx.clearZoneLayer("move");
                }
                else if (this.loadValue("SpriteInfos") == false)
                {
                    this.setOption("SpriteInfos", true);
                } // end else if
                break;
            } 
            case "MapInfos":
            {
                if (mValue == true)
                {
                    api.ui.loadUIComponent("MapInfos", "MapInfos", undefined, {bForceLoad: true});
                }
                else
                {
                    api.ui.unloadUIComponent("MapInfos");
                } // end else if
                break;
            } 
            case "AutoHideSmiley":
            {
                break;
            } 
            case "StringCourse":
            {
                if (mValue == false)
                {
                    api.ui.unloadUIComponent("StringCourse");
                } // end if
                break;
            } 
            case "PointsOverHead":
            case "ChatEffects":
            case "CreaturesMode":
            case "GuildMessageSound":
            case "StartTurnSound":
            case "BannerShortcuts":
            case "TipsOnStart":
            case "DebugSizeIndex":
            {
                break;
            } 
            case "Buff":
            {
                if (mValue)
                {
                    api.ui.loadUIComponent("Buff", "Buff");
                }
                else
                {
                    api.ui.unloadUIComponent("Buff");
                } // end else if
                break;
            } 
            case "DisplayStyle":
            {
                api.kernel.setDisplayStyle(mValue);
                break;
            } 
        } // End of switch
        return (true);
    } // End of the function
    static var DEFAULT_VALUES = {loaded: true, Grid: false, Transparency: false, SpriteInfos: true, SpriteMove: false, MapInfos: false, AutoHideSmileys: true, StringCourse: true, PointsOverHead: true, ChatEffects: true, CreaturesMode: 20, Buff: true, GuildMessageSound: false, BannerShortcuts: false, StartTurnSound: true, TipsOnStart: true, DisplayStyle: "normal", DebugSizeIndex: 0};
} // End of Class
#endinitclip
