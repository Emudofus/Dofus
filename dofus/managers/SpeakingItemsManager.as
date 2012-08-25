// Action script...

// [Initial MovieClip Action of sprite 20662]
#initclip 183
if (!dofus.managers.SpeakingItemsManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.SpeakingItemsManager._sSelf);
    };
    _loc1.initialize = function (oAPI)
    {
        super.initialize(oAPI);
        mx.events.EventDispatcher.initialize(this);
        this.generateNextMsgCount(true);
    };
    _loc1.__get__nextMsgDelay = function ()
    {
        return (this._nNextMessageCount);
    };
    _loc1.triggerPrivateEvent = function (sEvent)
    {
        this.api.kernel.AudioManager.playSound(sEvent);
    };
    _loc1.triggerEvent = function (nEvent)
    {
        if (nEvent == dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT)
        {
            ank.utils.Timer.removeTimer(this, "SpeakingItemsManager", dofus.managers.SpeakingItemsManager._nTimer);
            ank.utils.Timer.setTimer(this, "SpeakingItemsManager", this, this.triggerEvent, dofus.managers.SpeakingItemsManager.MINUTE_DELAY, [dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_MINUTE], true);
        } // end if
        if (!this.api.kernel.OptionsManager.getOption("UseSpeakingItems"))
        {
            return;
        } // end if
        this.updateEquipedSpeakingItems();
        if (this._eaItems.length)
        {
            var _loc3 = this._eaItems[Math.floor(Math.random() * this._eaItems.length)];
        }
        else
        {
            return;
        } // end else if
        --this._nNextMessageCount;
        this._nNextMessageCount = this._nNextMessageCount - (this._eaItems.length - 1) / 4;
        if (this._nNextMessageCount <= 0)
        {
            var _loc4 = this.api.lang.getSpeakingItemsTrigger(nEvent)[_loc3.mood];
            if (_loc4)
            {
                var _loc6 = new Array();
                var _loc7 = 0;
                
                while (++_loc7, _loc7 < _loc4.length)
                {
                    var _loc5 = this.api.lang.getSpeakingItemsText(_loc4[_loc7]);
                    if (_loc5.l > _loc3.maxSkin)
                    {
                        continue;
                    } // end if
                    if (_loc5.r != undefined && _loc5.r != "")
                    {
                        var _loc8 = _loc5.r.split(",");
                        var _loc9 = false;
                        var _loc10 = 0;
                        
                        while (++_loc10, _loc10 < _loc8.length)
                        {
                            if (_loc8[_loc10] == _loc3.realUnicId)
                            {
                                _loc9 = true;
                                break;
                            } // end if
                        } // end while
                        if (!_loc9)
                        {
                            continue;
                        } // end if
                    } // end if
                    if (_loc5.m == undefined)
                    {
                        continue;
                    } // end if
                    if (_loc5.p == undefined)
                    {
                        continue;
                    } // end if
                    _loc6.push(_loc4[_loc7]);
                } // end while
                var _loc11 = false;
                var _loc13 = 10;
                var _loc14 = this.api.lang.getConfigText("SPEAKING_ITEMS_MAX_TEXT_ID");
                while (!_loc11 && (--_loc13 && _loc6.length))
                {
                    var _loc12 = _loc6[Math.floor(Math.random() * _loc6.length)];
                    if (_loc14 != -1 && _loc12 > _loc14)
                    {
                        continue;
                    } // end if
                    _loc5 = this.api.lang.getSpeakingItemsText(_loc12);
                    if (Math.random() < _loc5.p)
                    {
                        _loc11 = true;
                    } // end if
                } // end while
                if (!_loc11)
                {
                    return;
                } // end if
                if (_loc5.s != -1 && !_global.isNaN(_loc5.s))
                {
                    var _loc15 = Math.floor(Math.random() * 3);
                }
                else
                {
                    _loc15 = 1;
                } // end else if
                if ((_loc15 == 0 || _loc15 == 2) && this.api.lang.getConfigText("SPEAKING_ITEMS_USE_SOUND"))
                {
                    this.api.kernel.AudioManager.playSound("SPEAKING_ITEMS_" + _loc5.s);
                } // end if
                if (_loc15 == 1 || _loc15 == 2)
                {
                    var _loc16 = this.api.lang.getConfigText("SPEAKING_ITEMS_CHAT_PROBA");
                    if (Math.random() * _loc16 <= 1 && this.api.datacenter.Player.canChatToAll)
                    {
                        this.api.network.Chat.send("**" + (_loc12 + this.api.datacenter.Player.ID) + "**", "*");
                    }
                    else
                    {
                        this.api.kernel.showMessage(undefined, _loc3.name + " : " + _loc5.m, "WHISP_CHAT");
                    } // end if
                } // end else if
                this.generateNextMsgCount();
            } // end if
        } // end if
    };
    _loc1.generateNextMsgCount = function (bNoMin)
    {
        var _loc3 = this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT");
        var _loc4 = _loc3 * this.api.lang.getConfigText("SPEAKING_ITEMS_MSG_COUNT_DELTA");
        if (bNoMin)
        {
            this._nNextMessageCount = Math.floor(_loc3 * Math.random());
        }
        else
        {
            this._nNextMessageCount = _loc3 + Math.floor(2 * _loc4 * Math.random() - _loc4 / 2);
        } // end else if
    };
    _loc1.updateEquipedSpeakingItems = function ()
    {
        var _loc2 = this.api.datacenter.Player.Inventory;
        var _loc3 = new ank.utils.ExtendedArray();
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc2.length)
        {
            if (_loc2[_loc4].isSpeakingItem && _loc2[_loc4].position != -1)
            {
                _loc3.push(_loc2[_loc4]);
            } // end if
        } // end while
        this._eaItems = _loc3;
    };
    _loc1.addProperty("nextMsgDelay", _loc1.__get__nextMsgDelay, function ()
    {
    });
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    })._sSelf = null;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).MINUTE_DELAY = 1000 * 60;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_MINUTE = 1;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_AGRESS = 2;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_AGRESSED = 3;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_KILL_ENEMY = 4;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_KILLED_BY_ENEMY = 5;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CC_OWNER = 6;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_EC_OWNER = 7;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_FIGHT_WON = 8;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_FIGHT_LOST = 9;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_NEW_ENEMY_WEAK = 10;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_NEW_ENEMY_STRONG = 11;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CC_ALLIED = 12;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_EC_ALLIED = 13;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CC_ENEMY = 14;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_EC_ENEMY = 15;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_ON_CONNECT = 16;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_KILL_ALLY = 17;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_KILLED_BY_ALLY = 18;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_GREAT_DROP = 19;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_KILLED_HIMSELF = 20;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CRAFT_OK = 21;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CRAFT_KO = 22;
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_LEVEL_UP = "SPEAK_TRIGGER_LEVEL_UP";
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_FEED = "SPEAK_TRIGGER_FEED";
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_ASSOCIATE = "SPEAK_TRIGGER_ASSOCIATE";
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_DISSOCIATE = "SPEAK_TRIGGER_DISSOCIATE";
    (_global.dofus.managers.SpeakingItemsManager = function (oAPI)
    {
        super();
        dofus.managers.SpeakingItemsManager._sSelf = this;
        this.initialize(oAPI);
    }).SPEAK_TRIGGER_CHANGE_SKIN = "SPEAK_TRIGGER_CHANGE_SKIN";
} // end if
#endinitclip
