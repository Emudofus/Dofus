// Action script...

// [Initial MovieClip Action of sprite 975]
#initclip 189
class dofus.utils.DofusTranslator
{
    function DofusTranslator()
    {
    } // End of the function
    function getLangVersion()
    {
        return (this.getValueFromSOLang("VERSION"));
    } // End of the function
    function getXtraVersion()
    {
        return (this.getValueFromSOXtra("VERSION"));
    } // End of the function
    function getText(sKey, aParams)
    {
        if (aParams == undefined)
        {
            aParams = new Array();
        } // end if
        var _loc4 = new Array();
        var _loc5 = new Array();
        for (var _loc2 = 0; _loc2 < aParams.length; ++_loc2)
        {
            _loc4.push("%" + (_loc2 + 1));
            _loc5.push(aParams[_loc2]);
        } // end of for
        return (this.getValueFromSOLang(sKey).replace(_loc4, _loc5));
    } // End of the function
    function getConfigText(sKey)
    {
        return (this.getValueFromSOLang("C")[sKey]);
    } // End of the function
    function getAllMapsInfos()
    {
        return (this.getValueFromSOXtra("MA").m);
    } // End of the function
    function getMapText(sKey)
    {
        return (this.getValueFromSOXtra("MA").m[sKey]);
    } // End of the function
    function getMapAreas()
    {
        return (this.getValueFromSOXtra("MA").a);
    } // End of the function
    function getMapSuperAreaText(sKey)
    {
        return (this.getValueFromSOXtra("MA").sua[sKey]);
    } // End of the function
    function getMapAreaText(sKey)
    {
        return (this.getValueFromSOXtra("MA").a[sKey]);
    } // End of the function
    function getMapSubAreaText(sKey)
    {
        return (this.getValueFromSOXtra("MA").sa[sKey]);
    } // End of the function
    function getMapAreaInfos(nSubAreaID)
    {
        var _loc2 = this.getValueFromSOXtra("MA").sa[nSubAreaID];
        var _loc3 = this.getValueFromSOXtra("MA").a[_loc2.a];
        var _loc4 = this.getValueFromSOXtra("MA").a[_loc3.sua];
        return ({superareaID: _loc3.sua, superarea: _loc4, areaID: _loc2.a, area: _loc3, subArea: _loc2});
    } // End of the function
    function getItemSetText(nKey)
    {
        return (this.getValueFromSOXtra("IS")[nKey]);
    } // End of the function
    function getItemUnicText(nKey)
    {
        return (this.getValueFromSOXtra("I").u[nKey]);
    } // End of the function
    function getItemUnicStringText()
    {
        return (this.getValueFromSOXtra("I").us);
    } // End of the function
    function getItemTypeText(nTypeID)
    {
        return (this.getValueFromSOXtra("I").t[nTypeID]);
    } // End of the function
    function getItemSuperTypeText(nSuperTypeID)
    {
        return (this.getValueFromSOXtra("I").st[nSuperTypeID]);
    } // End of the function
    function getInteractiveObjectDataByGfxText(nKey)
    {
        return (this.getInteractiveObjectDataText(this.getValueFromSOXtra("IO").g[nKey]));
    } // End of the function
    function getInteractiveObjectDataText(nKey)
    {
        return (this.getValueFromSOXtra("IO").d[nKey]);
    } // End of the function
    function getHouseText(nID)
    {
        return (this.getValueFromSOXtra("H").h[nID]);
    } // End of the function
    function getHousesMapText(nMapID)
    {
        return (this.getValueFromSOXtra("H").m[nMapID]);
    } // End of the function
    function getHousesDoorText(nMapID, nCellNum)
    {
        return (this.getValueFromSOXtra("H").d[nMapID]["c" + nCellNum]);
    } // End of the function
    function getHousesIndoorSkillsText()
    {
        return (this.getValueFromSOXtra("H").ids);
    } // End of the function
    function getSpellText(nSpellID)
    {
        return (this.getValueFromSOXtra("S")[nSpellID]);
    } // End of the function
    function getEffectText(nEffectID)
    {
        return (this.getValueFromSOXtra("E")[nEffectID]);
    } // End of the function
    function getJobText(nJobID)
    {
        return (this.getValueFromSOXtra("J")[nJobID]);
    } // End of the function
    function getCraftText(nID)
    {
        return (this.getValueFromSOXtra("CR")[nID]);
    } // End of the function
    function getSkillText(nID)
    {
        return (this.getValueFromSOXtra("SK")[nID]);
    } // End of the function
    function getDialogQuestionText(nQuestionID)
    {
        return (this.getValueFromSOXtra("D").q[nQuestionID]);
    } // End of the function
    function getDialogResponseText(nAnswerID)
    {
        return (this.getValueFromSOXtra("D").a[nAnswerID]);
    } // End of the function
    function getNonPlayableCharactersText(nNpcID)
    {
        return (this.getValueFromSOXtra("N").d[nNpcID]);
    } // End of the function
    function getNonPlayableCharactersActionText(nActionID)
    {
        return (this.getValueFromSOXtra("N").a[nActionID]);
    } // End of the function
    function getMonstersText(nMonsterID)
    {
        return (this.getValueFromSOXtra("M")[nMonsterID]);
    } // End of the function
    function getTimeZoneText()
    {
        return (this.getValueFromSOXtra("T"));
    } // End of the function
    function getClassText(nClassID)
    {
        return (this.getValueFromSOXtra("G")[nClassID]);
    } // End of the function
    function getEmoteText(nEmoteID)
    {
        return (this.getValueFromSOXtra("EM")[nEmoteID]);
    } // End of the function
    function getEmoteID(sEmoteShortcut)
    {
        var _loc2 = this.getValueFromSOXtra("EM");
        for (var _loc4 in _loc2)
        {
            if (_loc2[_loc4].s == sEmoteShortcut)
            {
                return (Number(_loc4));
            } // end if
        } // end of for...in
        return (null);
    } // End of the function
    function getGuildBoosts(sCharacteristics)
    {
        return (this.getValueFromSOXtra("GU").b[sCharacteristics]);
    } // End of the function
    function getGuildBoostsMax(sCharacteristics)
    {
        return (this.getValueFromSOXtra("GU").b[sCharacteristics + "m"]);
    } // End of the function
    function getNameText(nID)
    {
        return (this.getValueFromSOXtra("NF").n[nID]);
    } // End of the function
    function getFirstnameText(nID)
    {
        return (this.getValueFromSOXtra("NF").f[nID]);
    } // End of the function
    function getFullNameText(aIDs)
    {
        aIDs[0] = parseInt(aIDs[0], 36);
        aIDs[1] = parseInt(aIDs[1], 36);
        return (this.getFirstnameText(aIDs[0]) + " " + this.getNameText(aIDs[1]));
    } // End of the function
    function getRankInfos(nID)
    {
        return (this.getValueFromSOXtra("R")[nID]);
    } // End of the function
    function getRanks(nID)
    {
        return (this.getValueFromSOXtra("R"));
    } // End of the function
    function getAlignment(nID)
    {
        return (this.getValueFromSOXtra("A").a[nID]);
    } // End of the function
    function getAlignmentCanJoin(nIDa, nIDb)
    {
        return (this.getValueFromSOXtra("A").jo[nIDa][nIDb]);
    } // End of the function
    function getAlignmentCanAttack(nIDa, nIDb)
    {
        return (this.getValueFromSOXtra("A").at[nIDa][nIDb]);
    } // End of the function
    function getAlignmentSpecializations()
    {
        return (this.getValueFromSOXtra("A").s);
    } // End of the function
    function getAlignmentSpecialization(nID)
    {
        return (this.getValueFromSOXtra("A").s[nID]);
    } // End of the function
    function getAlignmentOrder(nID)
    {
        return (this.getValueFromSOXtra("A").o[nID]);
    } // End of the function
    function getAlignmentFeat(nID)
    {
        return (this.getValueFromSOXtra("A").f[nID]);
    } // End of the function
    function getAlignmentFeatEffect(nID)
    {
        return (this.getValueFromSOXtra("A").fe[nID]);
    } // End of the function
    function getTips()
    {
        return (this.getValueFromSOXtra("TI"));
    } // End of the function
    function getTip(nID)
    {
        return (this.getValueFromSOXtra("TI")[nID]);
    } // End of the function
    function getKeyboardShortcuts()
    {
        return (this.getValueFromSOXtra("SH"));
    } // End of the function
    function getKeyboardShortcut(sKey)
    {
        return (this.getValueFromSOXtra("SH")[sKey]);
    } // End of the function
    function getServerInfos(nID)
    {
        return (this.getValueFromSOXtra("SR")[nID]);
    } // End of the function
    function getValueFromSOLang(sKey)
    {
        return (_global[dofus.Constants.GLOBAL_SO_LANG_NAME].data[sKey]);
    } // End of the function
    function getValueFromSOXtra(sKey)
    {
        return (_global[dofus.Constants.GLOBAL_SO_XTRA_NAME].data[sKey]);
    } // End of the function
} // End of Class
#endinitclip
