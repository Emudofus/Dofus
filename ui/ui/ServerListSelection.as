package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.ConnectionApi;
    import d2api.SoundApi;
    import flash.utils.Timer;
    import d2components.GraphicContainer;
    import d2components.Grid;
    import d2components.Input;
    import d2components.ButtonContainer;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
    import d2hooks.ServersList;
    import d2hooks.SelectedServerRefused;
    import d2hooks.AcquaintanceSearchError;
    import d2hooks.AcquaintanceServerList;
    import d2actions.ServerSelection;
    import flash.utils.getTimer;
    import d2actions.AcquaintanceSearch;
    import flash.events.TimerEvent;
    import d2hooks.ServerSelectionStart;
    import d2actions.ResetGame;
    import d2hooks.*;
    import d2actions.*;

    public class ServerListSelection 
    {

        public var output:Object;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var connecApi:ConnectionApi;
        public var soundApi:SoundApi;
        private var _currentServer:Object;
        private var _serverInfo:Object;
        private var _aServers:Array;
        private var _aMyCommuServers:Array;
        private var _aMyServers:Array;
        private var _nNbServers:uint;
        private var _aDataServers:Array;
        private var _bReload:Boolean = false;
        private var _assetsUri:String;
        private var _popupName:String;
        private var _popupInUse:int = 0;
        private var _lockSearchTimer:Timer;
        private var _clockStart:Number;
        private var _aFriendServers:Array;
        private var _modeAutochoice:Boolean = false;
        public var ctr_serverForm:GraphicContainer;
        public var gd_listServer:Grid;
        public var inp_findAFriend:Input;
        public var btn_friendSearch:ButtonContainer;
        public var btn_closeSearch:ButtonContainer;
        public var btn_cancel:ButtonContainer;
        public var btn_ckboxCommu:ButtonContainer;
        public var btn_ckboxMy:ButtonContainer;
        public var btn_tabCountry:ButtonContainer;
        public var btn_tabName:ButtonContainer;
        public var btn_tabState:ButtonContainer;
        public var btn_tabPopulation:ButtonContainer;
        public var btn_validate:ButtonContainer;
        public var btn_autochoice:ButtonContainer;


        public function main(param:Object=null):void
        {
            this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
            this.soundApi.switchIntroMusic();
            this.btn_cancel.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_autochoice.soundId = SoundEnum.CANCEL_BUTTON;
            this.btn_validate.soundId = "-1";
            this.sysApi.addHook(ServersList, this.onServersList);
            this.sysApi.addHook(SelectedServerRefused, this.onSelectedServerRefused);
            this.sysApi.addHook(AcquaintanceSearchError, this.onAcquaintanceSearchError);
            this.sysApi.addHook(AcquaintanceServerList, this.onAcquaintanceServerList);
            this.uiApi.addShortcutHook("validUi", this.onShortcut);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.uiApi.addComponentHook(this.inp_findAFriend, "onRollOver");
            this.uiApi.addComponentHook(this.inp_findAFriend, "onRollOut");
            this.inp_findAFriend.maxChars = 30;
            this._assetsUri = this.uiApi.me().getConstant("assets");
            if (((((param) && (param.servers))) && ((param.servers.length > 0))))
            {
                this.onServersList(param.servers);
            }
            else
            {
                this.onServersList(this.connecApi.getServers());
            };
            this.gd_listServer.focus();
        }

        public function unload():void
        {
            this.uiApi.unloadUi("serverForm5");
            this.uiApi.unloadUi("serverPopup");
            this.uiApi.unloadUi(this._popupName);
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        private function validateServerChoice():void
        {
            var selectedServer:Object;
            if (((this._aServers) && (this.gd_listServer.selectedItem)))
            {
                this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
                this.btn_validate.disabled = true;
                this.btn_autochoice.disabled = true;
                this.btn_cancel.disabled = true;
                this.gd_listServer.disabled = true;
                selectedServer = this.gd_listServer.selectedItem;
                this.sysApi.sendAction(new ServerSelection(selectedServer.id));
                this._clockStart = getTimer();
                this.sysApi.addEventListener(this.onEnterFrame, "time");
            };
        }

        private function displayServers():void
        {
            var j:*;
            var _local_2:Array;
            var i:*;
            if (!(this._bReload))
            {
                this._bReload = true;
                for (j in this._aServers)
                {
                    if (this._aServers[j].status == 3)
                    {
                        this._serverInfo = this._aServers[j];
                        break;
                    };
                };
            }
            else
            {
                this.gd_listServer.autoSelectMode = 0;
            };
            switch (true)
            {
                case ((Boolean(this.btn_ckboxCommu.selected)) && (Boolean(this.btn_ckboxMy.selected))):
                    this._nNbServers = this._aMyServers.length;
                    this.createDataprovider(this._aMyServers);
                    break;
                case ((Boolean(!(this.btn_ckboxCommu.selected))) && (Boolean(this.btn_ckboxMy.selected))):
                    _local_2 = new Array();
                    for (i in this._aMyCommuServers)
                    {
                        if (this._aMyCommuServers[i].charactersCount > 0)
                        {
                            _local_2.push(this._aMyCommuServers[i]);
                        };
                    };
                    this._nNbServers = _local_2.length;
                    this.createDataprovider(_local_2);
                    break;
                case ((Boolean(this.btn_ckboxCommu.selected)) && (Boolean(!(this.btn_ckboxMy.selected)))):
                    this._nNbServers = this._aServers.length;
                    this.createDataprovider(this._aServers);
                    break;
                case ((Boolean(!(this.btn_ckboxCommu.selected))) && (Boolean(!(this.btn_ckboxMy.selected)))):
                    this._nNbServers = this._aMyCommuServers.length;
                    this.createDataprovider(this._aMyCommuServers);
                    break;
            };
        }

        private function createDataprovider(servers:*):void
        {
            var data:*;
            var selectedIndex:int;
            var fserver:*;
            var serverfData:Object;
            var serverData:Object;
            var obj:*;
            var dataProvider:Array = new Array();
            for each (data in servers)
            {
                if (((this._aFriendServers) && (this._aFriendServers.length)))
                {
                    for each (fserver in this._aFriendServers)
                    {
                        if (data.id == fserver)
                        {
                            serverfData = this.dataApi.getServer(data.id);
                            dataProvider.push({
                                "id":data.id,
                                "name":serverfData.name,
                                "completion":serverfData.populationId,
                                "community":serverfData.communityId,
                                "status":data.status
                            });
                        };
                    };
                }
                else
                {
                    serverData = this.dataApi.getServer(data.id);
                    dataProvider.push({
                        "id":data.id,
                        "name":serverData.name,
                        "completion":serverData.populationId,
                        "community":serverData.communityId,
                        "status":data.status
                    });
                };
            };
            this.gd_listServer.dataProvider = dataProvider;
            selectedIndex = 0;
            if (this._serverInfo)
            {
                for (obj in dataProvider)
                {
                    if (dataProvider[obj].id == this._serverInfo.id)
                    {
                        selectedIndex = obj;
                    };
                };
                this.gd_listServer.selectedIndex = selectedIndex;
            };
        }

        private function autochoice():void
        {
            var serverIndex:*;
            var availableServers:Array = new Array();
            this.btn_ckboxCommu.selected = false;
            this.btn_ckboxMy.selected = false;
            this.displayServers();
            this._modeAutochoice = true;
            var chosenServer:Object = this.connecApi.getAutochosenServer();
            if (chosenServer)
            {
                for (serverIndex in this._aMyCommuServers)
                {
                    if (this._aMyCommuServers[serverIndex].id == chosenServer.id)
                    {
                        this.gd_listServer.selectedIndex = serverIndex;
                    };
                };
            };
        }

        private function displaySelectedItem():void
        {
            if (!(this.uiApi.getUi("serverForm5")))
            {
                this.uiApi.loadUiInside("serverForm", this.ctr_serverForm, "serverForm5", {"server":this._serverInfo});
            }
            else
            {
                this.uiApi.getUi("serverForm5").uiClass.onServerSelected(this._serverInfo);
            };
            if (this._modeAutochoice)
            {
                if (!(this.uiApi.getUi("serverPopup")))
                {
                    this.uiApi.loadUi("serverPopup", "serverPopup", [this._serverInfo]);
                };
                this._modeAutochoice = false;
            };
        }

        private function startSearch():void
        {
            var searchName:String = this.inp_findAFriend.text;
            if (searchName == "")
            {
                this.stopSearch();
            }
            else
            {
                if (((((!((searchName.length < 2))) && ((searchName.length <= 30)))) && (!(this.btn_friendSearch.disabled))))
                {
                    this.sysApi.sendAction(new AcquaintanceSearch(searchName));
                    this.btn_friendSearch.disabled = true;
                    this.inp_findAFriend.disabled = true;
                    this._lockSearchTimer = new Timer(3000, 1);
                    this._lockSearchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                    this._lockSearchTimer.start();
                };
            };
        }

        private function stopSearch():void
        {
            this.inp_findAFriend.text = "";
            this._aFriendServers = new Array();
            this.displayServers();
        }

        private function populationSortFunction(a:Object, b:Object):Number
        {
            var servA:Object = this.dataApi.getServer(a.id);
            var servB:Object = this.dataApi.getServer(b.id);
            if (servA.populationId < servB.populationId)
            {
                return (-1);
            };
            if (servA.populationId == servB.populationId)
            {
                return (0);
            };
            return (1);
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_cancel:
                    this.sysApi.dispatchHook(ServerSelectionStart, [0, false]);
                    break;
                case this.btn_validate:
                    this.validateServerChoice();
                    break;
                case this.btn_autochoice:
                    this.autochoice();
                    break;
                case this.btn_friendSearch:
                    this.startSearch();
                    break;
                case this.btn_closeSearch:
                    this.stopSearch();
                    break;
                case this.btn_tabCountry:
                    this.gd_listServer.sortOn("community", Array.NUMERIC);
                    break;
                case this.btn_tabName:
                    this.gd_listServer.sortOn("name", Array.CASEINSENSITIVE);
                    break;
                case this.btn_tabState:
                    this.gd_listServer.sortOn("status", (Array.NUMERIC | Array.DESCENDING));
                    break;
                case this.btn_tabPopulation:
                    this.gd_listServer.sortOn("completion", Array.NUMERIC);
                    break;
                case this.btn_ckboxCommu:
                    this.displayServers();
                    break;
                case this.btn_ckboxMy:
                    this.displayServers();
                    break;
            };
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "validUi":
                    if (this.inp_findAFriend.haveFocus)
                    {
                        this.startSearch();
                    }
                    else
                    {
                        this.validateServerChoice();
                    };
                    break;
                case "closeUi":
                    if (this.inp_findAFriend.haveFocus)
                    {
                        this.stopSearch();
                    };
                    break;
            };
            return (false);
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_ckboxCommu:
                    tooltipText = this.uiApi.getText("ui.sersel.showCommunity");
                    break;
                case this.btn_ckboxMy:
                    tooltipText = this.uiApi.getText("ui.sersel.showMyServer");
                    break;
                case this.inp_findAFriend:
                    tooltipText = this.uiApi.getText("ui.sersel.enterAccountName");
                    break;
            };
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText), target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean):void
        {
            this._serverInfo = target.selectedItem;
            if (this._serverInfo)
            {
                this._currentServer = this.dataApi.getServer(this._serverInfo.id);
                this.displaySelectedItem();
                if (selectMethod == this.sysApi.getEnum("com.ankamagames.berilia.enums.SelectMethodEnum").DOUBLE_CLICK)
                {
                    this.validateServerChoice();
                };
            };
        }

        private function onServersList(servers:Object):void
        {
            var i:*;
            var currServer:Object;
            var servI:*;
            var currServerC:Object;
            var firstTime:Boolean = (this._aMyServers == null);
            this._aServers = new Array();
            this._aMyCommuServers = new Array();
            this._aMyServers = new Array();
            var playerCommuId:int = this.sysApi.getPlayerManager().communityId;
            for (i in servers)
            {
                currServer = this.dataApi.getServer(servers[i].id);
                if (currServer)
                {
                    if ((((currServer.communityId == playerCommuId)) || ((((((playerCommuId == 1)) || ((playerCommuId == 2)))) && ((((currServer.communityId == 1)) || ((currServer.communityId == 2))))))))
                    {
                        this._aMyCommuServers.push(servers[i]);
                    };
                    if (servers[i].charactersCount > 0)
                    {
                        this._aMyServers.push(servers[i]);
                    };
                    this._aServers.push(servers[i]);
                }
                else
                {
                    this.sysApi.log(16, (("Server " + servers[i].id) + " cannot be found in data files."));
                };
            };
            if (this._aMyCommuServers.length == 0)
            {
                for each (servI in this._aServers)
                {
                    currServerC = this.dataApi.getServer(servI.id);
                    if (((currServerC) && ((currServerC.communityId == 2))))
                    {
                        this._aMyCommuServers.push(servI);
                    };
                };
            };
            this._aServers.sort(this.populationSortFunction);
            this._aMyCommuServers.sort(this.populationSortFunction);
            this._aMyServers.sort(this.populationSortFunction);
            if (((firstTime) && (!(this._aMyServers.length))))
            {
                this.btn_ckboxMy.selected = false;
            };
            this.displayServers();
            this._serverInfo = this.gd_listServer.selectedItem;
            if (this._serverInfo)
            {
                this._currentServer = this.dataApi.getServer(this._serverInfo.id);
                this.displaySelectedItem();
            };
        }

        public function onAcquaintanceSearchError(error:String):void
        {
            var text:String;
            switch (error)
            {
                case "no_result":
                    text = this.uiApi.getText(("ui.sersel.searchError." + error), this.inp_findAFriend.text);
                    break;
                default:
                    text = this.uiApi.getText(("ui.sersel.searchError." + error));
            };
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), text, [this.uiApi.getText("ui.common.ok")]);
            this.onTimeOut(null);
        }

        public function onAcquaintanceServerList(servers:Object):void
        {
            var serverId:*;
            this._aFriendServers = new Array();
            for each (serverId in servers)
            {
                this._aFriendServers.push(serverId);
            };
            this.displayServers();
            this.onTimeOut(null);
        }

        public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object):void
        {
            this.btn_validate.disabled = false;
            this.btn_autochoice.disabled = false;
            this.btn_cancel.disabled = false;
            this.gd_listServer.disabled = false;
        }

        public function updateServerLine(data:*, componentsRef:*, selected:Boolean):void
        {
            var serverData:Object;
            if (data)
            {
                serverData = this.dataApi.getServer(data.id);
                if (!(serverData))
                {
                    componentsRef.tx_drapeau.uri = null;
                    componentsRef.tx_infoType.uri = null;
                    componentsRef.tx_infoState.uri = null;
                    componentsRef.lbl_infoName.text = "?";
                    componentsRef.lbl_infoPopulation.text = "?";
                }
                else
                {
                    componentsRef.lbl_infoName.text = data.name;
                    componentsRef.tx_infoType.uri = this.uiApi.createUri((((this._assetsUri + "type_") + serverData.gameTypeId) + ".swf"));
                    componentsRef.tx_infoState.uri = this.uiApi.createUri((((this._assetsUri + "state_") + data.status) + ".swf"));
                    if (serverData.population)
                    {
                        componentsRef.lbl_infoPopulation.cssClass = ("p" + serverData.populationId);
                        componentsRef.lbl_infoPopulation.text = serverData.population.name;
                    }
                    else
                    {
                        componentsRef.lbl_infoPopulation.cssClass = "p1";
                        componentsRef.lbl_infoPopulation.text = "?";
                    };
                    if (serverData.communityId != 99)
                    {
                        componentsRef.tx_drapeau.uri = this.uiApi.createUri((((this._assetsUri + "flags/") + serverData.communityId.toString()) + ".swf"));
                    }
                    else
                    {
                        componentsRef.tx_drapeau.uri = null;
                    };
                    componentsRef.btn_server.selected = selected;
                    componentsRef.btn_server.state = ((selected) ? (this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED) : (this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL));
                };
                if (componentsRef.btn_server.disabled)
                {
                    componentsRef.btn_server.disabled = false;
                };
            }
            else
            {
                componentsRef.tx_drapeau.uri = null;
                componentsRef.tx_infoType.uri = null;
                componentsRef.tx_infoState.uri = null;
                componentsRef.lbl_infoName.text = "";
                componentsRef.lbl_infoPopulation.text = "";
                componentsRef.btn_server.disabled = true;
            };
            if (!(componentsRef.tx_infoType.finalized))
            {
                componentsRef.tx_infoType.finalize();
            };
            if (!(componentsRef.tx_infoType.finalized))
            {
                componentsRef.tx_infoState.finalize();
            };
            if (!(componentsRef.tx_infoType.finalized))
            {
                componentsRef.tx_drapeau.finalize();
            };
        }

        public function onTimeOut(e:TimerEvent):void
        {
            this.btn_friendSearch.disabled = false;
            this.inp_findAFriend.disabled = false;
            this._lockSearchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._lockSearchTimer.stop();
            this._lockSearchTimer = null;
        }

        public function onEnterFrame():void
        {
            var clock:Number = getTimer();
            var delay:Number = (clock - this._clockStart);
            if ((((delay >= 3000)) && ((delay < 10000))))
            {
                if (this._popupInUse != 1)
                {
                    this._popupInUse = 1;
                    this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.information"), this.uiApi.getText("ui.popup.currentlyConnecting"), [this.uiApi.getText("ui.common.ok")]);
                };
            }
            else
            {
                if (delay >= 10000)
                {
                    if ((((this._popupInUse == 1)) && (this.uiApi.getUi(this._popupName))))
                    {
                        this.uiApi.unloadUi(this._popupName);
                    };
                    if (this._popupInUse != 2)
                    {
                        this._popupInUse = 2;
                        this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"), this.uiApi.getText("ui.popup.accessDenied.timeout"), [this.uiApi.getText("ui.common.wait"), this.uiApi.getText("ui.common.interrupt")], [this.onPopupWait, this.onPopupInterrupt], this.onPopupWait, this.onPopupInterrupt);
                    };
                };
            };
        }

        public function onPopupWait():void
        {
            this.sysApi.removeEventListener(this.onEnterFrame);
        }

        public function onPopupInterrupt():void
        {
            this.sysApi.sendAction(new ResetGame());
        }


    }
}//package ui

