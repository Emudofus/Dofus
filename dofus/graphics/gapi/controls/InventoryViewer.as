// Action script...

// [Initial MovieClip Action of sprite 813]
#initclip 10
class dofus.graphics.gapi.controls.InventoryViewer extends ank.gapi.core.UIAdvancedComponent
{
    var _eaDataProvider, __get__initialized, __get__dataProvider, _oKamasProvider, __get__kamasProvider, __get__autoFilter, __get__filterAtStart, _nCurrentFilterID, _btnFilterEquipement, _btnFilterNonEquipement, _btnFilterRessoureces, addToQueue, _aSelectedSuperTypes, _oDataViewer, _lblKama, api, _btnSelectedFilterButton, _lblFilter, __set__autoFilter, __get__currentFilterID, __set__dataProvider, __set__filterAtStart, __set__kamasProvider;
    function InventoryViewer()
    {
        super();
    } // End of the function
    function set dataProvider(eaDataProvider)
    {
        _eaDataProvider.removeEventListener("modelChanged", this);
        _eaDataProvider = eaDataProvider;
        _eaDataProvider.addEventListener("modelChanged", this);
        if (this.__get__initialized())
        {
            this.modelChanged();
        } // end if
        //return (this.dataProvider());
        null;
    } // End of the function
    function set kamasProvider(oKamasProvider)
    {
        oKamasProvider.removeEventListener("kamaChanged", this);
        _oKamasProvider = oKamasProvider;
        oKamasProvider.addEventListener("kamaChanged", this);
        if (this.__get__initialized())
        {
            this.kamaChanged();
        } // end if
        //return (this.kamasProvider());
        null;
    } // End of the function
    function set autoFilter(bAutoFilter)
    {
        _bAutoFilter = bAutoFilter;
        //return (this.autoFilter());
        null;
    } // End of the function
    function set filterAtStart(bFilterAtStart)
    {
        _bFilterAtStart = bFilterAtStart;
        //return (this.filterAtStart());
        null;
    } // End of the function
    function get currentFilterID()
    {
        return (_nCurrentFilterID);
    } // End of the function
    function setFilter(nFilter)
    {
        if (nFilter == _nCurrentFilterID)
        {
            return;
        } // end if
        switch (nFilter)
        {
            case 0:
            {
                this.click({target: _btnFilterEquipement});
                _btnFilterEquipement.__set__selected(true);
                break;
            } 
            case 1:
            {
                this.click({target: _btnFilterNonEquipement});
                _btnFilterNonEquipement.__set__selected(true);
                break;
            } 
            case 2:
            {
                this.click({target: _btnFilterRessoureces});
                _btnFilterRessoureces.__set__selected(true);
                break;
            } 
        } // End of switch
    } // End of the function
    function createChildren()
    {
        if (_bFilterAtStart)
        {
            if (_bAutoFilter)
            {
                this.addToQueue({object: this, method: setPreferedFilter});
            }
            else
            {
                this.addToQueue({object: this, method: setFilter, params: [0]});
            } // end if
        } // end else if
    } // End of the function
    function addListeners()
    {
        _btnFilterEquipement.addEventListener("click", this);
        _btnFilterNonEquipement.addEventListener("click", this);
        _btnFilterRessoureces.addEventListener("click", this);
    } // End of the function
    function setPreferedFilter()
    {
        var _loc3 = new Array({count: 0, id: 0}, {count: 0, id: 1}, {count: 0, id: 2});
        for (var _loc4 in _eaDataProvider)
        {
            var _loc2 = _eaDataProvider[_loc4].superType;
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT[_loc2])
            {
                ++_loc3[0].count;
            } // end if
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT[_loc2])
            {
                ++_loc3[1].count;
            } // end if
            if (dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES[_loc2])
            {
                ++_loc3[2].count;
            } // end if
        } // end of for...in
        _loc3.sortOn("count");
        this.setFilter(_loc3[2].id);
    } // End of the function
    function updateData()
    {
        var _loc4 = new ank.utils.ExtendedArray();
        for (var _loc5 in _eaDataProvider)
        {
            var _loc2 = _eaDataProvider[_loc5];
            var _loc3 = _loc2.position;
            if (_loc3 == -1 && _aSelectedSuperTypes[_loc2.superType])
            {
                _loc4.push(_loc2);
            } // end if
        } // end of for...in
        _oDataViewer.dataProvider = _loc4;
    } // End of the function
    function modelChanged()
    {
        this.updateData();
    } // End of the function
    function kamaChanged(oEvent)
    {
        if (oEvent.value == undefined)
        {
            _lblKama.__set__text("0");
        }
        else
        {
            _lblKama.__set__text(String(oEvent.value).addMiddleChar(api.lang.getConfigText("THOUSAND_SEPARATOR"), 3));
        } // end else if
    } // End of the function
    function click(oEvent)
    {
        if (oEvent.target != _btnSelectedFilterButton)
        {
            _btnSelectedFilterButton.__set__selected(false);
            _btnSelectedFilterButton = oEvent.target;
            switch (oEvent.target._name)
            {
                case "_btnFilterEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_EQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("EQUIPEMENT"));
                    _nCurrentFilterID = 0;
                    break;
                } 
                case "_btnFilterNonEquipement":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_NONEQUIPEMENT;
                    _lblFilter.__set__text(api.lang.getText("NONEQUIPEMENT"));
                    _nCurrentFilterID = 1;
                    break;
                } 
                case "_btnFilterRessoureces":
                {
                    _aSelectedSuperTypes = dofus.graphics.gapi.controls.InventoryViewer.FILTER_RESSOURECES;
                    _lblFilter.__set__text(api.lang.getText("RESSOURECES"));
                    _nCurrentFilterID = 2;
                    break;
                } 
            } // End of switch
            this.updateData();
        }
        else
        {
            oEvent.target.selected = true;
        } // end else if
    } // End of the function
    static var FILTER_EQUIPEMENT = [false, true, true, true, true, true, false, false, false, false, true, true, true, true];
    static var FILTER_NONEQUIPEMENT = [false, false, false, false, false, false, true, false, false, false, false, false, false, false];
    static var FILTER_RESSOURECES = [false, false, false, false, false, false, false, false, true, true, false, false, false, false];
    var _bAutoFilter = true;
    var _bFilterAtStart = true;
} // End of Class
#endinitclip
