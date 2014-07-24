package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import flash.utils.Dictionary;
   import d2components.GraphicContainer;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Label;
   import d2data.GuildHouseWrapper;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2data.SubArea;
   
   public class GuildHouses extends Object
   {
      
      public function GuildHouses() {
         this._infoBtnList = new Dictionary(true);
         this._lblCoordList = new Dictionary(true);
         super();
      }
      
      private static var _nCurrentTab:int = -1;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      private var _housesList:Array;
      
      private var _skillsList:Array;
      
      private var _rightsList:Array;
      
      private var _selectedHouse:Object;
      
      private var _bHouseDescendingSort:Boolean = false;
      
      private var _bOwnerDescendingSort:Boolean = false;
      
      private var _bCoordDescendingSort:Boolean = false;
      
      private var _infoBtnList:Dictionary;
      
      private var _lblCoordList:Dictionary;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_infos:GraphicContainer;
      
      public var grid_house:Grid;
      
      public var btn_tabHouse:ButtonContainer;
      
      public var btn_tabOwner:ButtonContainer;
      
      public var btn_tabCoord:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btn_join:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_rights:ButtonContainer;
      
      public var btn_skills:ButtonContainer;
      
      public var grid_skill:Grid;
      
      public function main(... params) : void {
         var house:GuildHouseWrapper = null;
         this.btn_tabHouse.soundId = SoundEnum.TAB;
         this.btn_tabOwner.soundId = SoundEnum.TAB;
         this.btn_tabCoord.soundId = SoundEnum.TAB;
         this.btn_join.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_rights.soundId = SoundEnum.TAB;
         this.btn_skills.soundId = SoundEnum.TAB;
         this.sysApi.addHook(GuildHousesUpdate,this.onGuildHousesUpdate);
         this.sysApi.addHook(GuildHouseAdd,this.onGuildHouseAdd);
         this.sysApi.addHook(GuildHouseRemoved,this.onGuildHouseRemoved);
         this.sysApi.addHook(CurrentMap,this.onCurrentMap);
         this.uiApi.addComponentHook(this.grid_house,"onSelectItem");
         this.uiApi.addComponentHook(this.btn_rights,"onRelease");
         this.uiApi.addComponentHook(this.btn_skills,"onRelease");
         this.ctr_infos.visible = false;
         this._skillsList = new Array();
         this._rightsList = new Array();
         this._housesList = new Array();
         for each(house in this.socialApi.getGuildHouses())
         {
            this._housesList.push(house);
         }
         if(_nCurrentTab != -1)
         {
            this.refreshGrid();
         }
         this.btn_join.disabled = true;
      }
      
      public function unload() : void {
      }
      
      public function updateSkillLine(data:*, components:*, selected:Boolean) : void {
         if(data)
         {
            components.lbl_skill.text = data;
         }
         else
         {
            components.lbl_skill.text = "";
         }
      }
      
      public function updateHouseLine(data:*, componentsRef:*, selected:Boolean) : void {
         if(!this._infoBtnList[componentsRef.btn_info])
         {
            this.uiApi.addComponentHook(componentsRef.btn_info,"onRelease");
         }
         if(!this._lblCoordList[componentsRef.lbl_coord.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_coord,"onRollOver");
            this.uiApi.addComponentHook(componentsRef.lbl_coord,"onRollOut");
         }
         this._lblCoordList[componentsRef.lbl_coord.name] = data;
         this._infoBtnList[componentsRef.btn_info] = data;
         if(data)
         {
            componentsRef.btn_house.disabled = false;
            componentsRef.btn_house.selected = selected;
            componentsRef.lbl_house.text = data.houseName;
            componentsRef.lbl_owner.text = data.ownerName;
            componentsRef.lbl_coord.text = data.worldX + "," + data.worldY;
            componentsRef.btn_house.visible = true;
            componentsRef.btn_info.visible = true;
         }
         else
         {
            componentsRef.btn_house.selected = false;
            componentsRef.lbl_house.text = "";
            componentsRef.lbl_owner.text = "";
            componentsRef.lbl_coord.text = "";
            componentsRef.btn_house.visible = false;
            componentsRef.btn_info.visible = false;
         }
      }
      
      private function onGuildHousesUpdate() : void {
         var house:GuildHouseWrapper = null;
         this._housesList = new Array();
         for each(house in this.socialApi.getGuildHouses())
         {
            this._housesList.push(house);
         }
         this.refreshGrid();
      }
      
      private function onGuildHouseAdd(house:GuildHouseWrapper) : void {
         this._housesList.push(house);
         this.refreshGrid();
      }
      
      private function onGuildHouseRemoved(houseId:uint) : void {
         this.onGuildHousesUpdate();
      }
      
      private function onHouseSelected(house:Object) : void {
         var skill:String = null;
         var right:String = null;
         this._selectedHouse = house;
         this.btn_join.disabled = false;
         this._skillsList = new Array();
         this._rightsList = new Array();
         for each(skill in house.skillListString)
         {
            this._skillsList.push(skill);
         }
         for each(right in house.guildshareString)
         {
            this._rightsList.push(right);
         }
         this.lbl_title.text = house.houseName;
         this.updateSelectedTab();
      }
      
      private function onCurrentMap(mapId:uint) : void {
         this.uiApi.unloadUi("socialBase");
      }
      
      private function updateSelectedTab() : void {
         if(_nCurrentTab == 0)
         {
            this.grid_skill.dataProvider = this._rightsList;
         }
         else if(_nCurrentTab == 1)
         {
            this.grid_skill.dataProvider = this._skillsList;
         }
         
      }
      
      private function refreshGrid() : void {
         this.grid_house.dataProvider = this._housesList;
         if(this._housesList.length == 0)
         {
            this.grid_house.selectedIndex = -1;
         }
         else
         {
            this.grid_house.selectedIndex = 0;
         }
         this.btn_rights.selected = true;
         _nCurrentTab = 0;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_close:
               this.ctr_infos.visible = false;
               break;
            case this.btn_tabHouse:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bOwnerDescendingSort = false;
               this._bCoordDescendingSort = false;
               if(this._bHouseDescendingSort)
               {
                  this.grid_house.sortOn("houseName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("houseName",Array.CASEINSENSITIVE);
               }
               this._bHouseDescendingSort = !this._bHouseDescendingSort;
               break;
            case this.btn_tabOwner:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bHouseDescendingSort = false;
               this._bCoordDescendingSort = false;
               if(this._bOwnerDescendingSort)
               {
                  this.grid_house.sortOn("ownerName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("ownerName",Array.CASEINSENSITIVE);
               }
               this._bOwnerDescendingSort = !this._bOwnerDescendingSort;
               break;
            case this.btn_tabCoord:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bHouseDescendingSort = false;
               this._bOwnerDescendingSort = false;
               if(this._bCoordDescendingSort)
               {
                  this.grid_house.sortOn("worldX",Array.NUMERIC | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("worldX",Array.NUMERIC);
               }
               this._bCoordDescendingSort = !this._bCoordDescendingSort;
               break;
            case this.btn_rights:
               _nCurrentTab = 0;
               this.updateSelectedTab();
               break;
            case this.btn_skills:
               _nCurrentTab = 1;
               this.updateSelectedTab();
               break;
            case this.btn_join:
               if(this._selectedHouse != null)
               {
                  this.sysApi.sendAction(new GuildHouseTeleportRequest(this._selectedHouse.houseId));
               }
               break;
            default:
               if(target.name.indexOf("btn_info") != -1)
               {
                  if(this._selectedHouse != null)
                  {
                     this.ctr_infos.visible = true;
                  }
               }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if((target == this.grid_house) && (target.selectedIndex > -1))
         {
            this.onHouseSelected(this.grid_house.dataProvider[target.selectedIndex]);
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var subarea:SubArea = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         if(target.name.indexOf("lbl_coord") != -1)
         {
            subarea = this.dataApi.getSubArea(this._lblCoordList[target.name].subareaId);
            tooltipText = this.dataApi.getArea(subarea.areaId).name + " ( " + subarea.name + " )";
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
