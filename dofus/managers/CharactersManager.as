// Action script...

// [Initial MovieClip Action of sprite 20908]
#initclip 173
if (!dofus.managers.CharactersManager)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.managers)
    {
        _global.dofus.managers = new Object();
    } // end if
    var _loc1 = (_global.dofus.managers.CharactersManager = function (oAPI)
    {
        dofus.managers.CharactersManager._sSelf = this;
        super.initialize(oAPI);
    }).prototype;
    (_global.dofus.managers.CharactersManager = function (oAPI)
    {
        dofus.managers.CharactersManager._sSelf = this;
        super.initialize(oAPI);
    }).getInstance = function ()
    {
        return (dofus.managers.CharactersManager._sSelf);
    };
    _loc1.setLocalPlayerData = function (nID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Player;
        _loc5.clean();
        _loc5.ID = nID;
        _loc5.Name = sName;
        _loc5.Guild = oData.guild;
        _loc5.Level = oData.level;
        _loc5.Sex = oData.sex;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        var _loc6 = oData.items.split(";");
        var _loc7 = 0;
        
        while (++_loc7, _loc7 < _loc6.length)
        {
            var _loc8 = _loc6[_loc7];
            if (_loc8.length != 0)
            {
                var _loc9 = this.getItemObjectFromData(_loc8);
                if (_loc9 != undefined)
                {
                    _loc5.addItem(_loc9);
                } // end if
            } // end if
        } // end while
        _loc5.updateCloseCombat();
    };
    _loc1.createCharacter = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.Character(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID, oData.title);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = Number(oData.cell);
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.name = sName;
        _loc5.Guild = Number(oData.spriteType);
        _loc5.Level = Number(oData.level);
        _loc5.Sex = oData.sex != undefined ? (oData.sex) : (1);
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        _loc5.Aura = oData.aura != undefined ? (oData.aura) : (0);
        _loc5.Merchant = oData.merchant == "1" ? (true) : (false);
        _loc5.serverID = Number(oData.serverID);
        _loc5.alignment = oData.alignment;
        _loc5.rank = oData.rank;
        _loc5.mount = oData.mount;
        _loc5.isDead = oData.isDead == 1;
        _loc5.deathState = Number(oData.isDead);
        _loc5.deathCount = Number(oData.deathCount);
        _loc5.lvlMax = Number(oData.lvlMax);
        _loc5.pvpGain = Number(oData.pvpGain);
        this.setSpriteAccessories(_loc5, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc5.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc5.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MPinit = oData.MP;
        } // end if
        if (oData.resistances != undefined)
        {
            _loc5.resistances = oData.resistances;
        } // end if
        _loc5.Team = oData.team == undefined ? (null) : (oData.team);
        if (oData.emote != undefined && oData.emote.length != 0)
        {
            _loc5.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
            if (oData.emoteTimer != undefined && oData.emote.length != 0)
            {
                _loc5.startAnimationTimer = oData.emoteTimer;
            } // end if
            _loc5.startAnimation = "EmoteStatic" + oData.emote;
        } // end if
        if (oData.guildName != undefined)
        {
            _loc5.guildName = oData.guildName;
        } // end if
        _loc5.emblem = this.createGuildEmblem(oData.emblem);
        if (oData.restrictions != undefined)
        {
            _loc5.restrictions = _global.parseInt(oData.restrictions, 36);
        } // end if
        if (sID == this.api.datacenter.Player.ID)
        {
            if (!this.api.datacenter.Player.haveFakeAlignment)
            {
                this.api.datacenter.Player.alignment = _loc5.alignment.clone();
            } // end if
        } // end if
        return (_loc5);
    };
    _loc1.createCreature = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.Creature(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.name = sName;
        _loc5.powerLevel = oData.powerLevel;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.noFlip = oData.noFlip;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc5, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc5.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc5.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MPinit = oData.MP;
        } // end if
        if (oData.resistances != undefined)
        {
            _loc5.resistances = oData.resistances;
        } // end if
        if (oData.summoned != undefined)
        {
            _loc5.isSummoned = oData.summoned;
        } // end if
        _loc5.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc5);
    };
    _loc1.createMonster = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.Monster(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.name = sName;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.noFlip = oData.noFlip;
        _loc5.powerLevel = oData.powerLevel;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc5, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc5.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc5.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MPinit = oData.MP;
        } // end if
        if (oData.summoned != undefined)
        {
            _loc5.isSummoned = oData.summoned;
        } // end if
        _loc5.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc5);
    };
    _loc1.createMonsterGroup = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.MonsterGroup(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.bonusValue);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.name = sName;
        _loc5.Level = oData.level;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.noFlip = oData.noFlip;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc5, oData.accessories);
        return (_loc5);
    };
    _loc1.createNonPlayableCharacter = function (sID, nUnicID, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.NonPlayableCharacter(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID, oData.customArtwork);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.unicID = nUnicID;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc5, oData.accessories);
        if (oData.extraClipID >= 0)
        {
            _loc5.extraClipID = oData.extraClipID;
        } // end if
        return (_loc5);
    };
    _loc1.createOfflineCharacter = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.OfflineCharacter(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.name = sName;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc5.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc5.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc5, oData.accessories);
        if (oData.guildName != undefined)
        {
            _loc5.guildName = oData.guildName;
        } // end if
        _loc5.emblem = this.createGuildEmblem(oData.emblem);
        _loc5.offlineType = oData.offlineType;
        return (_loc5);
    };
    _loc1.createTaxCollector = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.TaxCollector(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.name = this.api.lang.getFullNameText(sName.split(","));
        _loc5.Level = oData.level;
        if (oData.guildName != undefined)
        {
            _loc5.guildName = oData.guildName;
        } // end if
        _loc5.emblem = this.createGuildEmblem(oData.emblem);
        if (oData.LP != undefined)
        {
            _loc5.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc5.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc5.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc5.MPinit = oData.MP;
        } // end if
        if (oData.resistances != undefined)
        {
            _loc5.resistances = oData.resistances;
        } // end if
        _loc5.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc5);
    };
    _loc1.createPrism = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.PrismSprite(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.linkedMonster = Number(sName);
        _loc5.Level = oData.level;
        _loc5.alignment = oData.alignment;
        return (_loc5);
    };
    _loc1.createParkMount = function (sID, sName, oData)
    {
        var _loc5 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc5 == undefined)
        {
            _loc5 = new dofus.datacenter.ParkMount(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID, oData.modelID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc5);
        } // end if
        _loc5.GameActionsManager.init();
        _loc5.cellNum = oData.cell;
        _loc5.name = sName;
        _loc5.scaleX = oData.scaleX;
        _loc5.scaleY = oData.scaleY;
        _loc5.ownerName = oData.ownerName;
        _loc5.level = oData.level;
        return (_loc5);
    };
    _loc1.createMutant = function (sID, oData)
    {
        var _loc4 = this.api.datacenter.Sprites.getItemAt(sID);
        if (_loc4 == undefined)
        {
            _loc4 = new dofus.datacenter.Mutant(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            this.api.datacenter.Sprites.addItemAt(sID, _loc4);
        } // end if
        _loc4.GameActionsManager.init();
        _loc4.scaleX = oData.scaleX;
        _loc4.scaleY = oData.scaleY;
        _loc4.cellNum = Number(oData.cell);
        _loc4.Guild = Number(oData.spriteType);
        _loc4.powerLevel = Number(oData.powerLevel);
        _loc4.Sex = oData.sex != undefined ? (oData.sex) : (1);
        _loc4.showIsPlayer = oData.showIsPlayer;
        _loc4.monsterID = oData.monsterID;
        _loc4.playerName = oData.playerName;
        this.setSpriteAccessories(_loc4, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc4.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc4.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc4.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc4.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc4.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc4.MPinit = oData.MP;
        } // end if
        _loc4.Team = oData.team == undefined ? (null) : (oData.team);
        if (oData.emote != undefined && oData.emote.length != 0)
        {
            _loc4.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
            if (oData.emoteTimer != undefined && oData.emote.length != 0)
            {
                _loc4.startAnimationTimer = oData.emoteTimer;
            } // end if
            _loc4.startAnimation = "EmoteStatic" + oData.emote;
        } // end if
        if (oData.restrictions != undefined)
        {
            _loc4.restrictions = _global.parseInt(oData.restrictions, 36);
        } // end if
        return (_loc4);
    };
    _loc1.getItemObjectFromData = function (sData)
    {
        if (sData.length == 0)
        {
            return (null);
        } // end if
        var _loc3 = sData.split("~");
        var _loc4 = _global.parseInt(_loc3[0], 16);
        var _loc5 = _global.parseInt(_loc3[1], 16);
        var _loc6 = _global.parseInt(_loc3[2], 16);
        var _loc7 = _loc3[3].length == 0 ? (-1) : (_global.parseInt(_loc3[3], 16));
        var _loc8 = _loc3[4];
        var _loc9 = new dofus.datacenter.Item(_loc4, _loc5, _loc6, _loc7, _loc8);
        _loc9.priceMultiplicator = this.api.lang.getConfigText("SELL_PRICE_MULTIPLICATOR");
        return (_loc9);
    };
    _loc1.getSpellObjectFromData = function (sData)
    {
        var _loc3 = sData.split("~");
        var _loc4 = Number(_loc3[0]);
        var _loc5 = Number(_loc3[1]);
        var _loc6 = _loc3[2];
        var _loc7 = new dofus.datacenter.Spell(_loc4, _loc5, _loc6);
        return (_loc7);
    };
    _loc1.getNameFromData = function (sData)
    {
        var _loc3 = new Object();
        var _loc4 = sData.split(",");
        if (_loc4.length == 2)
        {
            _loc3.name = this.api.lang.getFullNameText(_loc4);
            _loc3.type = "taxcollector";
        }
        else if (_global.isNaN(Number(sData)))
        {
            _loc3.name = sData;
            _loc3.type = "player";
        }
        else
        {
            _loc3.name = this.api.lang.getMonstersText(Number(sData)).n;
            _loc3.type = "monster";
        } // end else if
        return (_loc3);
    };
    _loc1.setSpriteAccessories = function (oSprite, sAccessories)
    {
        if (sAccessories.length != 0)
        {
            var _loc4 = new Array();
            var _loc5 = sAccessories.split(",");
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                if (_loc5[_loc6].indexOf("~") != -1)
                {
                    var _loc10 = _loc5[_loc6].split("~");
                    var _loc7 = _global.parseInt(_loc10[0], 16);
                    var _loc9 = _global.parseInt(_loc10[1]);
                    var _loc8 = _global.parseInt(_loc10[2]) - 1;
                }
                else
                {
                    _loc7 = _global.parseInt(_loc5[_loc6], 16);
                    _loc9 = undefined;
                    _loc8 = undefined;
                } // end else if
                if (!_global.isNaN(_loc7))
                {
                    var _loc11 = new dofus.datacenter.Accessory(_loc7, _loc9, _loc8);
                    _loc4[_loc6] = _loc11;
                } // end if
            } // end while
            oSprite.accessories = _loc4;
        } // end if
    };
    _loc1.createGuildEmblem = function (sEmblem)
    {
        if (sEmblem != undefined)
        {
            var _loc3 = sEmblem.split(",");
            var _loc4 = new Object();
            _loc4.backID = _global.parseInt(_loc3[0], 36);
            _loc4.backColor = _global.parseInt(_loc3[1], 36);
            _loc4.upID = _global.parseInt(_loc3[2], 36);
            _loc4.upColor = _global.parseInt(_loc3[3], 36);
            return (_loc4);
        } // end if
        return;
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.managers.CharactersManager = function (oAPI)
    {
        dofus.managers.CharactersManager._sSelf = this;
        super.initialize(oAPI);
    })._sSelf = null;
} // end if
#endinitclip
