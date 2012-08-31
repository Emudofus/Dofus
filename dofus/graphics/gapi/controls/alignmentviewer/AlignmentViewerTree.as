// Action script...

// [Initial MovieClip Action of sprite 1083]
#initclip 53
class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree extends ank.gapi.core.UIAdvancedComponent
{
    var addToQueue, api, _lblInfos, _lblLevel, _lstTree, gapi, dispatchEvent, __height;
    function AlignmentViewerTree()
    {
        super();
    } // End of the function
    function init()
    {
        super.init(false, dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTree.CLASS_NAME);
    } // End of the function
    function createChildren()
    {
        this.addToQueue({object: this, method: initTexts});
        this.addToQueue({object: this, method: addListeners});
        this.addToQueue({object: this, method: initData});
    } // End of the function
    function initTexts()
    {
        _lblInfos.__set__text(api.lang.getText("ALL_SPECIALIZATIONS"));
        _lblLevel.__set__text(api.lang.getText("LEVEL_SMALL"));
    } // End of the function
    function addListeners()
    {
        _lstTree.addEventListener("itemRollOver", this);
        _lstTree.addEventListener("itemRollOut", this);
        _lstTree.addEventListener("itemSelected", this);
    } // End of the function
    function initData()
    {
        var _loc22 = api.datacenter.Player.specialization;
        var _loc13 = _loc22.alignment.index;
        var _loc18 = _loc22.__get__index();
        var _loc19 = _loc22.order.index;
        var _loc4 = new Array();
        var _loc20 = api.lang.getAlignmentSpecializations();
        for (var _loc21 in _loc20)
        {
            var _loc7 = new dofus.datacenter.Specialization(_loc21);
            if (_loc7.order.index != _loc19)
            {
                continue;
            } // end if
            if (_loc7.__get__description() == "null")
            {
                continue;
            } // end if
            var _loc5 = _loc7.__get__alignment();
            var _loc10 = _loc7.__get__order();
            var _loc6 = _loc4[_loc13 == _loc5.__get__index() ? (0) : (_loc5.__get__index() + 1)];
            if (_loc6 == undefined)
            {
                _loc6 = new Array({data: _loc5, depth: 0});
                _loc4[_loc13 == _loc5.__get__index() ? (0) : (_loc5.__get__index() + 1)] = _loc6;
            } // end if
            var _loc9 = _loc6[_loc10.index];
            if (_loc9 == undefined)
            {
                _loc9 = new Array({data: _loc10, depth: 1, sortField: -1});
                _loc6[_loc10.index] = _loc9;
            } // end if
            _loc9.push({data: _loc7, depth: 2, sortField: _loc5.__get__value()});
        } // end of for...in
        var _loc11 = new ank.utils.ExtendedArray();
        for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
        {
            if (_loc4[_loc3] == undefined)
            {
                continue;
            } // end if
            var _loc8 = new ank.utils.ExtendedArray();
            for (var _loc2 = 0; _loc2 < _loc4[_loc3].length; ++_loc2)
            {
                if (_loc4[_loc3][_loc2] == undefined)
                {
                    continue;
                } // end if
                _loc4[_loc3][_loc2].sortOn("sortField", Array.NUMERIC);
                _loc8 = _loc8.concat(_loc4[_loc3][_loc2]);
            } // end of for
            _loc11 = _loc11.concat(_loc8);
        } // end of for
        _lstTree.__set__dataProvider(_loc11);
        if (_loc18 != undefined)
        {
            var _loc17 = -1;
            for (var _loc21 in _loc11)
            {
                var _loc12 = _loc11[_loc21].data;
                if (_loc12 instanceof dofus.datacenter.Specialization)
                {
                    if (_loc12.index == _loc18)
                    {
                        _loc17 = Number(_loc21);
                        break;
                    } // end if
                } // end if
            } // end of for...in
            _lstTree.__set__selectedIndex(_loc17);
        } // end if
    } // End of the function
    function itemSelected(oEvent)
    {
        gapi.hideTooltip();
        if (oEvent.target.item.data instanceof dofus.datacenter.Specialization)
        {
            this.dispatchEvent({type: "specializationSelected", specialization: oEvent.target.item.data});
        }
        else
        {
            _lstTree.__set__selectedIndex(-1);
            this.dispatchEvent({type: "specializationSelected"});
        } // end else if
    } // End of the function
    function itemRollOver(oEvent)
    {
        var _loc2 = oEvent.target.item.data;
        if (_loc2 instanceof dofus.datacenter.Specialization)
        {
            gapi.showTooltip(_loc2.description, this, __height + 30);
        } // end if
    } // End of the function
    function itemRollOut(oEvent)
    {
        gapi.hideTooltip();
    } // End of the function
    static var CLASS_NAME = "AlignmentViewerTree";
} // End of Class
#endinitclip
