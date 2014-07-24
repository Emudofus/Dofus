package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.RoleplayApi;
   import d2api.DataApi;
   import d2api.SoundApi;
   import d2api.UtilApi;
   import d2api.MapApi;
   import d2api.ConfigApi;
   import flash.utils.Dictionary;
   import d2components.Label;
   import d2components.Texture;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Input;
   import d2enums.SoundTypeEnum;
   import d2enums.UISoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.TeleporterTypeEnum;
   import d2enums.StatesEnum;
   import d2data.TeleportDestinationWrapper;
   import d2data.MapPosition;
   
   public class ZaapSelection extends Object
   {
      
      public function ZaapSelection() {
         this._locBtnList = new Dictionary(true);
         this._favBtnList = new Dictionary(false);
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var rpApi:RoleplayApi;
      
      public var dataApi:DataApi;
      
      public var soundApi:SoundApi;
      
      public var utilApi:UtilApi;
      
      public var mapApi:MapApi;
      
      public var configApi:ConfigApi;
      
      private var _teleportType:uint;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _locBtnList:Dictionary;
      
      private var _favBtnList:Dictionary;
      
      private var _favoriteZaap:Array;
      
      protected var _tab1List:Array;
      
      protected var _tab2List:Array;
      
      protected var _tab3List:Array;
      
      protected var _currentdataProvider:Array;
      
      protected var _currentSortCriteria:String = "name";
      
      public var lbl_zaapTitle:Label;
      
      public var lbl_availableKamasNb:Label;
      
      public var lbl_noDestination:Label;
      
      public var tx_favoritZap:Texture;
      
      public var gd_zaap:Grid;
      
      public var btn_validate:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabSpawn:ButtonContainer;
      
      public var btn_tabDest:ButtonContainer;
      
      public var btn_tabCoord:ButtonContainer;
      
      public var btn_tabCost:ButtonContainer;
      
      public var btn_tab1:ButtonContainer;
      
      public var btn_tab2:ButtonContainer;
      
      public var btn_tab3:ButtonContainer;
      
      public var btn_showUnknowZaap:ButtonContainer;
      
      public var lbl_btn_tab1:Label;
      
      public var lbl_btn_tab2:Label;
      
      public var lbl_btn_tab3:Label;
      
      public var btn_searchZaapi:ButtonContainer;
      
      public var lbl_searchZaapi:Input;
      
      public function main(params:Array) : void {
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btn_validate.soundId = UISoundEnum.OK_BUTTON;
         this.btn_close.soundId = UISoundEnum.CANCEL_BUTTON;
         this.btn_tab1.soundId = UISoundEnum.TAB;
         this.btn_tab2.soundId = UISoundEnum.TAB;
         this.btn_tab3.soundId = UISoundEnum.TAB;
         this.sysApi.addHook(ZaapList,this.onZaapList);
         this.sysApi.addHook(LeaveDialog,this.onLeaveDialog);
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.gd_zaap,"onSelectItem");
         this._teleportType = params[1];
         if(this._teleportType != TeleporterTypeEnum.TELEPORTER_SUBWAY)
         {
            this.btn_tab3.visible = false;
            this.btn_tab1.soundId = UISoundEnum.TAB;
            this.btn_tab2.soundId = UISoundEnum.TAB;
            this.lbl_btn_tab1.text = this.uiApi.getText("ui.zaap.zaap");
            this.lbl_btn_tab2.text = this.uiApi.getText("ui.zaap.prism");
         }
         this.btn_searchZaapi.visible = true;
         this.btn_showUnknowZaap.visible = true;
         this.btn_showUnknowZaap.selected = this.sysApi.getData("showUnknowZaap");
         this.lbl_availableKamasNb.text = this.utilApi.kamasToString(this.playerApi.characteristics().kamas,"");
         this.lbl_searchZaapi.text = "";
         this._favoriteZaap = this.sysApi.getData("favoriteZap");
         this.onZaapList(params[0]);
      }
      
      public function unload() : void {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateZaapLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            if(!this._locBtnList[componentsRef.btn_zaapCoord.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_zaapCoord,"onRelease");
               this.uiApi.addComponentHook(componentsRef.lbl_zaapCoord,"onRollOver");
               this.uiApi.addComponentHook(componentsRef.lbl_zaapCoord,"onRollOut");
            }
            if(!this._favBtnList[componentsRef.btn_favoritZap.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_favoritZap,"onRelease");
               this.uiApi.addComponentHook(componentsRef.btn_favoritZap,"onRollOver");
               this.uiApi.addComponentHook(componentsRef.btn_favoritZap,"onRollOut");
            }
            this._locBtnList[componentsRef.btn_zaapCoord.name] = data;
            this._favBtnList[componentsRef.btn_favoritZap.name] = data;
            componentsRef.tx_favoritZap.visible = true;
            componentsRef.lbl_zaapName.text = data.name;
            componentsRef.lbl_zaapCost.text = this.utilApi.kamasToString(data.cost);
            componentsRef.lbl_zaapCoord.text = data.coord;
            if((this._favoriteZaap) && (!(this._favoriteZaap.indexOf(data.name) == -1)))
            {
               componentsRef.tx_favoritZap.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "etoile1");
            }
            else
            {
               componentsRef.tx_favoritZap.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "etoile0");
            }
            if(data.known)
            {
               if(data.spawn)
               {
                  componentsRef.lbl_zaapName.cssClass = "p0";
                  componentsRef.lbl_zaapCoord.cssClass = "boldp0";
                  if(this.playerApi.characteristics().kamas < data.cost)
                  {
                     componentsRef.lbl_zaapCost.cssClass = "p3";
                  }
                  else
                  {
                     componentsRef.lbl_zaapCost.cssClass = "p0";
                  }
               }
               else if(this.playerApi.characteristics().kamas < data.cost)
               {
                  componentsRef.lbl_zaapCost.cssClass = "p3";
                  componentsRef.lbl_zaapName.cssClass = "p4";
                  componentsRef.lbl_zaapCoord.cssClass = "boldp4";
               }
               else
               {
                  componentsRef.lbl_zaapName.cssClass = "p";
                  componentsRef.lbl_zaapCost.cssClass = "p";
                  componentsRef.lbl_zaapCoord.cssClass = "bold";
               }
               
               componentsRef.btn_favoritZap.visible = true;
               componentsRef.btn_favoritZap.disabled = false;
            }
            else
            {
               componentsRef.lbl_zaapCost.cssClass = "p4";
               componentsRef.lbl_zaapCost.text = "--";
               componentsRef.lbl_zaapName.cssClass = "p4";
               componentsRef.lbl_zaapCoord.cssClass = "boldp4";
               componentsRef.btn_favoritZap.visible = false;
            }
            componentsRef.btn_zaap.disabled = false;
            componentsRef.btn_zaapCoord.disabled = false;
            componentsRef.btn_zaap.selected = selected;
            componentsRef.btn_zaapCoord.selected = selected;
            componentsRef.btn_favoritZap.selected = selected;
            componentsRef.btn_zaap.state = selected?StatesEnum.STATE_SELECTED:StatesEnum.STATE_NORMAL;
         }
         else
         {
            componentsRef.lbl_zaapName.text = "";
            componentsRef.lbl_zaapCost.text = "";
            componentsRef.lbl_zaapCoord.text = "";
            componentsRef.tx_favoritZap.visible = false;
            componentsRef.btn_zaap.selected = false;
            componentsRef.btn_zaap.disabled = true;
            componentsRef.btn_zaapCoord.disabled = true;
            componentsRef.btn_favoritZap.disabled = true;
         }
      }
      
      private function validateZaapChoice() : void {
         var selectedZaap:TeleportDestinationWrapper = this.gd_zaap.selectedItem;
         if(!selectedZaap)
         {
            return;
         }
         this.sysApi.sendAction(new TeleportRequest(selectedZaap.destinationType,selectedZaap.mapId,selectedZaap.cost));
      }
      
      private function sortZaapiByNameWithoutAccent(a:TeleportDestinationWrapper, b:TeleportDestinationWrapper) : Number {
         var aName:String = this.utilApi.noAccent(a.name);
         var bName:String = this.utilApi.noAccent(b.name);
         if(aName > bName)
         {
            return 1;
         }
         if(aName < bName)
         {
            return -1;
         }
         return 0;
      }
      
      private function sortArrayByCoord(a:TeleportDestinationWrapper, b:TeleportDestinationWrapper) : Number {
         var aCoordY:* = 0;
         var bCoordY:* = 0;
         var aCoordArray:Array = a.coord.split(",");
         var bCoordArray:Array = b.coord.split(",");
         var aCoordX:int = parseInt(aCoordArray[0]);
         var bCoordX:int = parseInt(bCoordArray[0]);
         if(aCoordX > bCoordX)
         {
            return 1;
         }
         if(aCoordX < bCoordX)
         {
            return -1;
         }
         aCoordY = parseInt(aCoordArray[1]);
         bCoordY = parseInt(bCoordArray[1]);
         if(aCoordY > bCoordY)
         {
            return 1;
         }
         if(aCoordY < bCoordY)
         {
            return -1;
         }
         return 0;
      }
      
      protected function sortZaap(zaapList:*, sortField:String) : Array {
         var zaap:TeleportDestinationWrapper = null;
         this._currentSortCriteria = sortField;
         if(!this._favoriteZaap)
         {
            this._favoriteZaap = new Array();
         }
         var favArray:Array = new Array();
         var noFavArray:Array = new Array();
         var unknowZaapArray:Array = new Array();
         for each(zaap in zaapList)
         {
            if(zaap.known)
            {
               if((!(this._favoriteZaap.indexOf(zaap.name) == -1)) && (zaap.known))
               {
                  favArray.push(zaap);
               }
               else
               {
                  noFavArray.push(zaap);
               }
            }
            else
            {
               unknowZaapArray.push(zaap);
            }
         }
         if(sortField == "name")
         {
            if(this._bDescendingSort)
            {
               favArray.sort(this.sortZaapiByNameWithoutAccent,Array.DESCENDING);
               noFavArray.sort(this.sortZaapiByNameWithoutAccent,Array.DESCENDING);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiByNameWithoutAccent,Array.DESCENDING);
               }
            }
            else
            {
               favArray.sort(this.sortZaapiByNameWithoutAccent);
               noFavArray.sort(this.sortZaapiByNameWithoutAccent);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiByNameWithoutAccent);
               }
            }
         }
         else if(sortField == "coord")
         {
            if(this._bDescendingSort)
            {
               favArray.sort(this.sortArrayByCoord,Array.DESCENDING);
               noFavArray.sort(this.sortArrayByCoord,Array.DESCENDING);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortArrayByCoord,Array.DESCENDING);
               }
            }
            else
            {
               favArray.sort(this.sortArrayByCoord);
               noFavArray.sort(this.sortArrayByCoord);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortArrayByCoord);
               }
            }
         }
         else if(this._bDescendingSort)
         {
            favArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            noFavArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            if(this.btn_showUnknowZaap.selected)
            {
               unknowZaapArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            }
         }
         else
         {
            favArray.sortOn(sortField,Array.NUMERIC);
            noFavArray.sortOn(sortField,Array.NUMERIC);
            if(this.btn_showUnknowZaap.selected)
            {
               unknowZaapArray.sortOn(sortField,Array.NUMERIC);
            }
         }
         
         
         if(this.btn_showUnknowZaap.selected)
         {
            noFavArray = noFavArray.concat(unknowZaapArray);
         }
         return favArray.concat(noFavArray);
      }
      
      public function onRelease(target:Object) : void {
         var p:MapPosition = null;
         var flagText:String = null;
         if(target.name.indexOf("btn_zaapCoord") != -1)
         {
            p = this.dataApi.getMapInfo(this._locBtnList[target.name].mapId);
            if(this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP)
            {
               flagText = this.uiApi.getText("ui.zaap.zaap");
            }
            else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_PRISM)
            {
               flagText = this.uiApi.getText("ui.zaap.prism");
            }
            else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
            {
               flagText = this.uiApi.getText("ui.zaap.zaapi");
            }
            
            
            flagText = flagText + (" - " + this._locBtnList[target.name].name + " (" + this._locBtnList[target.name].coord + ")");
            this.sysApi.dispatchHook(AddMapFlag,"flag_teleportPoint",flagText,p.worldMap,p.posX,p.posY,8969710);
         }
         else if(target.name.indexOf("btn_favoritZap") != -1)
         {
            if(!this._favoriteZaap)
            {
               this._favoriteZaap = new Array();
            }
            if(this._favoriteZaap.indexOf(this._favBtnList[target.name].name) == -1)
            {
               this._favoriteZaap.push(this._favBtnList[target.name].name);
            }
            else
            {
               this._favoriteZaap.splice(this._favoriteZaap.indexOf(this._favBtnList[target.name].name),1);
            }
            this.sysApi.setData("favoriteZap",this._favoriteZaap.concat());
            this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,"name");
         }
         else
         {
            switch(target)
            {
               case this.btn_tab1:
                  this.gd_zaap.dataProvider = this.sortZaap(this._tab1List,this._currentSortCriteria);
                  this._currentdataProvider = this._tab1List.concat();
                  break;
               case this.btn_tab2:
                  this.gd_zaap.dataProvider = this.gd_zaap.dataProvider = this.sortZaap(this._tab2List,this._currentSortCriteria);
                  this._currentdataProvider = this._tab2List.concat();
                  break;
               case this.btn_tab3:
                  this.gd_zaap.dataProvider = this.gd_zaap.dataProvider = this.sortZaap(this._tab3List,this._currentSortCriteria);
                  this._currentdataProvider = this._tab3List.concat();
                  break;
               case this.btn_validate:
                  this.validateZaapChoice();
                  break;
               case this.btn_close:
                  this.sysApi.sendAction(new LeaveDialogRequest());
                  break;
               case this.btn_tabSpawn:
                  if(this._currentSortCriteria == "spawn")
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,"spawn");
                  break;
               case this.btn_tabDest:
                  if(this._currentSortCriteria == "name")
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,"name");
                  break;
               case this.btn_tabCoord:
                  if(this._currentSortCriteria == "coord")
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,"coord");
                  break;
               case this.btn_tabCost:
                  if(this._currentSortCriteria == "cost")
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,"cost");
                  break;
               case this.btn_searchZaapi:
                  break;
               case this.btn_showUnknowZaap:
                  this.sysApi.setData("showUnknowZaap",this.btn_showUnknowZaap.selected);
                  this.gd_zaap.dataProvider = this.sortZaap(this._currentdataProvider,this._currentSortCriteria);
                  break;
            }
         }
         
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         if(target.name.indexOf("lbl_zaapCoord") != -1)
         {
            text = this.uiApi.getText("ui.tooltip.questMarker");
         }
         else if(target.name.indexOf("btn_favoritZap") != -1)
         {
            if((this._favoriteZaap) && (!(this._favoriteZaap.indexOf(this._favBtnList[target.name].name) == -1)))
            {
               text = this.uiApi.getText("ui.zaap.deleteFavoritTooltip");
            }
            else
            {
               text = this.uiApi.getText("ui.zaap.addFavoritTooltip");
            }
         }
         
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         var filteredDataProvider:Array = null;
         var searchCriteria:String = null;
         var tdv:TeleportDestinationWrapper = null;
         if(this.lbl_searchZaapi.haveFocus)
         {
            filteredDataProvider = new Array();
            searchCriteria = this.utilApi.noAccent(this.lbl_searchZaapi.text).toLowerCase();
            for each(tdv in this._currentdataProvider)
            {
               if(this.utilApi.noAccent(tdv.name).toLowerCase().indexOf(searchCriteria) != -1)
               {
                  filteredDataProvider.push(tdv);
               }
            }
            this.gd_zaap.dataProvider = this.sortZaap(filteredDataProvider,this._currentSortCriteria);
         }
      }
      
      public function onShortcut(s:String) : Boolean {
         switch(s)
         {
            case "validUi":
               this.validateZaapChoice();
               return true;
            case "closeUi":
               this.sysApi.sendAction(new LeaveDialogRequest());
               return true;
            default:
               return false;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(selectMethod == this.sysApi.getEnum("com.ankamagames.berilia.enums.SelectMethodEnum").DOUBLE_CLICK)
         {
            this.validateZaapChoice();
         }
      }
      
      public function onZaapList(zaapList:Object) : void {
         var i:* = undefined;
         var tdp:TeleportDestinationWrapper = null;
         this._tab1List = new Array();
         this._tab2List = new Array();
         this._tab3List = new Array();
         if(zaapList.length != 0)
         {
            for(i in zaapList)
            {
               if(zaapList[i].mapId != this.playerApi.currentMap().mapId)
               {
                  if(zaapList[i].destinationType == TeleporterTypeEnum.TELEPORTER_ZAAP)
                  {
                     this._tab1List.push(zaapList[i]);
                  }
                  else if(zaapList[i].destinationType == TeleporterTypeEnum.TELEPORTER_PRISM)
                  {
                     this._tab2List.push(zaapList[i]);
                  }
                  
               }
               else
               {
                  this._teleportType = zaapList[i].destinationType;
               }
            }
            if(this._tab1List.length == 0)
            {
               this.btn_tab1.disabled = true;
            }
            else
            {
               for each(tdp in this.dataApi.getUnknowZaaps(this._tab1List))
               {
                  if(tdp.mapId != this.playerApi.currentMap().mapId)
                  {
                     this._tab1List.push(tdp);
                  }
               }
               this.btn_tab1.disabled = false;
            }
            if(this._tab2List.length == 0)
            {
               this.btn_tab2.disabled = true;
            }
            else
            {
               this.btn_tab2.disabled = false;
            }
            if(this._tab3List.length == 0)
            {
               this.btn_tab3.disabled = true;
            }
            else
            {
               this.btn_tab3.disabled = false;
            }
            if(this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP)
            {
               this.lbl_zaapTitle.text = this.uiApi.getText("ui.zaap.zaap") + " - " + this.playerApi.currentSubArea().name;
            }
            else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_PRISM)
            {
               this.lbl_zaapTitle.text = this.uiApi.getText("ui.zaap.prism") + " - " + this.playerApi.currentSubArea().name;
            }
            
            if((!this.btn_tab1.disabled) && (this.btn_tab1.visible))
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab1,this.uiApi.me());
               this.btn_tab1.selected = true;
               this.gd_zaap.dataProvider = this.sortZaap(this._tab1List,"name");
               this._currentdataProvider = this._tab1List.concat();
            }
            else if((!this.btn_tab2.disabled) && (this.btn_tab2.visible))
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab2,this.uiApi.me());
               this.btn_tab2.selected = true;
               this.gd_zaap.dataProvider = this.sortZaap(this._tab2List,"name");
               this._currentdataProvider = this._tab2List.concat();
            }
            else if((!this.btn_tab3.disabled) && (this.btn_tab3.visible))
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab3,this.uiApi.me());
               this.btn_tab3.selected = true;
               this.gd_zaap.dataProvider = this.sortZaap(this._tab3List,"name");
               this._currentdataProvider = this._tab3List.concat();
            }
            
            
            this.gd_zaap.visible = true;
            this.lbl_noDestination.visible = false;
         }
         else
         {
            this.gd_zaap.visible = false;
            this.lbl_noDestination.visible = true;
         }
      }
      
      public function onLeaveDialog() : void {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
