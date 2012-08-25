// Action script...

// [Initial MovieClip Action of sprite 20702]
#initclip 223
if (!dofus.sounds.AudioEvents)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.sounds)
    {
        _global.dofus.sounds = new Object();
    } // end if
    var _loc1 = (_global.dofus.sounds.AudioEvents = function ()
    {
    }).prototype;
    (_global.dofus.sounds.AudioEvents = function ()
    {
    }).getInstance = function ()
    {
        if (dofus.sounds.AudioEvents.instance == null)
        {
            dofus.sounds.AudioEvents.instance = new dofus.sounds.AudioEvents();
        } // end if
        dofus.sounds.AudioEvents.api = _global.API;
        return (dofus.sounds.AudioEvents.instance);
    };
    _loc1.getAudioManager = function ()
    {
        return (dofus.sounds.AudioManager.getInstance());
    };
    _loc1.onGameStart = function (aMusicList)
    {
        if (aMusicList == undefined)
        {
            return;
        } // end if
        var _loc3 = Math.floor(Math.random() * aMusicList.length);
        this.getAudioManager().playMusic(aMusicList[_loc3], false, true);
    };
    _loc1.onGameEnd = function ()
    {
    };
    _loc1.onTurnStart = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TURN_START"));
        } // end if
    };
    _loc1.onGameInvitation = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
        } // end if
    };
    _loc1.onGameCriticalHit = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
        } // end if
    };
    _loc1.onGameCriticalMiss = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("COUP_CRITIQUE"));
        } // end if
    };
    _loc1.onBannerRoundButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
        } // end if
    };
    _loc1.onBannerChatButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
        } // end if
    };
    _loc1.onBannerSpellItemButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
        } // end if
    };
    _loc1.onBannerTimer = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("TAK"));
        } // end if
    };
    _loc1.onBannerSpellSelect = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
        } // end if
    };
    _loc1.onStatsJobBoostButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
        } // end if
    };
    _loc1.onSpellsBoostButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK2"));
        } // end if
    };
    _loc1.onInventoryFilterButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK3"));
        } // end if
    };
    _loc1.onMapButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK3"));
        } // end if
    };
    _loc1.onGuildButtonClick = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLICK"));
        } // end if
    };
    _loc1.onMapFlag = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("POSE2"));
        } // end if
    };
    _loc1.onChatWisper = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("BIP"));
        } // end if
    };
    _loc1.onTaxcollectorAttack = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("CLANG"));
        } // end if
    };
    _loc1.onError = function ()
    {
        if (dofus.sounds.AudioEvents.api.kernel.XTRA_LANG_FILES_LOADED)
        {
            this.getAudioManager().playEffect(dofus.sounds.AudioEvents.api.lang.getEffectFromKeyname("ERROR"));
        } // end if
    };
    _loc1.onEnterVillage = function ()
    {
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
