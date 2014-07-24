package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.TooltipApi;
   import d2api.PlayedCharacterApi;
   import d2api.DataApi;
   import d2api.UtilApi;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.Input;
   import d2components.EntityDisplayer;
   import d2components.ButtonContainer;
   import d2enums.ComponentHookList;
   import d2hooks.*;
   import d2actions.*;
   import d2data.Title;
   import d2data.Ornament;
   import d2enums.AggressableStatusEnum;
   import d2enums.StrataEnum;
   import d2enums.LocationEnum;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   
   public class TitleTab extends Object
   {
      
      public function TitleTab() {
         this._allTitles = new Array();
         this._myTitles = new Array();
         this._myTitlesIds = new Array();
         this._allOrnaments = new Array();
         this._myOrnaments = new Array();
         this._myOrnamentsIds = new Array();
         super();
      }
      
      public static const TAB_TITLE:uint = 0;
      
      public static const TAB_ORNAMENT:uint = 1;
      
      public static const TOOLTIP_CHARA:String = "tooltipCharacter";
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var tooltipApi:TooltipApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var dataApi:DataApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      private var _noneText:String;
      
      private var _nCurrentTab:int = -1;
      
      private var _titleIdAtStart:int;
      
      private var _ornamentIdAtStart:int;
      
      private var _titleId:int;
      
      private var _ornamentId:int;
      
      private var _allTitles:Array;
      
      private var _myTitles:Array;
      
      private var _myTitlesIds:Array;
      
      private var _dataTitles:Object;
      
      private var _allOrnaments:Array;
      
      private var _myOrnaments:Array;
      
      private var _myOrnamentsIds:Array;
      
      private var _dataOrnaments:Object;
      
      private var _searchCriteria:String;
      
      private var _showAll:Boolean = false;
      
      private var _tooltipInfos:Object;
      
      private var _waitingForTitlesMsg:Boolean;
      
      private var _waitingForOrnsMsg:Boolean;
      
      private var _waitingForTooltipUpdate:Boolean;
      
      private var _param:Object;
      
      private var _wingsOut:Boolean = false;
      
      private var _direction:int = 2;
      
      public var ctr_search:GraphicContainer;
      
      public var ctr_warning:GraphicContainer;
      
      public var gd_titles:Grid;
      
      public var gd_orns:Grid;
      
      public var inp_search:Input;
      
      public var ed_chara:EntityDisplayer;
      
      public var btn_title:ButtonContainer;
      
      public var btn_ornament:ButtonContainer;
      
      public var btn_reset:ButtonContainer;
      
      public var btn_save:ButtonContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var btn_showAll:ButtonContainer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public function main(oParam:Object = null) : void {
         var myTitle:Object = null;
         var myOrnament:Object = null;
         var myTitles:Object = null;
         var myOrnaments:Object = null;
         this.sysApi.addHook(KeyUp,this.onKeyUp);
         this.sysApi.addHook(TitlesListUpdated,this.onTitlesListUpdated);
         this.sysApi.addHook(OrnamentsListUpdated,this.onOrnamentsListUpdated);
         this.sysApi.addHook(TitleUpdated,this.onTitleUpdated);
         this.sysApi.addHook(OrnamentUpdated,this.onOrnamentUpdated);
         this.sysApi.addHook(OpenBook,this.onOpenTitle);
         this.uiApi.addComponentHook(this.gd_titles,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_orns,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ed_chara,ComponentHookList.ON_ENTITY_READY);
         this._noneText = this.uiApi.getText("ui.common.none");
         this._dataTitles = this.dataApi.getTitles();
         this._dataOrnaments = this.dataApi.getOrnaments();
         this.btn_save.disabled = true;
         this.ctr_warning.visible = false;
         this._showAll = this.sysApi.getData("showAllTitlesAndOrnaments");
         this.btn_showAll.selected = this._showAll;
         this._param = oParam;
         if(!this.playerApi.titlesOrnamentsAskedBefore())
         {
            this._waitingForOrnsMsg = true;
            this._waitingForTitlesMsg = true;
            this.sysApi.sendAction(new TitlesAndOrnamentsListRequest());
         }
         else
         {
            myTitle = this.playerApi.getTitle();
            if(myTitle)
            {
               this._titleIdAtStart = myTitle.id;
               this._titleId = this._titleIdAtStart;
            }
            myOrnament = this.playerApi.getOrnament();
            if(myOrnament)
            {
               this._ornamentIdAtStart = myOrnament.id;
               this._ornamentId = this._ornamentIdAtStart;
            }
            myTitles = this.playerApi.getKnownTitles();
            myOrnaments = this.playerApi.getKnownOrnaments();
            this._waitingForOrnsMsg = true;
            if((myTitles) && (myTitles.length > 0))
            {
               this.onTitlesListUpdated(myTitles);
            }
            else
            {
               this.onTitlesListUpdated(new Array());
            }
            if((myOrnaments) && (myOrnaments.length > 0))
            {
               this.onOrnamentsListUpdated(myOrnaments);
            }
            else
            {
               this.onOrnamentsListUpdated(new Array());
            }
         }
         if((this._param && this._param.id) && (!this._param.idIsTitle) || ((!this._param) || (!this._param.id)) && (Grimoire.getInstance().titleCurrentTab == 1))
         {
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_ornament,this.uiApi.me());
            this.btn_ornament.selected = true;
            this.onRelease(this.btn_ornament);
         }
         else
         {
            this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_title,this.uiApi.me());
            this.btn_title.selected = true;
            this.onRelease(this.btn_title);
         }
         this.ed_chara.look = this.playerApi.getPlayedCharacterInfo().entityLook;
         this.ed_chara.direction = this._direction;
         this.ed_chara.scaleX = 2;
         this.ed_chara.scaleY = 2;
         this.ctr_search.visible = true;
         if((!this._waitingForOrnsMsg) && (!this._waitingForTitlesMsg))
         {
            this.displayTooltip(true,true);
            if((this._param) && (this._param.id))
            {
               this.onOpenTitle("titleTab",
                  {
                     "forceOpen":true,
                     "id":this._param.id,
                     "idIsTitle":this._param.idIsTitle
                  });
            }
         }
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip(TOOLTIP_CHARA);
      }
      
      public function updateTitle(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_name.text = data.name;
            if((this._showAll) && (!(data.id == 0)) && (this._myTitlesIds.indexOf(data.id) == -1))
            {
               componentsRef.lbl_name.cssClass = "p4";
            }
            else
            {
               componentsRef.lbl_name.cssClass = "p";
            }
            componentsRef.btn_title.selected = selected;
            componentsRef.btn_title.visible = true;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.btn_title.selected = false;
            componentsRef.btn_title.visible = false;
         }
      }
      
      public function updateOrnament(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.lbl_name.text = data.name;
            if((this._showAll) && (!(data.id == 0)) && (this._myOrnamentsIds.indexOf(data.id) == -1))
            {
               componentsRef.lbl_name.cssClass = "p4";
            }
            else
            {
               componentsRef.lbl_name.cssClass = "p";
            }
            if(data.id > 0)
            {
               componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ornamentIconPath") + data.iconId + ".png");
            }
            else
            {
               componentsRef.tx_picto.uri = null;
            }
            componentsRef.tx_slot.visible = true;
            componentsRef.btn_orn.selected = selected;
            componentsRef.btn_orn.visible = true;
            if(this._wingsOut)
            {
               componentsRef.btn_orn.mouseEnabled = false;
               componentsRef.btn_orn.mouseChildren = false;
               componentsRef.tx_picto.disabled = true;
            }
            else
            {
               componentsRef.btn_orn.mouseEnabled = true;
               componentsRef.btn_orn.mouseChildren = true;
               componentsRef.tx_picto.disabled = false;
            }
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.tx_slot.visible = false;
            componentsRef.btn_orn.selected = false;
            componentsRef.btn_orn.visible = false;
            componentsRef.btn_orn.disabled = false;
         }
      }
      
      private function openSelectedTab(tab:int) : void {
         if(this._nCurrentTab == tab)
         {
            return;
         }
         this._nCurrentTab = tab;
         Grimoire.getInstance().titleCurrentTab = this._nCurrentTab;
         if(this._nCurrentTab == TAB_TITLE)
         {
            this.gd_titles.visible = true;
            this.gd_orns.visible = false;
         }
         else if(this._nCurrentTab == TAB_ORNAMENT)
         {
            this.gd_titles.visible = false;
            this.gd_orns.visible = true;
         }
         
      }
      
      private function updateGrid(tab:int = 0, force:Boolean = false) : void {
         var titles:Array = null;
         var titleArray:Object = null;
         var t:Title = null;
         var orns:Array = null;
         var ornArray:Object = null;
         var o:Ornament = null;
         if((this._nCurrentTab == TAB_TITLE) || (force) && (tab == TAB_TITLE))
         {
            titles = new Array();
            if(!this._searchCriteria)
            {
               titles.push(
                  {
                     "id":0,
                     "name":this._noneText
                  });
            }
            if(this._showAll)
            {
               titleArray = this._allTitles;
            }
            else
            {
               titleArray = this._myTitles;
            }
            for each(t in titleArray)
            {
               if((!this._searchCriteria) || (this._searchCriteria) && (!(this.utilApi.noAccent(t.name).toLowerCase().indexOf(this.utilApi.noAccent(this._searchCriteria)) == -1)))
               {
                  titles.push(t);
               }
            }
            this.gd_titles.dataProvider = titles;
            this.selectMineInGrid();
         }
         else if((this._nCurrentTab == TAB_ORNAMENT) || (force) && (tab == TAB_ORNAMENT))
         {
            orns = new Array();
            if(!this._searchCriteria)
            {
               orns.push(
                  {
                     "id":0,
                     "name":this._noneText
                  });
            }
            if(this._showAll)
            {
               ornArray = this._allOrnaments;
            }
            else
            {
               ornArray = this._myOrnaments;
            }
            for each(o in ornArray)
            {
               if((!this._searchCriteria) || (!(this.utilApi.noAccent(o.name).toLowerCase().indexOf(this.utilApi.noAccent(this._searchCriteria)) == -1)))
               {
                  orns.push(o);
               }
            }
            this.gd_orns.dataProvider = orns;
            this.selectMineInGrid();
         }
         
      }
      
      private function updateCategories() : void {
      }
      
      private function displayTooltip(updateTitle:Boolean = false, updateOrnament:Boolean = false) : void {
         var trueInfos:Object = null;
         var titleName:String = null;
         var title:Title = null;
         var assetId:* = 0;
         var ornament:Ornament = null;
         if(this.ed_chara.width == 0)
         {
            return;
         }
         this.checkSaveButton();
         if((!this._tooltipInfos) || (this._tooltipInfos.titleColor == null))
         {
            trueInfos = this.playerApi.getEntityTooltipInfos();
            if(trueInfos)
            {
               this._tooltipInfos = 
                  {
                     "titleName":trueInfos.titleName,
                     "titleColor":trueInfos.titleColor,
                     "ornamentAssetId":trueInfos.ornamentAssetId,
                     "wingsEffect":trueInfos.wingsEffect,
                     "infos":trueInfos.infos
                  };
            }
            else
            {
               this._tooltipInfos = 
                  {
                     "titleName":"",
                     "titleColor":"",
                     "ornamentAssetId":0,
                     "wingsEffect":0,
                     "infos":{"name":this.playerApi.getPlayedCharacterInfo().name}
                  };
            }
            if((this.playerApi.characteristics().alignmentInfos) && ((this.playerApi.characteristics().alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE) || (this.playerApi.characteristics().alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)))
            {
               this.ctr_warning.visible = true;
               this._wingsOut = true;
            }
            else
            {
               this.ctr_warning.visible = false;
               this._wingsOut = false;
            }
         }
         if(updateTitle)
         {
            titleName = "";
            if(this._titleId > 0)
            {
               title = this.dataApi.getTitle(this._titleId);
               if(title)
               {
                  titleName = "« " + title.name + " »";
               }
            }
            else
            {
               titleName = "";
            }
            this._tooltipInfos.titleName = titleName;
         }
         if(updateOrnament)
         {
            assetId = 0;
            if(this._ornamentId > 0)
            {
               ornament = this.dataApi.getOrnament(this._ornamentId);
               assetId = ornament.assetId;
            }
            this._tooltipInfos.ornamentAssetId = assetId;
         }
         var tmp:* = this.ed_chara["getBounds"](this.uiApi.getUi("mapInfo"));
         this.uiApi.hideTooltip(TOOLTIP_CHARA);
         this.uiApi.showTooltip(this._tooltipInfos,tmp,false,TOOLTIP_CHARA,7,1,20,"player",null,null,null,false,StrataEnum.STRATA_MEDIUM,1.5);
      }
      
      private function checkSaveButton() : void {
         if((this.playerApi.isInFight()) || ((this._titleId == this._titleIdAtStart) || (this._titleId > 0) && (this._myTitlesIds.indexOf(this._titleId) == -1)) && ((this._ornamentId == this._ornamentIdAtStart) || (this._ornamentId > 0) && (this._myOrnamentsIds.indexOf(this._ornamentId) == -1)))
         {
            this.btn_save.disabled = true;
         }
         else
         {
            this.btn_save.disabled = false;
         }
      }
      
      private function selectMineInGrid() : void {
         var found:* = false;
         var title:Object = null;
         var ornament:Object = null;
         var index:int = 0;
         if(this._nCurrentTab == TAB_TITLE)
         {
            for each(title in this.gd_titles.dataProvider)
            {
               if(title.id == this._titleId)
               {
                  found = true;
                  break;
               }
               index++;
            }
            if(!found)
            {
               index = 0;
            }
            this.gd_titles.selectedIndex = index;
         }
         else
         {
            for each(ornament in this.gd_orns.dataProvider)
            {
               if(ornament.id == this._ornamentId)
               {
                  found = true;
                  break;
               }
               index++;
            }
            if(!found)
            {
               index = 0;
            }
            this.gd_orns.selectedIndex = index;
         }
      }
      
      private function wheelChara(sens:int) : void {
         this._direction = (this._direction + sens + 8) % 8;
         this.ed_chara.direction = this._direction;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_title:
               this.openSelectedTab(TAB_TITLE);
               this.updateGrid();
               break;
            case this.btn_ornament:
               this.openSelectedTab(TAB_ORNAMENT);
               this.updateGrid();
               break;
            case this.btn_resetSearch:
               this._searchCriteria = null;
               this.inp_search.text = "";
               this.updateGrid();
               break;
            case this.btn_reset:
               this._titleId = this._titleIdAtStart;
               this._ornamentId = this._ornamentIdAtStart;
               this.checkSaveButton();
               this.displayTooltip(true,true);
               this.selectMineInGrid();
               break;
            case this.btn_save:
               if(this._titleId != this._titleIdAtStart)
               {
                  this.sysApi.sendAction(new TitleSelectRequest(this._titleId));
               }
               if(this._ornamentId != this._ornamentIdAtStart)
               {
                  this.sysApi.sendAction(new OrnamentSelectRequest(this._ornamentId));
               }
               break;
            case this.btn_showAll:
               this._showAll = this.btn_showAll.selected;
               this.sysApi.setData("showAllTitlesAndOrnaments",this._showAll);
               this.updateGrid();
               break;
            case this.btn_leftArrow:
               this.wheelChara(1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(-1);
               break;
         }
      }
      
      public function onRollOver(target:Object) : void {
         var text:String = null;
         var pos:Object = 
            {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
         switch(target)
         {
            case this.inp_search:
               text = this.uiApi.getText("ui.common.searchFilterTooltip");
               break;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var titleId:* = 0;
         var ornamentId:* = 0;
         if(selectMethod != GridItemSelectMethodEnum.AUTO)
         {
            switch(target)
            {
               case this.gd_titles:
                  titleId = target.selectedItem.id;
                  if((!(titleId == this._titleId)) || (this._waitingForTooltipUpdate))
                  {
                     this._waitingForTooltipUpdate = false;
                     this._titleId = titleId;
                     this.displayTooltip(true,false);
                  }
                  break;
               case this.gd_orns:
                  ornamentId = target.selectedItem.id;
                  if((!(ornamentId == this._ornamentId)) || (this._waitingForTooltipUpdate))
                  {
                     this._waitingForTooltipUpdate = false;
                     this._ornamentId = ornamentId;
                     this.displayTooltip(false,true);
                  }
                  break;
            }
         }
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
      }
      
      public function onEntityReady(target:Object) : void {
         if((target == this.ed_chara) && (!this._waitingForOrnsMsg) && (!this._waitingForTitlesMsg))
         {
            this.displayTooltip();
         }
      }
      
      public function onKeyUp(target:Object, keyCode:uint) : void {
         if((this.ctr_search.visible) && (this.inp_search.haveFocus))
         {
            if(this.inp_search.text.length > 2)
            {
               this._searchCriteria = this.inp_search.text.toLowerCase();
               this.updateGrid();
            }
            else
            {
               if(this._searchCriteria)
               {
                  this._searchCriteria = null;
               }
               if(this._nCurrentTab == TAB_TITLE)
               {
                  this.gd_titles.dataProvider = new Array();
               }
               else if(this._nCurrentTab == TAB_ORNAMENT)
               {
                  this.updateGrid();
               }
               
            }
         }
      }
      
      public function onTitleUpdated(titleId:int) : void {
         this._titleIdAtStart = titleId;
         this._titleId = this._titleIdAtStart;
         this.checkSaveButton();
      }
      
      public function onOrnamentUpdated(ornamentId:int) : void {
         this._ornamentIdAtStart = ornamentId;
         this._ornamentId = this._ornamentIdAtStart;
         this.checkSaveButton();
      }
      
      public function onTitlesListUpdated(titlesList:Object) : void {
         var tId:* = 0;
         var t:Title = null;
         var myTitle:Object = null;
         var myOrnament:Object = null;
         this._myTitlesIds = new Array();
         this._myTitles = new Array();
         for each(tId in titlesList)
         {
            this._myTitlesIds.push(tId);
            this._myTitles.push(this.dataApi.getTitle(tId));
         }
         for each(t in this._dataTitles)
         {
            if((t.visible) || (!(this._myTitlesIds.indexOf(t.id) == -1)))
            {
               this._allTitles.push(t);
            }
         }
         this._waitingForTitlesMsg = false;
         if(!this._waitingForOrnsMsg)
         {
            myTitle = this.playerApi.getTitle();
            if(myTitle)
            {
               this._titleIdAtStart = myTitle.id;
               this._titleId = this._titleIdAtStart;
            }
            myOrnament = this.playerApi.getOrnament();
            if(myOrnament)
            {
               this._ornamentIdAtStart = myOrnament.id;
               this._ornamentId = this._ornamentIdAtStart;
            }
            this.updateGrid(TAB_TITLE,true);
            this.displayTooltip(true,true);
            if((this._param) && (this._param.id))
            {
               this.onOpenTitle("titleTab",
                  {
                     "forceOpen":true,
                     "id":this._param.id,
                     "idIsTitle":this._param.idIsTitle
                  });
            }
         }
      }
      
      public function onOrnamentsListUpdated(ornsList:Object) : void {
         var oId:* = 0;
         var o:Ornament = null;
         var myTitle:Object = null;
         var myOrnament:Object = null;
         for each(oId in ornsList)
         {
            if(this._myOrnamentsIds.indexOf(oId) == -1)
            {
               this._myOrnamentsIds.push(oId);
               this._myOrnaments.push(this.dataApi.getOrnament(oId));
            }
         }
         this._myOrnaments.sortOn("order",Array.NUMERIC);
         for each(o in this._dataOrnaments)
         {
            if((o.visible) || (!(this._myOrnamentsIds.indexOf(o.id) == -1)))
            {
               this._allOrnaments.push(o);
            }
         }
         this._allOrnaments.sortOn("order",Array.NUMERIC);
         this._waitingForOrnsMsg = false;
         if(!this._waitingForTitlesMsg)
         {
            myTitle = this.playerApi.getTitle();
            if(myTitle)
            {
               this._titleIdAtStart = myTitle.id;
               this._titleId = this._titleIdAtStart;
            }
            myOrnament = this.playerApi.getOrnament();
            if(myOrnament)
            {
               this._ornamentIdAtStart = myOrnament.id;
               this._ornamentId = this._ornamentIdAtStart;
            }
            this.updateGrid(TAB_ORNAMENT,true);
            this.displayTooltip(true,true);
            if((this._param) && (this._param.id))
            {
               this.onOpenTitle("titleTab",
                  {
                     "forceOpen":true,
                     "id":this._param.id,
                     "idIsTitle":this._param.idIsTitle
                  });
            }
         }
      }
      
      private function onOpenTitle(tab:String = null, param:Object = null) : void {
         var index:* = 0;
         if((tab == "titleTab") && (param) && (param.forceOpen))
         {
            index = 0;
            if(param.idIsTitle)
            {
               this.btn_title.selected = true;
               this.openSelectedTab(TAB_TITLE);
               this._titleId = param.id;
            }
            else
            {
               this.btn_ornament.selected = true;
               this.openSelectedTab(TAB_ORNAMENT);
               this._ornamentId = param.id;
            }
            this._waitingForTooltipUpdate = true;
            this.updateGrid();
         }
      }
   }
}
