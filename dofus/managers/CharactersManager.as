// Action script...

// [Initial MovieClip Action of sprite 831]
#initclip 43
class dofus.managers.CharactersManager extends dofus.utils.ApiElement
{
    var api;
    function CharactersManager(oAPI)
    {
        super.initialize(oAPI);
    } // End of the function
    function setLocalPlayerData(nID, sName, oData)
    {
        var _loc5 = api.datacenter.Player;
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
        for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
        {
            var _loc3 = _loc6[_loc2];
            if (_loc3.length != 0)
            {
                var _loc4 = this.getItemObjectFromData(_loc3);
                if (_loc4 != undefined)
                {
                    _loc5.addItem(_loc4);
                } // end if
            } // end if
        } // end of for
        _loc5.updateCloseCombat();
    } // End of the function
    function createCharacter(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.Character(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = Number(oData.cell);
        _loc3.name = sName;
        _loc3.Guild = Number(oData.spriteType);
        _loc3.Level = Number(oData.level);
        _loc3.Sex = oData.sex != undefined ? (oData.sex) : (1);
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        _loc3.Aura = oData.aura != undefined ? (oData.aura) : (0);
        _loc3.Merchant = oData.merchant == "1" ? (true) : (false);
        _loc3.serverID = Number(oData.serverID);
        this.setSpriteAlignment(_loc3, oData.alignment);
        this.setSpriteAccessories(_loc3, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc3.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc3.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MPinit = oData.MP;
        } // end if
        if (oData.resistances != undefined)
        {
            _loc3.resistances = oData.resistances;
        } // end if
        _loc3.Team = oData.team == undefined ? (null) : (oData.team);
        if (oData.emote != undefined && oData.emote.length != 0)
        {
            _loc3.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
            if (oData.emoteTimer != undefined && oData.emote.length != 0)
            {
                _loc3.startAnimationTimer = oData.emoteTimer;
            } // end if
            _loc3.startAnimation = "EmoteStatic" + oData.emote;
        } // end if
        if (oData.guildName != undefined)
        {
            _loc3.guildName = oData.guildName;
        } // end if
        this.setSpriteGuildEmblem(_loc3, oData.emblem);
        if (oData.restrictions != undefined)
        {
            _loc3.restrictions = parseInt(oData.restrictions, 36);
        } // end if
        if (sID == api.datacenter.Player.ID)
        {
            api.datacenter.Player.alignment = new dofus.datacenter.Alignment(_loc3.alignment.index, _loc3.alignment.value);
        } // end if
        return (_loc3);
    } // End of the function
    function createCreature(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.Creature(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.name = sName;
        _loc3.powerLevel = oData.powerLevel;
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc3, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc3.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc3.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MPinit = oData.MP;
        } // end if
        _loc3.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc3);
    } // End of the function
    function createMonster(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.Monster(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.name = sName;
        _loc3.powerLevel = oData.powerLevel;
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc3, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc3.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc3.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MPinit = oData.MP;
        } // end if
        _loc3.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc3);
    } // End of the function
    function createMonsterGroup(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.MonsterGroup(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.name = sName;
        _loc3.Level = oData.level;
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc3, oData.accessories);
        return (_loc3);
    } // End of the function
    function createNonPlayableCharacter(sID, nUnicID, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.NonPlayableCharacter(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.unicID = nUnicID;
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc3, oData.accessories);
        return (_loc3);
    } // End of the function
    function createOfflineCharacter(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.OfflineCharacter(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.name = sName;
        _loc3.color1 = oData.color1 == -1 ? (oData.color1) : (Number("0x" + oData.color1));
        _loc3.color2 = oData.color2 == -1 ? (oData.color2) : (Number("0x" + oData.color2));
        _loc3.color3 = oData.color3 == -1 ? (oData.color3) : (Number("0x" + oData.color3));
        this.setSpriteAccessories(_loc3, oData.accessories);
        if (oData.guildName != undefined)
        {
            _loc3.guildName = oData.guildName;
        } // end if
        this.setSpriteGuildEmblem(_loc3, oData.emblem);
        _loc3.offlineType = oData.offlineType;
        return (_loc3);
    } // End of the function
    function createTaxCollector(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.TaxCollector(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = oData.cell;
        _loc3.name = api.lang.getFullNameText(sName.split(","));
        _loc3.Level = oData.level;
        if (oData.guildName != undefined)
        {
            _loc3.guildName = oData.guildName;
        } // end if
        this.setSpriteGuildEmblem(_loc3, oData.emblem);
        if (oData.LP != undefined)
        {
            _loc3.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc3.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MPinit = oData.MP;
        } // end if
        _loc3.Team = oData.team == undefined ? (null) : (oData.team);
        return (_loc3);
    } // End of the function
    function createMutant(sID, sName, oData)
    {
        var _loc3 = api.datacenter.Sprites.getItemAt(sID);
        if (_loc3 == undefined)
        {
            _loc3 = new dofus.datacenter.Mutant(sID, ank.battlefield.mc.Sprite, dofus.Constants.CLIPS_PERSOS_PATH + oData.gfxID + ".swf", oData.cell, oData.dir, oData.gfxID);
            api.datacenter.Sprites.addItemAt(sID, _loc3);
        } // end if
        _loc3.GameActionsManager.init();
        _loc3.cellNum = Number(oData.cell);
        _loc3.name = sName;
        _loc3.Guild = Number(oData.spriteType);
        _loc3.powerLevel = Number(oData.powerLevel);
        _loc3.Sex = oData.sex != undefined ? (oData.sex) : (1);
        this.setSpriteAccessories(_loc3, oData.accessories);
        if (oData.LP != undefined)
        {
            _loc3.LP = oData.LP;
        } // end if
        if (oData.LP != undefined)
        {
            _loc3.LPmax = oData.LP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.AP = oData.AP;
        } // end if
        if (oData.AP != undefined)
        {
            _loc3.APinit = oData.AP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MP = oData.MP;
        } // end if
        if (oData.MP != undefined)
        {
            _loc3.MPinit = oData.MP;
        } // end if
        _loc3.Team = oData.team == undefined ? (null) : (oData.team);
        if (oData.emote != undefined && oData.emote.length != 0)
        {
            _loc3.direction = ank.battlefield.utils.Pathfinding.convertHeightToFourDirection(oData.dir);
            if (oData.emoteTimer != undefined && oData.emote.length != 0)
            {
                _loc3.startAnimationTimer = oData.emoteTimer;
            } // end if
            _loc3.startAnimation = "EmoteStatic" + oData.emote;
        } // end if
        return (_loc3);
    } // End of the function
    function getItemObjectFromData(sData)
    {
        if (sData.length == 0)
        {
            return (null);
        } // end if
        var _loc2 = sData.split("~");
        var _loc7 = parseInt(_loc2[0], 16);
        var _loc8 = parseInt(_loc2[1], 16);
        var _loc4 = parseInt(_loc2[2], 16);
        var _loc5 = _loc2[3].length == 0 ? (-1) : (parseInt(_loc2[3], 16));
        var _loc6 = _loc2[4];
        var _loc3 = new dofus.datacenter.Item(_loc7, _loc8, _loc4, _loc5, _loc6);
        _loc3.priceMultiplicator = api.lang.getConfigText("SELL_PRICE_MULTIPLICATOR");
        return (_loc3);
    } // End of the function
    function getSpellObjectFromData(sData)
    {
        var _loc1 = sData.split("~");
        var _loc4 = Number(_loc1[0]);
        var _loc3 = Number(_loc1[1]);
        var _loc5 = _loc1[2];
        var _loc2 = new dofus.datacenter.Spell(_loc4, _loc3, _loc5);
        return (_loc2);
    } // End of the function
    function getNameFromData(sData)
    {
        var _loc2 = new Object();
        var _loc3 = sData.split(",");
        if (_loc3.length == 2)
        {
            _loc2.name = api.lang.getFullNameText(_loc3);
            _loc2.type = "taxcollector";
        }
        else if (isNaN(Number(sData)))
        {
            _loc2.name = sData;
            _loc2.type = "player";
        }
        else
        {
            _loc2.name = api.lang.getMonstersText(Number(sData)).n;
            _loc2.type = "monster";
        } // end else if
        return (_loc2);
    } // End of the function
    function setSpriteAlignment(oSprite, sAlignment)
    {
        var _loc1 = sAlignment.split(",");
        var _loc2 = Number(_loc1[0]);
        var _loc3 = Number(_loc1[1]);
        oSprite.alignment = new dofus.datacenter.Alignment(_loc2, _loc3);
    } // End of the function
    function setSpriteAccessories(oSprite, sAccessories)
    {
        if (sAccessories.length != 0)
        {
            var _loc5 = new Array();
            var _loc4 = sAccessories.split(",");
            for (var _loc1 = 0; _loc1 < _loc4.length; ++_loc1)
            {
                var _loc2 = parseInt(_loc4[_loc1], 16);
                if (!isNaN(_loc2))
                {
                    var _loc3 = new dofus.datacenter.Accessory(_loc2);
                    _loc5[_loc1] = _loc3;
                } // end if
            } // end of for
            oSprite.accessories = _loc5;
        } // end if
    } // End of the function
    function setSpriteGuildEmblem(oSprite, sEmblem)
    {
        if (sEmblem != undefined)
        {
            var _loc2 = sEmblem.split(",");
            var _loc1 = new Object();
            _loc1.backID = parseInt(_loc2[0], 36);
            _loc1.backColor = parseInt(_loc2[1], 36);
            _loc1.upID = parseInt(_loc2[2], 36);
            _loc1.upColor = parseInt(_loc2[3], 36);
            oSprite.emblem = _loc1;
        } // end if
    } // End of the function
} // End of Class
#endinitclip
