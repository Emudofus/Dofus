// Action script...

// [Initial MovieClip Action of sprite 945]
#initclip 157
class dofus.aks.Infos extends dofus.aks.Handler
{
    var aks, api;
    function Infos(oAKS, oAPI)
    {
        super.initialize(oAKS, oAPI);
    } // End of the function
    function getMaps()
    {
        aks.send("IM");
    } // End of the function
    function onInfoMaps(sExtraData)
    {
        var _loc1 = sExtraData.split("|");
        trace ({area: Number(_loc1[0]), x: Number(_loc1[1]), y: Number(_loc1[2])});
    } // End of the function
    function onInfoCompass(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc5 = Number(_loc2[0]);
        var _loc4 = Number(_loc2[1]);
        var _loc3 = api.ui.getUIComponent("MapExplorer");
        if (_loc3 != undefined)
        {
            _loc3.select({coordinates: {x: _loc5, y: _loc4}});
        } // end if
        api.kernel.GameManager.updateCompass(_loc5, _loc4, true);
    } // End of the function
    function onInfoCoordinatespHighlight(sExtraData)
    {
        var _loc9 = new Array();
        if (String(sExtraData).length != 0)
        {
            var _loc6 = sExtraData.split("|");
            for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
            {
                var _loc3 = _loc6[_loc2].split(";");
                var _loc5 = Number(_loc3[0]);
                var _loc4 = Number(_loc3[1]);
                _loc9.push({x: _loc5, y: _loc4});
            } // end of for
        } // end if
        var _loc10 = api.ui.getUIComponent("MapExplorer");
        if (_loc10 != undefined)
        {
            _loc10.multipleSelect(_loc9);
        } // end if
        api.datacenter.Basics.aks_infos_highlightCoords = String(sExtraData).length == 0 ? (undefined) : (_loc9);
    } // End of the function
    function onMessage(sExtraData)
    {
        var _loc9 = new Array();
        var _loc11 = sExtraData.charAt(0);
        var _loc10 = sExtraData.substr(1).split("|");
        for (var _loc5 = 0; _loc5 < _loc10.length; ++_loc5)
        {
            var _loc7 = _loc10[_loc5].split(";");
            var _loc6 = _loc7[0];
            var _loc3 = Number(_loc6);
            var _loc2 = _loc7[1].split("~");
            switch (_loc11)
            {
                case "0":
                {
                    var _loc4;
                    if (!isNaN(_loc3))
                    {
                        switch (_loc3)
                        {
                            case 21:
                            case 22:
                            {
                                var _loc8 = new dofus.datacenter.Item(0, _loc2[1]);
                                _loc2 = [_loc2[0], _loc8.name];
                                break;
                            } 
                            case 17:
                            {
                                _loc2 = [_loc2[0], api.lang.getJobText(_loc2[1]).n];
                                break;
                            } 
                            case 2:
                            {
                                _loc2 = [api.lang.getJobText(Number(_loc2[0])).n];
                                break;
                            } 
                            case 3:
                            {
                                _loc2 = [api.lang.getSpellText(Number(_loc2[0])).n];
                                break;
                            } 
                        } // End of switch
                        _loc4 = api.lang.getText("INFOS_" + _loc3, _loc2);
                    }
                    else
                    {
                        _loc4 = api.lang.getText(_loc6, _loc2);
                    } // end else if
                    if (_loc4 != undefined)
                    {
                        _loc9.push(_loc4);
                    } // end if
                    break;
                } 
                case "1":
                {
                    if (!isNaN(_loc3))
                    {
                        switch (_loc3)
                        {
                            case 6:
                            case 46:
                            case 49:
                            {
                                _loc2 = [api.lang.getJobText(_loc2[0]).n];
                                break;
                            } 
                            case 7:
                            {
                                _loc2 = [api.lang.getSpellText(_loc2[0]).n];
                                break;
                            } 
                        } // End of switch
                        _loc4 = api.lang.getText("ERROR_" + _loc3, _loc2);
                    }
                    else
                    {
                        _loc4 = api.lang.getText(_loc6, _loc2);
                    } // end else if
                    if (_loc4 != undefined)
                    {
                        _loc9.push(_loc4);
                    } // end if
                    break;
                } 
            } // End of switch
        } // end of for
        var _loc12 = _loc9.join(" ");
        if (_loc12 != "")
        {
            api.kernel.showMessage(undefined, _loc12, _loc11 == 0 ? ("INFO_CHAT") : ("ERROR_CHAT"));
        } // end if
    } // End of the function
    function onQuantity(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc4 = _loc2[0];
        var _loc3 = _loc2[1];
        api.gfx.addSpritePoints(_loc4, _loc3, 11552256);
    } // End of the function
    function onObject(sExtraData)
    {
        var _loc2 = sExtraData.split("|");
        var _loc5 = _loc2[0];
        var _loc4 = _loc2[1].charAt(0) == "+";
        var _loc3 = _loc2[1].substr(1);
        var _loc6 = _loc3 == "" ? (undefined) : (new dofus.datacenter.Item(0, _loc3, 1));
        api.gfx.addSpriteOverHeadItem(_loc5, "craft", dofus.graphics.battlefield.CraftResultOverHead, [_loc4, _loc6], 2000);
    } // End of the function
    function onLifeRestoreTimerStart(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        clearInterval(api.datacenter.Basics.aks_infos_lifeRestoreInterval);
        if (!isNaN(_loc2))
        {
            var _loc3 = api.datacenter.Player;
            api.datacenter.Basics.aks_infos_lifeRestoreInterval = setInterval(_loc3, "updateLP", _loc2, 1);
        } // end if
    } // End of the function
    function onLifeRestoreTimerFinish(sExtraData)
    {
        var _loc2 = Number(sExtraData);
        clearInterval(api.datacenter.Basics.aks_infos_lifeRestoreInterval);
        if (_loc2 > 0)
        {
            api.kernel.showMessage(undefined, api.lang.getText("YOU_RESTORE_LIFE", [_loc2]), "INFO_CHAT");
        } // end if
    } // End of the function
} // End of Class
#endinitclip
