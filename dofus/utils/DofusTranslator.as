// Action script...

// [Initial MovieClip Action of sprite 20766]
#initclip 31
if (!dofus.utils.DofusTranslator)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.DofusTranslator = function ()
    {
        super();
    }).prototype;
    _loc1.getLangVersion = function ()
    {
        return (Number(this.getValueFromSOLang("VERSION")));
    };
    _loc1.getXtraVersion = function ()
    {
        return (Number(this.getValueFromSOXtra("VERSION")));
    };
    _loc1.getText = function (sKey, aParams)
    {
        if (aParams == undefined)
        {
            aParams = new Array();
        } // end if
        var _loc4 = new Array();
        var _loc5 = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < aParams.length)
        {
            _loc4.push("%" + (_loc6 + 1));
            _loc5.push(aParams[_loc6]);
        } // end while
        var _loc7 = this.getValueFromSOLang(sKey);
        if (_loc7 == "" || _loc7 == undefined)
        {
            return ("!" + sKey + "!");
        } // end if
        return (new ank.utils.ExtendedString(_loc7).replace(_loc4, _loc5));
    };
    _loc1.getConfigText = function (sKey)
    {
        var _loc3 = this.getValueFromSOLang("C")[sKey];
        if (typeof(_loc3) == "string")
        {
            var _loc4 = _loc3;
            var _loc5 = new ank.utils.ExtendedString(_loc4);
            return (_loc5.replace(["%CMNT%", "%CMNTT%"], [this.api.datacenter.Basics.aks_community_id, this.api.datacenter.Basics.aks_detected_country.toLowerCase()]));
        }
        else
        {
            return (_loc3);
        } // end else if
    };
    _loc1.getAllMapsInfos = function ()
    {
        return (this.getValueFromSOXtra("MA").m);
    };
    _loc1.getMapMaxChallenge = function (nMapID)
    {
        var _loc3 = this.getValueFromSOXtra("MA").m[nMapID].c;
        if (_loc3 == undefined || _global.isNaN(_loc3))
        {
            return (dofus.Constants.MAX_PLAYERS_IN_CHALLENGE);
        } // end if
        return (_loc3);
    };
    _loc1.getMapMaxTeam = function (nMapID)
    {
        var _loc3 = this.getValueFromSOXtra("MA").m[nMapID].t;
        if (_loc3 == undefined || _global.isNaN(_loc3))
        {
            return (dofus.Constants.MAX_PLAYERS_IN_TEAM);
        } // end if
        return (_loc3);
    };
    _loc1.getMapText = function (sKey)
    {
        return (this.getValueFromSOXtra("MA").m[sKey]);
    };
    _loc1.getMapAreas = function ()
    {
        return (this.getValueFromSOXtra("MA").a);
    };
    _loc1.getMapSuperAreaText = function (sKey)
    {
        return (this.getValueFromSOXtra("MA").sua[sKey]);
    };
    _loc1.getMapAreaText = function (sKey)
    {
        return (this.getValueFromSOXtra("MA").a[sKey]);
    };
    _loc1.getMapSubAreaText = function (sKey)
    {
        return (this.getValueFromSOXtra("MA").sa[sKey]);
    };
    _loc1.getMapAreaInfos = function (nSubAreaID)
    {
        var _loc3 = this.getValueFromSOXtra("MA").sa[nSubAreaID];
        var _loc4 = this.getValueFromSOXtra("MA").a[_loc3.a];
        var _loc5 = this.getValueFromSOXtra("MA").a[_loc4.sua];
        return ({superareaID: _loc4.sua, superarea: _loc5, areaID: _loc3.a, area: _loc4, subArea: _loc3});
    };
    _loc1.getItemSetText = function (nKey)
    {
        return (this.getValueFromSOXtra("IS")[nKey]);
    };
    _loc1.getItemUnicText = function (nKey)
    {
        return (this.getValueFromSOXtra("I").u[nKey]);
    };
    _loc1.getItemUnics = function ()
    {
        return (this.getValueFromSOXtra("I").u);
    };
    _loc1.getItemUnicStringText = function ()
    {
        return (this.getValueFromSOXtra("I").us);
    };
    _loc1.getItemTypeText = function (nTypeID)
    {
        return (this.getValueFromSOXtra("I").t[nTypeID]);
    };
    _loc1.getItemSuperTypeText = function (nSuperTypeID)
    {
        return (this.getValueFromSOXtra("I").st[nSuperTypeID]);
    };
    _loc1.getAllItemTypes = function ()
    {
        return (this.getValueFromSOXtra("I").t);
    };
    _loc1.getSlotsFromSuperType = function (nSuperTypeID)
    {
        return (this.getValueFromSOXtra("I").ss[nSuperTypeID]);
    };
    _loc1.getInteractiveObjectDataByGfxText = function (nKey)
    {
        return (this.getInteractiveObjectDataText(this.getValueFromSOXtra("IO").g[nKey]));
    };
    _loc1.getInteractiveObjectDataText = function (nKey)
    {
        return (this.getValueFromSOXtra("IO").d[nKey]);
    };
    _loc1.getHouseText = function (nID)
    {
        return (this.getValueFromSOXtra("H").h[nID]);
    };
    _loc1.getHousesMapText = function (nMapID)
    {
        return (this.getValueFromSOXtra("H").m[nMapID]);
    };
    _loc1.getHousesDoorText = function (nMapID, nCellNum)
    {
        return (this.getValueFromSOXtra("H").d[nMapID]["c" + nCellNum]);
    };
    _loc1.getHousesIndoorSkillsText = function ()
    {
        return (this.getValueFromSOXtra("H").ids);
    };
    _loc1.getDungeonText = function (nID)
    {
        return (this.getValueFromSOXtra("DU")[nID]);
    };
    _loc1.getSpellText = function (nSpellID)
    {
        return (this.getValueFromSOXtra("S")[nSpellID]);
    };
    _loc1.getEffectText = function (nEffectID)
    {
        return (this.getValueFromSOXtra("E")[nEffectID]);
    };
    _loc1.getBoostedDamagingEffects = function ()
    {
        return (this.getValueFromSOXtra("EDMG"));
    };
    _loc1.getBoostedHealingEffects = function ()
    {
        return (this.getValueFromSOXtra("EHEL"));
    };
    _loc1.getJobText = function (nJobID)
    {
        return (this.getValueFromSOXtra("J")[nJobID]);
    };
    _loc1.getCraftText = function (nID)
    {
        return (this.getValueFromSOXtra("CR")[nID]);
    };
    _loc1.getAllCrafts = function ()
    {
        return (this.getValueFromSOXtra("CR"));
    };
    _loc1.getSkillText = function (nID)
    {
        return (this.getValueFromSOXtra("SK")[nID]);
    };
    _loc1.getSkillForgemagus = function (nID)
    {
        return (Number(this.getValueFromSOXtra("SK")[nID].f));
    };
    _loc1.getDialogQuestionText = function (nQuestionID)
    {
        return (this.getValueFromSOXtra("D").q[nQuestionID]);
    };
    _loc1.getDialogResponseText = function (nAnswerID)
    {
        return (this.getValueFromSOXtra("D").a[nAnswerID]);
    };
    _loc1.getNonPlayableCharactersText = function (nNpcID)
    {
        return (this.getValueFromSOXtra("N").d[nNpcID]);
    };
    _loc1.getNonPlayableCharactersActionText = function (nActionID)
    {
        return (this.getValueFromSOXtra("N").a[nActionID]);
    };
    _loc1.getMonstersText = function (nMonsterID)
    {
        return (this.getValueFromSOXtra("M")[nMonsterID]);
    };
    _loc1.getMonsters = function ()
    {
        return (this.getValueFromSOXtra("M"));
    };
    _loc1.getMonstersRaceText = function (nRaceMonsterID)
    {
        return (this.getValueFromSOXtra("MR")[nRaceMonsterID]);
    };
    _loc1.getMonstersRace = function ()
    {
        return (this.getValueFromSOXtra("MR"));
    };
    _loc1.getMonstersSuperRaceText = function (nSuperRaceMonsterID)
    {
        return (this.getValueFromSOXtra("MSR")[nSuperRaceMonsterID]);
    };
    _loc1.getMonstersSuperRace = function ()
    {
        return (this.getValueFromSOXtra("MSR"));
    };
    _loc1.getTimeZoneText = function ()
    {
        return (this.getValueFromSOXtra("T"));
    };
    _loc1.getClassText = function (nClassID)
    {
        return (this.getValueFromSOXtra("G")[nClassID]);
    };
    _loc1.getEmoteText = function (nEmoteID)
    {
        return (this.getValueFromSOXtra("EM")[nEmoteID]);
    };
    _loc1.getEmoteID = function (sEmoteShortcut)
    {
        var _loc3 = this.getValueFromSOXtra("EM");
        for (var k in _loc3)
        {
            if (_loc3[k].s == sEmoteShortcut)
            {
                return (Number(k));
            } // end if
        } // end of for...in
        return (null);
    };
    _loc1.getGuildBoosts = function (sCharacteristics)
    {
        return (this.getValueFromSOXtra("GU").b[sCharacteristics]);
    };
    _loc1.getGuildBoostsMax = function (sCharacteristics)
    {
        return (this.getValueFromSOXtra("GU").b[sCharacteristics + "m"]);
    };
    _loc1.getNameText = function (nID)
    {
        return (this.getValueFromSOXtra("NF").n[nID]);
    };
    _loc1.getFirstnameText = function (nID)
    {
        return (this.getValueFromSOXtra("NF").f[nID]);
    };
    _loc1.getFullNameText = function (aIDs)
    {
        aIDs[0] = _global.parseInt(aIDs[0], 36);
        aIDs[1] = _global.parseInt(aIDs[1], 36);
        return (this.getFirstnameText(aIDs[0]) + " " + this.getNameText(aIDs[1]));
    };
    _loc1.getRankInfos = function (nID)
    {
        return (this.getValueFromSOXtra("R")[nID]);
    };
    _loc1.getRanks = function (nID)
    {
        return (this.getValueFromSOXtra("R"));
    };
    _loc1.getAlignments = function ()
    {
        return (this.getValueFromSOXtra("A").a);
    };
    _loc1.getAlignment = function (nID)
    {
        return (this.getValueFromSOXtra("A").a[nID]);
    };
    _loc1.getAlignmentCanJoin = function (nIDa, nIDb)
    {
        return (this.getValueFromSOXtra("A").jo[nIDa][nIDb]);
    };
    _loc1.getAlignmentCanAttack = function (nIDa, nIDb)
    {
        return (this.getValueFromSOXtra("A").at[nIDa][nIDb]);
    };
    _loc1.getAlignmentSpecializations = function ()
    {
        return (this.getValueFromSOXtra("A").s);
    };
    _loc1.getAlignmentSpecialization = function (nID)
    {
        return (this.getValueFromSOXtra("A").s[nID]);
    };
    _loc1.getAlignmentOrder = function (nID)
    {
        return (this.getValueFromSOXtra("A").o[nID]);
    };
    _loc1.getAlignmentFeat = function (nID)
    {
        return (this.getValueFromSOXtra("A").f[nID]);
    };
    _loc1.getAlignmentFeatEffect = function (nID)
    {
        return (this.getValueFromSOXtra("A").fe[nID]);
    };
    _loc1.getAlignmentBalance = function ()
    {
        return (this.getValueFromSOXtra("A").b);
    };
    _loc1.getAlignmentCanViewPvpGain = function (nIDa, nIDb)
    {
        return (this.getValueFromSOXtra("A").g[nIDa][nIDb]);
    };
    _loc1.getTips = function ()
    {
        return (this.getValueFromSOXtra("TI"));
    };
    _loc1.getTip = function (nID)
    {
        return (this.getValueFromSOXtra("TI")[nID]);
    };
    _loc1.getKeyboardShortcutsCategories = function ()
    {
        return (this.getValueFromSOXtra("SSC"));
    };
    _loc1.getKeyboardShortcuts = function ()
    {
        return (this.getValueFromSOXtra("SH"));
    };
    _loc1.getKeyboardShortcutsSets = function ()
    {
        return (this.getValueFromSOXtra("SST"));
    };
    _loc1.getKeyboardShortcutsKeys = function (nSetID, sShortCut)
    {
        return (this.getValueFromSOXtra("SSK")[String(nSetID) + "|" + sShortCut]);
    };
    _loc1.getControlKeyString = function (nCtrlKeyCode)
    {
        switch (nCtrlKeyCode)
        {
            case 1:
            {
                return (this.getText("KEY_CONTROL") + "+");
            } 
            case 2:
            {
                return (this.getText("KEY_SHIFT") + "+");
            } 
            case 3:
            {
                return (this.getText("KEY_CONTROL") + "+" + this.getText("KEY_SHIFT") + "+");
            } 
        } // End of switch
        return ("");
    };
    _loc1.getKeyStringFromKeyCode = function (nKeyCode)
    {
        switch (nKeyCode)
        {
            case 112:
            {
                return (this.getText("KEY_F1"));
            } 
            case 113:
            {
                return (this.getText("KEY_F2"));
            } 
            case 114:
            {
                return (this.getText("KEY_F3"));
            } 
            case 115:
            {
                return (this.getText("KEY_F4"));
            } 
            case 116:
            {
                return (this.getText("KEY_F5"));
            } 
            case 117:
            {
                return (this.getText("KEY_F6"));
            } 
            case 118:
            {
                return (this.getText("KEY_F7"));
            } 
            case 119:
            {
                return (this.getText("KEY_F8"));
            } 
            case 120:
            {
                return (this.getText("KEY_F9"));
            } 
            case 121:
            {
                return (this.getText("KEY_F10"));
            } 
            case 122:
            {
                return (this.getText("KEY_F11"));
            } 
            case 123:
            {
                return (this.getText("KEY_F12"));
            } 
            case 145:
            {
                return (this.getText("KEY_SCROLL_LOCK"));
            } 
            case 19:
            {
                return (this.getText("KEY_PAUSE"));
            } 
            case 45:
            {
                return (this.getText("KEY_INSERT"));
            } 
            case 36:
            {
                return (this.getText("KEY_HOME"));
            } 
            case 33:
            {
                return (this.getText("KEY_PAGE_UP"));
            } 
            case 34:
            {
                return (this.getText("KEY_PAGE_DOWN"));
            } 
            case 35:
            {
                return (this.getText("KEY_END"));
            } 
            case 37:
            {
                return (this.getText("KEY_LEFT"));
            } 
            case 38:
            {
                return (this.getText("KEY_UP"));
            } 
            case 39:
            {
                return (this.getText("KEY_RIGHT"));
            } 
            case 40:
            {
                return (this.getText("KEY_DOWN"));
            } 
            case 27:
            {
                return (this.getText("KEY_ESCAPE"));
            } 
            case 8:
            {
                return (this.getText("KEY_BACKSPACE"));
            } 
            case 20:
            {
                return (this.getText("KEY_CAPS_LOCK"));
            } 
            case 13:
            {
                return (this.getText("KEY_ENTER"));
            } 
            case 32:
            {
                return (this.getText("KEY_SPACE"));
            } 
            case 46:
            {
                return (this.getText("KEY_DELETE"));
            } 
            case 144:
            {
                return (this.getText("KEY_NUM_LOCK"));
            } 
            case -1:
            {
                return (this.getText("KEY_UNDEFINED"));
            } 
        } // End of switch
        return ("(#" + String(nKeyCode) + ")");
    };
    _loc1.getDefaultConsoleShortcuts = function ()
    {
        return (this.getValueFromSOLang("CNS"));
    };
    _loc1.getServerInfos = function (nID)
    {
        return (this.getValueFromSOXtra("SR")[nID]);
    };
    _loc1.getServerPopulation = function (nID)
    {
        return (this.getValueFromSOXtra("SRP")[nID]);
    };
    _loc1.getServerPopulationWeight = function (nID)
    {
        return (Number(this.getValueFromSOXtra("SRPW")[nID]));
    };
    _loc1.getServerCommunities = function ()
    {
        return (this.getValueFromSOLang("COM"));
    };
    _loc1.getServerCommunity = function (nID)
    {
        return (this.getValueFromSOXtra("SRC")[nID].n);
    };
    _loc1.getServerCommunityDisplayed = function (nID)
    {
        return (this.getValueFromSOXtra("SRC")[nID].d);
    };
    _loc1.getServerSpecificTexts = function ()
    {
        return (this.getValueFromSOXtra("SRVT"));
    };
    _loc1.getServerSpecificText = function (nTextID, nServerID)
    {
        return (this.getValueFromSOXtra("SRVC")[nTextID + "|" + nServerID]);
    };
    _loc1.getQuestText = function (nID)
    {
        return (this.getValueFromSOXtra("Q").q[nID]);
    };
    _loc1.getQuestStepText = function (nID)
    {
        return (this.getValueFromSOXtra("Q").s[nID]);
    };
    _loc1.getQuestObjectiveText = function (nID)
    {
        return (this.getValueFromSOXtra("Q").o[nID]);
    };
    _loc1.getQuestObjectiveTypeText = function (nID)
    {
        return (this.getValueFromSOXtra("Q").t[nID]);
    };
    _loc1.getState = function (nID)
    {
        return (this.getValueFromSOXtra("ST")[nID]);
    };
    _loc1.getStateText = function (nID)
    {
        return (this.getValueFromSOXtra("ST")[nID].n);
    };
    _loc1.getGradeHonourPointsBounds = function (g)
    {
        var _loc3 = this.getValueFromSOXtra("PP").hp;
        return ({min: _loc3[g - 1], max: _loc3[g]});
    };
    _loc1.getMaxDisgracePoints = function ()
    {
        return (this.getValueFromSOXtra("PP").maxdp);
    };
    _loc1.getRankLongName = function (nSide, nRank)
    {
        return (this.getValueFromSOXtra("PP").grds[nSide][nRank].nl);
    };
    _loc1.getRankShortName = function (nSide, nRank)
    {
        return (this.getValueFromSOXtra("PP").grds[nSide][nRank].nc);
    };
    _loc1.getHintsByMapID = function (mapID)
    {
        return (this.getHintsBy("m", mapID));
    };
    _loc1.getHintsByCategory = function (categoryID)
    {
        return (this.getHintsBy("c", categoryID));
    };
    _loc1.getHintsBy = function (prop, value)
    {
        var _loc4 = this.getValueFromSOXtra("HI");
        var _loc5 = new Array();
        var _loc6 = 0;
        
        while (++_loc6, _loc6 < _loc4.length)
        {
            var _loc7 = _loc4[_loc6];
            if (_loc7[prop] == value)
            {
                _loc5.push(_loc7);
            } // end if
        } // end while
        return (_loc5);
    };
    _loc1.getHintsCategory = function (nID)
    {
        return (this.getValueFromSOXtra("HIC")[nID]);
    };
    _loc1.getHintsCategories = function ()
    {
        return (this.getValueFromSOXtra("HIC"));
    };
    _loc1.getMountText = function (nID)
    {
        return (this.getValueFromSOXtra("RI")[nID]);
    };
    _loc1.getMountCapacity = function (nID)
    {
        return (this.getValueFromSOXtra("RIA")[nID]);
    };
    _loc1.getKnownledgeBaseCategories = function ()
    {
        return (this.getValueFromSOXtra("KBC"));
    };
    _loc1.getKnownledgeBaseCategory = function (nID)
    {
        return (this.getValueFromSOXtra("KBC")[nID]);
    };
    _loc1.getKnownledgeBaseArticles = function ()
    {
        return (this.getValueFromSOXtra("KBA"));
    };
    _loc1.getKnownledgeBaseArticle = function (nID)
    {
        return (this.getValueFromSOXtra("KBA")[nID]);
    };
    _loc1.getKnownledgeBaseTriggers = function ()
    {
        return (this.getValueFromSOXtra("KBD"));
    };
    _loc1.getKnownledgeBaseTip = function (nTipID)
    {
        return (this.getValueFromSOXtra("KBT")[nTipID]);
    };
    _loc1.getMusicFromKeyname = function (sKeyName)
    {
        return (Number(this.getValueFromSOXtra("AUMC")[sKeyName]));
    };
    _loc1.getEffectFromKeyname = function (sKeyName)
    {
        return (Number(this.getValueFromSOXtra("AUEC")[sKeyName]));
    };
    _loc1.getEnvironmentFromKeyname = function (sKeyName)
    {
        return (Number(this.getValueFromSOXtra("AUAC")[sKeyName]));
    };
    _loc1.getMusic = function (nMusic)
    {
        return (this.getValueFromSOXtra("AUM")[nMusic]);
    };
    _loc1.getEffect = function (nEffect)
    {
        return (this.getValueFromSOXtra("AUE")[nEffect]);
    };
    _loc1.getEnvironment = function (nEnvironment)
    {
        return (this.getValueFromSOXtra("AUA")[nEnvironment]);
    };
    _loc1.getSubtitle = function (nTrailer, nIndex)
    {
        return (this.getValueFromSOXtra("SUB")[nTrailer][nIndex]);
    };
    _loc1.getTutorialText = function (nTextID)
    {
        return (this.getValueFromSOXtra("SCR")[nTextID]);
    };
    _loc1.getCensoredWords = function ()
    {
        return (this.getValueFromSOLang("CSR"));
    };
    _loc1.getAbuseReasons = function ()
    {
        return (this.getValueFromSOLang("ABR"));
    };
    _loc1.getSpeakingItemsTexts = function ()
    {
        return (this.getValueFromSOXtra("SIM"));
    };
    _loc1.getSpeakingItemsText = function (nID)
    {
        return (this.getValueFromSOXtra("SIM")[nID]);
    };
    _loc1.getSpeakingItemsTriggers = function ()
    {
        return (this.getValueFromSOXtra("SIT"));
    };
    _loc1.getSpeakingItemsTrigger = function (nID)
    {
        return (this.getValueFromSOXtra("SIT")[nID]);
    };
    _loc1.getFightChallenge = function (nID)
    {
        return (this.getValueFromSOXtra("FC")[nID]);
    };
    _loc1.getTitle = function (nID)
    {
        return (this.getValueFromSOXtra("PT")[nID]);
    };
    _loc1.getLangFileSize = function (sLangFile)
    {
        var _loc3 = new String();
        if (sLangFile.toUpperCase() == "LANG")
        {
            _loc3 = dofus.Constants.GLOBAL_SO_LANG_NAME;
        }
        else if (sLangFile.toUpperCase() == "TOTAL")
        {
            var _loc4 = this.getLangFileSize("lang");
            var _loc5 = _global.API.lang.getConfigText("XTRA_FILE");
            var _loc6 = 0;
            
            while (++_loc6, _loc6 < _loc5.length)
            {
                _loc4 = _loc4 + this.getLangFileSize(_loc5[_loc6]);
            } // end while
            return (_loc4);
        }
        else
        {
            _loc3 = dofus.Constants.GLOBAL_SO_XTRA_NAME;
        } // end else if
        var _loc7 = _global[_loc3].data.WEIGHTS[sLangFile.toUpperCase()];
        if (_loc7 == undefined || _global.isNaN(_loc7))
        {
            return (0);
        } // end if
        return (_loc7);
    };
    _loc1.fetchString = function (s)
    {
        var _loc3 = new ank.utils.ExtendedString(s);
        if (this.fetchIn == undefined || (this.fetchOut == undefined || this._nLastServerID != this.api.datacenter.Basics.aks_current_server.id))
        {
            this.fetchIn = new Array();
            this.fetchOut = new Array();
            var _loc4 = this.getServerSpecificTexts();
            this._nLastServerID = this.api.datacenter.Basics.aks_current_server.id;
            for (var i in _loc4)
            {
                var _loc5 = this.getServerSpecificText(Number(i), this._nLastServerID);
                if (_loc5 == undefined)
                {
                    _loc5 = _loc4[i].d;
                } // end if
                this.fetchIn.push("`SRVT:" + _loc4[i].l + "`");
                this.fetchOut.push(_loc5);
            } // end of for...in
        } // end if
        return (_loc3.replace(this.fetchIn, this.fetchOut));
    };
    _loc1.getValueFromSOLang = function (sKey)
    {
        return (_global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[sKey]);
    };
    _loc1.getValueFromSOXtra = function (sKey)
    {
        var _loc3 = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey];
        if (_loc3 == undefined)
        {
            _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey] = ank.utils.SharedObjectFix.getLocal(dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey);
            _loc3 = _global[dofus.Constants.XTRA_SHAREDOBJECT_NAME + "_" + sKey];
        } // end if
        return (_loc3.data[sKey]);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
