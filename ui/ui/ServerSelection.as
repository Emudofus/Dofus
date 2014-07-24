package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.SoundApi;
   import d2api.ConnectionApi;
   import flash.utils.Dictionary;
   import d2components.Grid;
   import d2components.ComboBox;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.SelectMethodEnum;
   import d2enums.ServerStatusEnum;
   import d2enums.BuildTypeEnum;
   import d2data.Server;
   
   public class ServerSelection extends Object
   {
      
      public function ServerSelection() {
         this._srvButtonList = new Dictionary(true);
         super();
      }
      
      private static const NB_SERVER_SLOTS:uint = 5;
      
      public var output:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var modCommon:Object;
      
      public var soundApi:SoundApi;
      
      public var connecApi:ConnectionApi;
      
      private var _aServers:Array;
      
      private var _currentIndex:uint = 0;
      
      private var _srvButtonList:Dictionary;
      
      private var _cbServers:Array;
      
      private var _waitingForServer:int = -1;
      
      public var gd_listServer:Grid;
      
      public var cb_servers:ComboBox;
      
      public var btn_validate:ButtonContainer;
      
      public var btn_create:ButtonContainer;
      
      public var btn_arrowLeft:ButtonContainer;
      
      public var btn_arrowRight:ButtonContainer;
      
      public function main(param:Object = null) : void {
         this.btn_create.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_validate.soundId = "-1";
         this.sysApi.addHook(ServersList,this.onServersList);
         this.sysApi.addHook(SelectedServerRefused,this.onSelectedServerRefused);
         this.sysApi.addHook(SelectedServerFailed,this.onSelectedServerFailed);
         this.sysApi.addHook(TextureLoadFailed,this.onIlluLoadFailed);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.gd_listServer,"onSelectItem");
         if(!this.sysApi.hasRight())
         {
            this.cb_servers.visible = false;
         }
         this.onServersList();
         this.gd_listServer.focus();
      }
      
      private function validateServerChoice() : void {
         var serverChoiceId:* = 0;
         if((this._aServers) && (this.gd_listServer.selectedItem))
         {
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            this.btn_validate.disabled = true;
            this.btn_create.disabled = true;
            if(this._waitingForServer != -1)
            {
               serverChoiceId = this._waitingForServer;
            }
            else
            {
               serverChoiceId = this.gd_listServer.selectedItem.id;
            }
            this.sysApi.sendAction(new d2actions.ServerSelection(serverChoiceId));
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_create:
               this.sysApi.dispatchHook(ServerSelectionStart,[2,true]);
               break;
            case this.btn_validate:
               this.serverSelected();
               break;
            case this.btn_arrowLeft:
               if(this._currentIndex > 0)
               {
                  this._currentIndex--;
                  if(this._currentIndex == 0)
                  {
                     this.btn_arrowLeft.disabled = true;
                  }
                  this.btn_arrowRight.disabled = false;
                  this.gd_listServer.dataProvider = this._aServers.slice(this._currentIndex,this._currentIndex + NB_SERVER_SLOTS);
               }
               break;
            case this.btn_arrowRight:
               if(this._currentIndex <= this._aServers.length - NB_SERVER_SLOTS)
               {
                  this._currentIndex++;
                  if(this._currentIndex == this._aServers.length - NB_SERVER_SLOTS)
                  {
                     this.btn_arrowRight.disabled = true;
                  }
                  this.btn_arrowLeft.disabled = false;
                  this.gd_listServer.dataProvider = this._aServers.slice(this._currentIndex,this._currentIndex + NB_SERVER_SLOTS);
               }
               break;
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               this.serverSelected();
               break;
         }
         return false;
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if((!(selectMethod == SelectMethodEnum.AUTO)) && (!(selectMethod == SelectMethodEnum.WHEEL)) && (target == this.cb_servers) && (!(this.cb_servers.value.id == 0)))
         {
            this.soundApi.playSound(SoundTypeEnum.OK_BUTTON);
            this.btn_validate.disabled = true;
            this.btn_create.disabled = true;
            this.sysApi.sendAction(new d2actions.ServerSelection(this.cb_servers.value.id));
         }
         else if((!(target == this.cb_servers)) && (target.selectedItem))
         {
            if(selectMethod == this.sysApi.getEnum("com.ankamagames.berilia.enums.SelectMethodEnum").DOUBLE_CLICK)
            {
               this.serverSelected();
            }
         }
         
      }
      
      private function serverSelected() : void {
         switch(this.gd_listServer.selectedItem.status)
         {
            case ServerStatusEnum.STARTING:
            case ServerStatusEnum.OFFLINE:
            case ServerStatusEnum.SAVING:
            case ServerStatusEnum.NOJOIN:
            case ServerStatusEnum.STOPING:
            case ServerStatusEnum.FULL:
               this.btn_validate.disabled = false;
               this.btn_create.disabled = true;
               this._waitingForServer = this.gd_listServer.selectedItem.id;
               this.gd_listServer.updateItems();
               break;
            default:
               this._waitingForServer = -1;
               this.validateServerChoice();
         }
      }
      
      public function updateServerLine(data:*, componentsRef:*, selected:Boolean) : void {
         var serverData:Object = null;
         if(data)
         {
            serverData = this.dataApi.getServer(data.id);
            if(!serverData)
            {
               componentsRef.tx_illu.uri = null;
               componentsRef.tx_status.uri = null;
               componentsRef.tx_type.uri = null;
               componentsRef.tx_nbCharacters.uri = null;
               componentsRef.lbl_name.text = "";
               componentsRef.lbl_nbCharacters.text = "";
               componentsRef.lbl_status.text = "";
               componentsRef.tx_waitingIllu.visible = false;
               componentsRef.ctr_server.visible = false;
            }
            else
            {
               this._srvButtonList[componentsRef.btn_server.name] = data;
               this.uiApi.addComponentHook(componentsRef.btn_server,"onRollOver");
               this.uiApi.addComponentHook(componentsRef.btn_server,"onRollOut");
               componentsRef.tx_illu.dispatchMessages = true;
               componentsRef.tx_illu.finalized = true;
               if(!componentsRef.tx_illus)
               {
                  if(this.sysApi.getBuildType() == BuildTypeEnum.DEBUG)
                  {
                     componentsRef.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_0");
                  }
                  else
                  {
                     componentsRef.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_" + data.id);
                  }
               }
               if(this._waitingForServer == data.id)
               {
                  componentsRef.tx_waitingIllu.visible = true;
               }
               else
               {
                  componentsRef.tx_waitingIllu.visible = false;
               }
               componentsRef.lbl_name.text = serverData.name;
               componentsRef.tx_status.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "state_" + data.status);
               componentsRef.lbl_status.text = this.uiApi.me().getConstant("status_" + data.status);
               if(data.charactersCount > 5)
               {
                  componentsRef.tx_nbCharacters.gotoAndStop = "7";
                  componentsRef.lbl_nbCharacters.text = "x " + data.charactersCount;
               }
               else
               {
                  componentsRef.tx_nbCharacters.gotoAndStop = (data.charactersCount + 1).toString();
                  componentsRef.lbl_nbCharacters.text = "";
               }
               if((!componentsRef.tx_type) || (!componentsRef.tx_type.uri))
               {
                  componentsRef.tx_type.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "type_" + serverData.gameTypeId);
               }
               componentsRef.btn_server.selected = selected;
               componentsRef.btn_server.state = selected?this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_SELECTED:this.sysApi.getEnum("com.ankamagames.berilia.enums.StatesEnum").STATE_NORMAL;
            }
         }
         else
         {
            componentsRef.ctr_server.visible = false;
         }
      }
      
      public function onIlluLoadFailed(target:Object, behavior:Object) : void {
         behavior.cancel = true;
         target.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "assets.swf|illu_0");
      }
      
      private function onServersList(servers:Object = null) : void {
         var server:Object = null;
         var currServer:Server = null;
         var serverObject:Object = null;
         this._aServers = new Array();
         this._cbServers = new Array();
         this._cbServers.push(
            {
               "label":this.uiApi.getText("ui.sersel.title"),
               "id":0,
               "order":"a"
            });
         for each(server in this.connecApi.getUsedServers())
         {
            if((!(this._waitingForServer == -1)) && (server.id == this._waitingForServer) && (server.status == ServerStatusEnum.ONLINE))
            {
               this.validateServerChoice();
            }
            currServer = this.dataApi.getServer(server.id);
            if(currServer)
            {
               this._aServers.push(server);
               serverObject = 
                  {
                     "label":currServer.name,
                     "id":server.id,
                     "order":currServer.name
                  };
               this._cbServers.push(serverObject);
            }
            else
            {
               this.sysApi.log(16,"Server " + server.id + " not found in data files.");
            }
         }
         this._aServers.sortOn("date",Array.DESCENDING | Array.NUMERIC);
         this._cbServers.sortOn("order",Array.CASEINSENSITIVE);
         this.cb_servers.dataProvider = this._cbServers;
         if(this._aServers.length <= NB_SERVER_SLOTS)
         {
            this.btn_arrowLeft.disabled = true;
            this.btn_arrowRight.disabled = true;
            this._currentIndex = 0;
            this.gd_listServer.dataProvider = this._aServers;
         }
         else
         {
            if(this._currentIndex + NB_SERVER_SLOTS > this._aServers.length)
            {
               this._currentIndex = this._aServers.length - NB_SERVER_SLOTS;
            }
            if(this._currentIndex == 0)
            {
               this.btn_arrowLeft.disabled = true;
               this.btn_arrowRight.disabled = false;
            }
            if(this._currentIndex == this._aServers.length - NB_SERVER_SLOTS)
            {
               this.btn_arrowLeft.disabled = false;
               this.btn_arrowRight.disabled = true;
            }
            this.gd_listServer.dataProvider = this._aServers.slice(this._currentIndex,this._currentIndex + NB_SERVER_SLOTS);
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         if(this._srvButtonList[target.name].id == this._waitingForServer)
         {
            text = this.uiApi.getText("ui.sersel.waitForServerTooltip");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectedServerRefused(serverId:int, error:String, selectableServers:Object) : void {
         this.btn_validate.disabled = false;
         this.btn_create.disabled = false;
         this.cb_servers.value = this._cbServers[0];
      }
      
      public function onSelectedServerFailed() : void {
         this.btn_validate.disabled = false;
         this.btn_create.disabled = false;
         this.cb_servers.value = this._cbServers[0];
      }
   }
}
