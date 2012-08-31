// Action script...

// [Initial MovieClip Action of sprite 1067]
#initclip 37
class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem extends ank.gapi.core.UIBasicComponent
{
    var _mcList, __get__list, _oItem, _lblName, _lblPosition, _vcTimer, _mcFight, _mcEnterFight, _mcCollect, addToQueue, _btnPlayer0, _btnPlayer1, _btnPlayer2, _btnPlayer3, _btnPlayer4, _btnPlayer5, _btnPlayer6, _btnAttackers, _btnState, _mcBackButtons, _lblAttackersCount, __set__list;
    function TaxCollectorsViewerItem()
    {
        super();
    } // End of the function
    function set list(mcList)
    {
        _mcList = mcList;
        //return (this.list());
        null;
    } // End of the function
    function setValue(bUsed, sSuggested, oItem)
    {
        _oItem.players.removeEventListener("modelChanged", this);
        _oItem.attackers.removeEventListener("modelChanged", this);
        _oItem = oItem;
        if (bUsed)
        {
            _lblName.__set__text(oItem.name);
            _lblPosition.__set__text(oItem.position);
            this.showStateIcon();
            if (!isNaN(oItem.timer))
            {
                var _loc3 = oItem.timer - (getTimer() - oItem.timerReference);
                var _loc4 = oItem.maxTimer / 1000;
                if (_loc3 > 0)
                {
                    _vcTimer.startTimer(_loc3 / 1000, _loc4);
                    this.showButtonsJoin(isNaN(oItem.maxPlayerCount) ? (0) : (oItem.maxPlayerCount));
                }
                else
                {
                    _vcTimer.stopTimer();
                    this.showButtonsJoin(0);
                } // end else if
            }
            else
            {
                _vcTimer.stopTimer();
                this.showButtonsJoin(0);
            } // end else if
            oItem.players.addEventListener("modelChanged", this);
            oItem.attackers.addEventListener("modelChanged", this);
            this.updateAttackers();
            this.updatePlayers();
        }
        else
        {
            _lblName.__set__text("");
            _lblPosition.__set__text("");
            _mcFight._visible = false;
            _mcEnterFight._visible = false;
            _mcCollect._visible = false;
            this.hideButtonsJoin();
            _vcTimer.stopTimer();
            this.updateAttackers();
        } // end else if
    } // End of the function
    function init()
    {
        super.init(false);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: addListeners});
        _btnPlayer0._visible = _btnPlayer1._visible = _btnPlayer2._visible = _btnPlayer3._visible = _btnPlayer4._visible = _btnPlayer5._visible = _btnPlayer6._visible = false;
    } // End of the function
    function addListeners()
    {
        _btnPlayer0.addEventListener("click", this);
        _btnPlayer1.addEventListener("click", this);
        _btnPlayer2.addEventListener("click", this);
        _btnPlayer3.addEventListener("click", this);
        _btnPlayer4.addEventListener("click", this);
        _btnPlayer5.addEventListener("click", this);
        _btnPlayer6.addEventListener("click", this);
        _btnPlayer0.addEventListener("over", this);
        _btnPlayer1.addEventListener("over", this);
        _btnPlayer2.addEventListener("over", this);
        _btnPlayer3.addEventListener("over", this);
        _btnPlayer4.addEventListener("over", this);
        _btnPlayer5.addEventListener("over", this);
        _btnPlayer6.addEventListener("over", this);
        _btnAttackers.addEventListener("over", this);
        _btnState.addEventListener("over", this);
        _btnPlayer0.addEventListener("out", this);
        _btnPlayer1.addEventListener("out", this);
        _btnPlayer2.addEventListener("out", this);
        _btnPlayer3.addEventListener("out", this);
        _btnPlayer4.addEventListener("out", this);
        _btnPlayer5.addEventListener("out", this);
        _btnPlayer6.addEventListener("out", this);
        _btnAttackers.addEventListener("out", this);
        _btnState.addEventListener("out", this);
        _vcTimer.addEventListener("endTimer", this);
    } // End of the function
    function showButtonsJoin(nPlayerCount)
    {
        _mcBackButtons._visible = true;
        for (var _loc2 = 0; _loc2 < nPlayerCount; ++_loc2)
        {
            this["_btnPlayer" + _loc2]._visible = true;
        } // end of for
        for (var _loc3 = _loc2; _loc3 < 7; ++_loc3)
        {
            this["_btnPlayer" + _loc3]._visible = false;
        } // end of for
    } // End of the function
    function hideButtonsJoin()
    {
        _mcBackButtons._visible = false;
        for (var _loc2 = 0; _loc2 < 7; ++_loc2)
        {
            this["_btnPlayer" + _loc2]._visible = false;
        } // end of for
    } // End of the function
    function updatePlayers()
    {
        var _loc6 = _oItem.players;
        for (var _loc2 = 0; _loc2 < _loc6.length; ++_loc2)
        {
            var _loc4 = this["_btnPlayer" + _loc2];
            var _loc5 = _loc6[_loc2];
            _loc4.iconClip.data = _loc5;
            _loc4.params = {player: _loc5};
        } // end of for
        for (var _loc3 = _loc2; _loc3 < 7; ++_loc3)
        {
            _loc4 = this["_btnPlayer" + _loc3];
            _loc4.iconClip.data = null;
            _loc4.params = new Object();
        } // end of for
    } // End of the function
    function updateAttackers()
    {
        if (_oItem.state == 1)
        {
            var _loc2 = _oItem.attackers.length;
            _lblAttackersCount.__set__text(String(_loc2));
            _btnAttackers._visible = _loc2 > 0;
        }
        else
        {
            _lblAttackersCount.__set__text("-");
        } // end else if
    } // End of the function
    function showStateIcon()
    {
        _mcFight._visible = _oItem.state == 2;
        _mcEnterFight._visible = _oItem.state == 1;
        _mcCollect._visible = _oItem.state == 0;
    } // End of the function
    function click(oEvent)
    {
        var _loc2 = _mcList.gapi.api;
        if (_loc2.datacenter.Player.cantInteractWithTaxCollector)
        {
            return;
        } // end if
        var _loc4 = oEvent.target.params.player;
        if (_loc4 != undefined)
        {
            if (_loc4.id == _loc2.datacenter.Player.ID)
            {
                _loc2.network.Guild.leaveTaxCollector(_oItem.id);
            } // end if
        }
        else
        {
            var _loc3 = _loc2.datacenter.Player.guildInfos;
            if (_loc3.isLocalPlayerDefender)
            {
                if (_loc3.defendedTaxCollectorID != _oItem.id)
                {
                    _loc2.network.Guild.leaveTaxCollector(_loc3.defendedTaxCollectorID);
                    _loc2.network.Guild.joinTaxCollector(_oItem.id);
                } // end if
            }
            else
            {
                _loc2.network.Guild.joinTaxCollector(_oItem.id);
            } // end else if
        } // end else if
    } // End of the function
    function over(oEvent)
    {
        switch (oEvent.target._name)
        {
            case "_btnAttackers":
            {
                var _loc5 = _oItem.attackers.length;
                if (_loc5 == 0)
                {
                    return;
                } // end if
                var _loc4 = new String();
                for (var _loc2 = 0; _loc2 < _loc5; ++_loc2)
                {
                    var _loc3 = _oItem.attackers[_loc2];
                    _loc4 = _loc4 + ("\n" + _loc3.name + " (" + _loc3.level + ")");
                } // end of for
                _mcList.gapi.showTooltip(_mcList.gapi.api.lang.getText("ATTACKERS") + " : " + _loc4, oEvent.target, 40);
                break;
            } 
            case "_btnState":
            {
                var _loc6 = new String();
                switch (_oItem.state)
                {
                    case 0:
                    {
                        _loc6 = _mcList.gapi.api.lang.getText("TAX_IN_COLLECT");
                        break;
                    } 
                    case 1:
                    {
                        _loc6 = _mcList.gapi.api.lang.getText("TAX_IN_ENTERFIGHT");
                        break;
                    } 
                    case 2:
                    {
                        _loc6 = _mcList.gapi.api.lang.getText("TAX_IN_FIGHT");
                        break;
                    } 
                } // End of switch
                _mcList.gapi.showTooltip(_loc6, oEvent.target, 40);
                break;
            } 
            default:
            {
                var _loc8 = oEvent.target.params.player;
                if (_loc8 != undefined)
                {
                    _mcList.gapi.showTooltip(_loc8.name + " (" + _loc8.level + ")", oEvent.target, -20);
                } // end if
                break;
            } 
        } // End of switch
    } // End of the function
    function out(oEvent)
    {
        _mcList.gapi.hideTooltip();
    } // End of the function
    function endTimer(oEvent)
    {
        _vcTimer.stopTimer();
        this.showButtonsJoin(0);
        _oItem.state = 2;
        this.showStateIcon();
        this.updateAttackers();
        _mcList.gapi.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
    } // End of the function
    function modelChanged(oEvent)
    {
        _mcList.gapi.hideTooltip();
        this.updateAttackers();
        this.updatePlayers();
    } // End of the function
} // End of Class
#endinitclip
