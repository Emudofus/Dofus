// Action script...

// [Initial MovieClip Action of sprite 20897]
#initclip 162
if (!dofus.managers.OptionsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.OptionsManager = function (oAPI)
    {
        super();
        dofus.managers.OptionsManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.OptionsManager = function (oAPI)
    {
        super();
        dofus.managers.OptionsManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.OptionsManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        mx.events.EventDispatcher.initialize(this);
        this._so = _global[dofus.Constants.GLOBAL_SO_OPTIONS_NAME];
        if (this._so.data.loaded == undefined)
        {
            this._so.clear();
        } // end if
        for (var k in dofus.managers.OptionsManager.DEFAULT_VALUES)
        {
            if (this._so.data[k] == undefined)
            {
                this._so.data[k] = dofus.managers.OptionsManager.DEFAULT_VALUES[k];
            } // end if
        } // end of for...in
        this._so.flush();
    };
    _loc1.loadDefault = function ()
    {
        var _loc2 = this._so.data.language;
        this._so.clear();
        for (var k in dofus.managers.OptionsManager.DEFAULT_VALUES)
        {
            if (k == "ShortcutSetDefault")
            {
                this.setOption(k, this.api.kernel.KeyManager.getCurrentDefaultSet());
                continue;
            } // end if
            this.setOption(k, dofus.managers.OptionsManager.DEFAULT_VALUES[k]);
        } // end of for...in
        this._so.data.language = _loc2;
    };
    _loc1.setOption = function (sKey, mValue)
    {
        var _loc4 = this.saveValue(sKey, mValue);
        if (this.applyOption(sKey, _loc4))
        {
            this.dispatchEvent({type: "optionChanged", key: sKey, value: _loc4});
        } // end if
    };
    _loc1.getOption = function (sKey)
    {
        return (this.loadValue(sKey));
    };
    _loc1.applyAllOptions = function ()
    {
        var _loc2 = this._so.data;
        for (var k in _loc2)
        {
            this.applyOption(k, _loc2[k]);
        } // end of for...in
    };
    _loc1.saveValue = function (sKey, mValue)
    {
        var _loc4 = this._so.data;
        if (mValue == undefined)
        {
            if (typeof(_loc4[sKey]) == "boolean")
            {
                _loc4[sKey] = !_loc4[sKey];
            }
            else
            {
                _loc4[sKey] = true;
            } // end else if
        }
        else
        {
            _loc4[sKey] = mValue;
        } // end else if
        this._so.flush();
        return (_loc4[sKey]);
    };
    _loc1.loadValue = function (sKey)
    {
        return (this._so.data[sKey]);
    };
    _loc1.applyOption = function (sKey, mValue)
    {
        switch (sKey)
        {
            case "Grid":
            {
                if (mValue == true)
                {
                    this.api.gfx.drawGrid();
                }
                else
                {
                    this.api.gfx.removeGrid();
                } // end else if
                break;
            } 
            case "Transparency":
            {
                this.api.gfx.setSpriteGhostView(mValue);
                break;
            } 
            case "SpriteInfos":
            {
                if (mValue == false)
                {
                    this.api.ui.unloadUIComponent("SpriteInfos");
                    this.setOption("SpriteMove", false);
                } // end if
                break;
            } 
            case "SpriteMove":
            {
                if (mValue == false)
                {
                    this.api.gfx.clearZoneLayer("move");
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
                    this.api.ui.loadUIComponent("MapInfos", "MapInfos", undefined, {bForceLoad: true});
                }
                else
                {
                    this.api.ui.unloadUIComponent("MapInfos");
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
                    this.api.ui.unloadUIComponent("StringCourse");
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
            case "ServerPortIndex":
            case "ViewAllMonsterInGroup":
            {
                break;
            } 
            case "Buff":
            {
                if (mValue)
                {
                    this.api.ui.loadUIComponent("Buff", "Buff");
                }
                else
                {
                    this.api.ui.unloadUIComponent("Buff");
                } // end else if
                break;
            } 
            case "DisplayStyle":
            {
                this.api.kernel.setDisplayStyle(mValue);
                break;
            } 
            case "DefaultQuality":
            {
                this.api.kernel.setQuality(mValue);
                break;
            } 
            case "MovableBar":
            {
                this.api.ui.getUIComponent("Banner").displayMovableBar(mValue && (this.api.datacenter.Game.isFight || !this.getOption("HideSpellBar")));
                break;
            } 
            case "HideSpellBar":
            {
                this.api.ui.getUIComponent("Banner").displayMovableBar(this.getOption("MovableBar") && (this.api.datacenter.Game.isFight || !mValue));
                break;
            } 
            case "MovableBarSize":
            {
                this.api.ui.getUIComponent("Banner").setMovableBarSize(mValue);
                break;
            } 
            case "ShortcutSet":
            {
                this.api.kernel.KeyManager.onSetChange(mValue);
                break;
            } 
            case "CharacterPreview":
            {
                this.api.ui.getUIComponent("Inventory").showCharacterPreview(mValue);
                break;
            } 
            case "AudioMusicVol":
            {
                this.api.kernel.AudioManager.musicVolume = mValue;
                break;
            } 
            case "AudioEffectVol":
            {
                this.api.kernel.AudioManager.effectVolume = mValue;
                break;
            } 
            case "AudioEnvVol":
            {
                this.api.kernel.AudioManager.environmentVolume = mValue;
                break;
            } 
            case "AudioMusicMute":
            {
                this.api.kernel.AudioManager.musicMute = mValue;
                break;
            } 
            case "AudioEffectMute":
            {
                this.api.kernel.AudioManager.effectMute = mValue;
                break;
            } 
            case "AudioEnvMute":
            {
                this.api.kernel.AudioManager.environmentMute = mValue;
                break;
            } 
            case "TimestampInChat":
            {
                this.api.kernel.ChatManager.refresh();
                break;
            } 
        } // End of switch
        return (true);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.OptionsManager = function (oAPI)
    {
        super();
        dofus.managers.OptionsManager._sSelf = this;
        this.initialize(oAPI);
    }).DEFAULT_VALUES = {loaded: true, Grid: false, Transparency: false, SpriteInfos: true, SpriteMove: false, MapInfos: false, AutoHideSmileys: false, StringCourse: true, PointsOverHead: true, ChatEffects: true, CreaturesMode: 50, Buff: true, GuildMessageSound: false, BannerShortcuts: false, StartTurnSound: true, TipsOnStart: true, DisplayStyle: "normal", DebugSizeIndex: 0, ServerPortIndex: 0, MovableBar: false, ViewAllMonsterInGroup: true, MovableBarSize: 5, ShortcutSet: 1, ShortcutSetDefault: 1, CharacterPreview: true, MapFilters: [0, 1, 0, 1], Aura: true, AudioMusicVol: 60, AudioEffectVol: 100, AudioEnvVol: 60, AudioMusicMute: false, AudioEffectMute: false, AudioEnvMute: false, FloatingTipsCoord: new com.ankamagames.types.Point(415, 30), DisplayingFreshTips: true, CensorshipFilter: true, BigStoreSellFilter: false, RememberAccountName: false, LastAccountNameUsed: "", DefaultQuality: "high", ConquestFilter: -2, FightGroupAutoLock: false, BannerIllustrationMode: "artwork", AskForWrongCraft: true, AdvancedLineOfSight: false, RemindTurnTime: true, HideSpellBar: false, SeeAllSpell: true, UseSpeakingItems: true, ConfirmDropItem: true, TimestampInChat: false, ViewDicesDammages: false};
    (_global.dofus.managers.OptionsManager = function (oAPI)
    {
        super();
        dofus.managers.OptionsManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
