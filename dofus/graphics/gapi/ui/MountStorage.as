// Action script...

// [Initial MovieClip Action of sprite 20568]
#initclip 89
if (!dofus.graphics.gapi.ui.MountStorage)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.graphics)
    {
        _global.dofus.graphics = new Object();
    } // end if
    if (!dofus.graphics.gapi)
    {
        _global.dofus.graphics.gapi = new Object();
    } // end if
    if (!dofus.graphics.gapi.ui)
    {
        _global.dofus.graphics.gapi.ui = new Object();
    } // end if
    var _loc1 = (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).prototype;
    _loc1.__set__mounts = function (eaMount)
    {
        this._eaMount.removeEventListener("modelChanged", this);
        this._eaMount = eaMount;
        this._eaMount.addEventListener("modelChanged", this);
        if (this.initialized)
        {
            this.modelChanged({target: this._eaMount});
        } // end if
        //return (this.mounts());
    };
    _loc1.__get__mounts = function ()
    {
        return (this._eaMount);
    };
    _loc1.__set__parkMounts = function (eaMount)
    {
        this._eaParkMounts.removeEventListener("modelChanged", this);
        this._eaParkMounts = eaMount;
        this._eaParkMounts.addEventListener("modelChanged", this);
        if (this.initialized)
        {
            this.modelChanged({target: this._eaParkMounts});
        } // end if
        //return (this.parkMounts());
    };
    _loc1.__get__parkMounts = function ()
    {
        return (this._eaParkMounts);
    };
    _loc1.init = function ()
    {
        super.init(false, dofus.graphics.gapi.ui.MountStorage.CLASS_NAME);
    };
    _loc1.callClose = function ()
    {
        this.api.network.Exchange.leave();
        return (true);
    };
    _loc1.createChildren = function ()
    {
        this.hideViewersAndButtons();
        this.addToQueue({object: this, method: this.addListeners});
        this.addToQueue({object: this, method: this.initTexts});
        this.addToQueue({object: this, method: this.initData});
        this.gapi.unloadLastUIAutoHideComponent();
    };
    _loc1.addListeners = function ()
    {
        this.api.datacenter.Player.addEventListener("mountChanged", this);
        this.api.datacenter.Player.Inventory.addEventListener("modelChanged", this);
        this.api.datacenter.Player.mount.addEventListener("nameChanged", this);
        this._cbFilterShed.addEventListener("itemSelected", this);
        this._cbFilterPark.addEventListener("itemSelected", this);
        this._lstCertificate.addEventListener("itemSelected", this);
        this._lstCertificate.addEventListener("itemRollOver", this);
        this._lstCertificate.addEventListener("itemRollOut", this);
        this._lstMountPark.addEventListener("itemSelected", this);
        this._lstMountPark.addEventListener("itemRollOver", this);
        this._lstMountPark.addEventListener("itemRollOut", this);
        this._lstShed.addEventListener("itemSelected", this);
        this._lstShed.addEventListener("itemRollOver", this);
        this._lstShed.addEventListener("itemRollOut", this);
        this._btnClose.addEventListener("click", this);
        this._btnShed.addEventListener("click", this);
        this._btnMountPark.addEventListener("click", this);
        this._btnCertificate.addEventListener("click", this);
        this._btnInventory.addEventListener("click", this);
        this._ldrSprite.addEventListener("initialization", this);
        this._mcRectanglePreview.onRelease = function ()
        {
            this._parent.click({target: this._parent._btnInventoryMount});
        };
    };
    _loc1.initTexts = function ()
    {
        this._winCertificate.title = this.api.lang.getText("MOUNT_CERTIFICATES");
        this._winMountPark.title = this.api.lang.getText("MOUNT_PARK");
        this._winInventory.title = this.api.lang.getText("MOUNT_INVENTORY");
        this._winShed.title = this.api.lang.getText("MOUNT_SHED");
        this._btnShed.label = this.api.lang.getText("MOUNT_SHED_ACTION");
        this._btnMountPark.label = this.api.lang.getText("MOUNT_PARK_ACTION");
        this._btnCertificate.label = this.api.lang.getText("MOUNT_CERTIFICATE_ACTION");
        this._btnInventory.label = this.api.lang.getText("MOUNT_INVENTORY_ACTION");
        this._lblTitle.text = this.api.lang.getText("MOUNT_MANAGER");
        this._lblInventoryNoMount.text = this.api.lang.getText("MOUNT_NO_EQUIP");
        this.fillTypeCombobox(this._cbFilterShed, this.mounts.concat(this.parkMounts));
        this.fillTypeCombobox(this._cbFilterPark, this.mounts.concat(this.parkMounts));
    };
    _loc1.initData = function ()
    {
        this.modelChanged({target: this._eaMount});
        this.modelChanged({target: this._eaParkMounts});
        this.modelChanged({target: this.api.datacenter.Player.Inventory});
        this.mountChanged();
    };
    _loc1.createCertificateArray = function ()
    {
        var _loc2 = new ank.utils.ExtendedArray();
        var _loc3 = this.api.datacenter.Player.Inventory;
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < _loc3.length)
        {
            var _loc5 = _loc3[_loc4];
            if (_loc5.type == 97)
            {
                _loc2.push(_loc5);
            } // end if
        } // end while
        return (_loc2);
    };
    _loc1.hideShedButton = function (bHide)
    {
        this._mcArrowShed._visible = !bHide;
        this._btnShed._visible = !bHide;
    };
    _loc1.hideMountParkButton = function (bHide)
    {
        this._mcArrowMountPark._visible = !bHide;
        this._btnMountPark._visible = !bHide;
    };
    _loc1.hideCertificateButton = function (bHide)
    {
        this._mcArrowCertificate._visible = !bHide;
        this._btnCertificate._visible = !bHide;
    };
    _loc1.hideInventoryButton = function (bHide)
    {
        this._mcArrowInventory._visible = !bHide;
        this._btnInventory._visible = !bHide;
    };
    _loc1.hideMountViewer = function (bHide)
    {
        this._winMountViewer._visible = !bHide;
        this._mvMountViewer._visible = !bHide;
        if (!bHide)
        {
            this.moveTopButtons(0);
            this.moveBottomButtons(0);
        } // end if
    };
    _loc1.hideItemViewer = function (bHide)
    {
        this._winItemViewer._visible = !bHide;
        this._itvItemViewer._visible = !bHide;
        if (!bHide)
        {
            this.moveTopButtons(14);
            this.moveBottomButtons(-13);
        } // end if
    };
    _loc1.moveTopButtons = function (y)
    {
        this._btnInventory._y = 146 + y;
        this._btnShed._y = 146 + y;
    };
    _loc1.moveBottomButtons = function (y)
    {
        this._btnCertificate._y = 383 + y;
        this._btnMountPark._y = 383 + y;
    };
    _loc1.hideAllButtons = function (bHide)
    {
        this.hideShedButton(bHide);
        this.hideMountParkButton(bHide);
        this.hideCertificateButton(bHide);
        this.hideInventoryButton(bHide);
    };
    _loc1.hideViewersAndButtons = function ()
    {
        this.hideAllButtons(true);
        this.hideMountViewer(true);
        this.hideItemViewer(true);
    };
    _loc1.fillTypeCombobox = function (cb, eaSrc)
    {
        var _loc4 = cb.selectedItem.id;
        var _loc5 = cb.selectedItem.modelID;
        var _loc6 = cb.dataProvider.length ? (cb.dataProvider) : (new ank.utils.ExtendedArray());
        if (!cb.dataProvider.length)
        {
            _loc6.push({label: this.api.lang.getText("WITHOUT_TYPE_FILTER"), id: 0});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_MAN"), id: 1});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_WOMAN"), id: 2});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_FECONDABLE"), id: 3});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_FECONDEE"), id: 4});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_MOUNTABLE"), id: 5});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_NONAME"), id: 6});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_CAPACITY"), id: 7});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_MUSTXP"), id: 8});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_TIRED"), id: 9});
            _loc6.push({label: this.api.lang.getText("MOUNT_FILTER_NOTIRED"), id: 10});
        } // end if
        eaSrc.sortOn("modelID");
        for (var i in eaSrc)
        {
            var _loc7 = false;
            for (var j in _loc6)
            {
                if (_loc6[j].modelID == eaSrc[i].modelID)
                {
                    _loc7 = true;
                    break;
                } // end if
            } // end of for...in
            if (_loc7)
            {
                continue;
            } // end if
            _loc6.push({label: eaSrc[i].modelName, id: 11, modelID: eaSrc[i].modelID});
        } // end of for...in
        _loc6.sortOn(["id", "modelName"], Array.NUMERIC);
        var _loc8 = -1;
        for (var i in _loc6)
        {
            if (_loc6[i].id == _loc4 && _loc6[i].modelID == _loc5)
            {
                _loc8 = _global.parseInt(i);
            } // end if
        } // end of for...in
        cb.dataProvider = _loc6;
        cb.selectedIndex = _loc8 != -1 ? (_loc8) : (0);
    };
    _loc1.makeDataProvider = function (eaSrc, cbFilter)
    {
        var _loc4 = new ank.utils.ExtendedArray();
        var _loc5 = cbFilter.selectedItem.id;
        switch (_loc5)
        {
            case 0:
            {
                _loc4 = eaSrc;
                break;
            } 
            case 1:
            {
                for (var i in eaSrc)
                {
                    if (!eaSrc[i].sex)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 2:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].sex)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 3:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].fecondable && eaSrc[i].fecondation == -1)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 4:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].fecondation > 0)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 5:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].mountable)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 6:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].name == this.api.lang.getText("NO_NAME"))
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 7:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].capacities.length > 0)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 8:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].mountable && eaSrc[i].level < 5)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 9:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].tired == eaSrc[i].tiredMax)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 10:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].tired < eaSrc[i].tiredMax)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
            case 11:
            {
                for (var i in eaSrc)
                {
                    if (eaSrc[i].modelID == cbFilter.selectedItem.modelID)
                    {
                        _loc4.push(eaSrc[i]);
                    } // end if
                } // end of for...in
                break;
            } 
        } // End of switch
        return (_loc4);
    };
    _loc1.initialization = function (oEvent)
    {
        var _loc3 = oEvent.target.content;
        _loc3.attachMovie("staticR_front", "anim_front", 11);
        _loc3.attachMovie("staticR_back", "anim_back", 10);
    };
    _loc1.mountChanged = function (oEvent)
    {
        this.hideViewersAndButtons();
        var _loc3 = this.api.datacenter.Player.mount;
        var _loc4 = _loc3 != undefined;
        if (_loc4)
        {
            this._lblInventoryMountModel.text = _loc3.modelName;
            this._lblInventoryMountName.text = _loc3.name;
            this._ldrSprite.forceNextLoad();
            this._ldrSprite.contentPath = _loc3.gfxFile;
            var _loc5 = new ank.battlefield.datacenter.Sprite("-1", undefined, "", 0, 0);
            _loc5.mount = _loc3;
            this.api.colors.addSprite(this._ldrSprite, _loc5);
        } // end if
        this._lblInventoryNoMount._visible = !_loc4;
        this._lblInventoryMountModel._visible = _loc4;
        this._lblInventoryMountName._visible = _loc4;
        this._ldrSprite._visible = _loc4;
        this._mcRectanglePreview._visible = _loc4;
    };
    _loc1.modelChanged = function (oEvent)
    {
        this.hideViewersAndButtons();
        switch (oEvent.target)
        {
            case this._eaMount:
            {
                this._lstShed.dataProvider = this.makeDataProvider(this._eaMount, this._cbFilterShed);
                this._lstShed.sortOn("modelID");
                this.fillTypeCombobox(this._cbFilterShed, this.mounts.concat(this.parkMounts));
                this.fillTypeCombobox(this._cbFilterPark, this.mounts.concat(this.parkMounts));
                break;
            } 
            case this._eaParkMounts:
            {
                this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts, this._cbFilterPark);
                this._lstShed.sortOn("modelID");
                this.fillTypeCombobox(this._cbFilterShed, this.mounts.concat(this.parkMounts));
                this.fillTypeCombobox(this._cbFilterPark, this.mounts.concat(this.parkMounts));
                break;
            } 
            case this.api.datacenter.Player.Inventory:
            {
                this._lstCertificate.dataProvider = this.createCertificateArray();
                break;
            } 
        } // End of switch
    };
    _loc1.click = function (oEvent)
    {
        var _loc3 = this.api.network.Exchange;
        switch (oEvent.target)
        {
            case this._btnClose:
            {
                this.callClose();
                break;
            } 
            case this._btnInventoryMount:
            {
                this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY;
                this._mvMountViewer.mount = this.api.datacenter.Player.mount;
                this.hideAllButtons(false);
                this.hideItemViewer(true);
                this.hideMountViewer(false);
                this.hideInventoryButton(true);
                break;
            } 
            case this._btnShed:
            {
                switch (this._nSelectFrom)
                {
                    case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
                    {
                        _loc3.putInShedFromCertificate(this._itvItemViewer.itemData.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                    {
                        _loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                    {
                        _loc3.putInShedFromInventory(this.api.datacenter.Player.mount.ID);
                        break;
                    } 
                } // End of switch
                break;
            } 
            case this._btnInventory:
            {
                switch (this._nSelectFrom)
                {
                    case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                    {
                        _loc3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                    {
                        _loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                        _loc3.putInInventoryFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
                    {
                        break;
                    } 
                } // End of switch
                break;
            } 
            case this._btnMountPark:
            {
                switch (this._nSelectFrom)
                {
                    case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                    {
                        _loc3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE:
                    {
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                    {
                        _loc3.putInShedFromInventory(this._mvMountViewer.mount.ID);
                        _loc3.putInMountParkFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                } // End of switch
                break;
            } 
            case this._btnCertificate:
            {
                switch (this._nSelectFrom)
                {
                    case dofus.graphics.gapi.ui.MountStorage.FROM_SHED:
                    {
                        _loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK:
                    {
                        _loc3.putInShedFromMountPark(this._mvMountViewer.mount.ID);
                        _loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                    case dofus.graphics.gapi.ui.MountStorage.FROM_INVENTORY:
                    {
                        _loc3.putInShedFromInventory(this._mvMountViewer.mount.ID);
                        _loc3.putInCertificateFromShed(this._mvMountViewer.mount.ID);
                        break;
                    } 
                } // End of switch
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
    };
    _loc1.itemSelected = function (oEvent)
    {
        this.hideAllButtons(false);
        switch (oEvent.target)
        {
            case this._lstShed:
            {
                this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_SHED;
                this._mvMountViewer.mount = oEvent.row.item;
                this.hideItemViewer(true);
                this.hideShedButton(true);
                this.hideMountViewer(false);
                break;
            } 
            case this._lstMountPark:
            {
                this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_MOUNTPARK;
                this._mvMountViewer.mount = oEvent.row.item;
                this.hideItemViewer(true);
                this.hideMountParkButton(true);
                this.hideMountViewer(false);
                break;
            } 
            case this._lstCertificate:
            {
                this.hideMountParkButton(true);
                this.hideInventoryButton(true);
                this._nSelectFrom = dofus.graphics.gapi.ui.MountStorage.FROM_CERTIFICATE;
                this._itvItemViewer.itemData = oEvent.row.item;
                this.hideCertificateButton(true);
                this.hideMountViewer(true);
                this.hideItemViewer(false);
                break;
            } 
            case this._cbFilterShed:
            {
                this._lstShed.dataProvider = this.makeDataProvider(this._eaMount, this._cbFilterShed);
                this.hideViewersAndButtons();
                break;
            } 
            case this._cbFilterPark:
            {
                this._lstMountPark.dataProvider = this.makeDataProvider(this._eaParkMounts, this._cbFilterPark);
                this.hideViewersAndButtons();
                break;
            } 
            default:
            {
                this.hideViewersAndButtons();
                break;
            } 
        } // End of switch
    };
    _loc1.itemRollOver = function (oEvent)
    {
        switch (oEvent.target)
        {
            case this._lstCertificate:
            {
                break;
            } 
            case this._lstMountPark:
            case this._lstShed:
            {
                this.gapi.showTooltip(oEvent.row.item.getToolTip(), oEvent.target, 20, {bXLimit: true, bYLimit: false});
                break;
            } 
        } // End of switch
    };
    _loc1.itemRollOut = function (oEvent)
    {
        this.gapi.hideTooltip();
    };
    _loc1.nameChanged = function (oEvent)
    {
        this._lblInventoryMountName.text = oEvent.name;
    };
    _loc1.addProperty("mounts", _loc1.__get__mounts, _loc1.__set__mounts);
    _loc1.addProperty("parkMounts", _loc1.__get__parkMounts, _loc1.__set__parkMounts);
    ASSetPropFlags(_loc1, null, 1);
    (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).CLASS_NAME = "MountStorage";
    (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).FROM_SHED = 0;
    (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).FROM_MOUNTPARK = 1;
    (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).FROM_CERTIFICATE = 2;
    (_global.dofus.graphics.gapi.ui.MountStorage = function ()
    {
        super();
    }).FROM_INVENTORY = 3;
} // end if
#endinitclip
