package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.PartyApi;
   import d2api.ConfigApi;
   import d2api.PlayedCharacterApi;
   import d2api.ContextMenuApi;
   import d2components.Grid;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2data.PartyMemberWrapper;
   import d2hooks.*;
   import d2actions.*;
   import d2data.PartyCompanionWrapper;
   import com.ankamagames.dofusModuleLibrary.enum.components.GridItemSelectMethodEnum;
   import d2enums.ProtocolConstantsEnum;
   
   public class PartyDisplay extends Object
   {
      
      public function PartyDisplay() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var partyApi:PartyApi;
      
      public var configApi:ConfigApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var menuApi:ContextMenuApi;
      
      public var modCommon:Object;
      
      public var modContextMenu:Object;
      
      public var gdParty:Grid;
      
      public var btn_minimize:ButtonContainer;
      
      public var btn_maximize:ButtonContainer;
      
      public var tx_background_grid:Texture;
      
      public var tx_partyType:Texture;
      
      public var btn_info:ButtonContainer;
      
      public var btn_switchParty:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      private var _isArenaParty:Boolean = false;
      
      private var _isMinimized:Boolean;
      
      private var _leaderId:int;
      
      private var _selectedMember:PartyMemberWrapper;
      
      private var _members:Array;
      
      private var _othersFollowingPlayerId:uint;
      
      private var _arenaPartyId:int;
      
      private var _partyId:int;
      
      private var _arenaPartyName:String;
      
      private var _partyName:String;
      
      private var _fightLocked:Boolean;
      
      private var _partyLocked:Boolean;
      
      private var _arenaPartyLocked:Boolean;
      
      private var _foldStatus:Boolean;
      
      public function main(oParam:Object = null) : void {
         this.sysApi.addHook(PartyJoin,this.onPartyJoin);
         this.sysApi.addHook(PartyLocateMembers,this.onPartyLocateMembers);
         this.sysApi.addHook(PartyUpdate,this.onPartyUpdate);
         this.sysApi.addHook(PartyLeave,this.onPartyLeave);
         this.sysApi.addHook(PartyLeaderUpdate,this.onPartyLeaderUpdate);
         this.sysApi.addHook(PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(PartyMemberRemove,this.onPartyMemberRemove);
         this.sysApi.addHook(FoldAll,this.onFoldAll);
         this.sysApi.addHook(OptionLockParty,this.onOptionLockParty);
         this.sysApi.addHook(PartyLoyaltyStatus,this.onPartyLoyaltyStatus);
         this.sysApi.addHook(PartyMemberLifeUpdate,this.onPartyMemberLifeUpdate);
         this.sysApi.addHook(PartyNameUpdate,this.onPartyNameUpdate);
         this.uiApi.addComponentHook(this.btn_switchParty,"onRollOver");
         this.uiApi.addComponentHook(this.btn_switchParty,"onRollOut");
         this.uiApi.addComponentHook(this.btn_switchParty,"onRelease");
         this.uiApi.addComponentHook(this.btn_info,"onRollOver");
         this.uiApi.addComponentHook(this.btn_info,"onRollOut");
         this.uiApi.addComponentHook(this.btn_info,"onRelease");
         this.uiApi.addComponentHook(this.btn_minimize,"onRollOut");
         this.uiApi.addComponentHook(this.btn_minimize,"onRollOver");
         this.uiApi.addComponentHook(this.btn_minimize,"onRelease");
         this._isMinimized = false;
         this.btn_maximize.visible = false;
         this.updateGrid(oParam.partyMembers);
         this.gdParty.mouseEnabled = false;
         this._fightLocked = oParam.restricted;
         this._partyLocked = false;
         this._arenaPartyLocked = false;
         this._isArenaParty = oParam.arena;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         this.btn_switchParty.softDisabled = true;
         if(this._isArenaParty)
         {
            this.tx_partyType.gotoAndStop = 2;
         }
         if(this._isArenaParty)
         {
            this._arenaPartyId = oParam.id;
            this._arenaPartyName = oParam.name;
         }
         else
         {
            this._partyId = oParam.id;
            this._partyName = oParam.name;
         }
      }
      
      public function getCurrentGroupId() : int {
         if(this._isArenaParty)
         {
            return this._arenaPartyId;
         }
         return this._partyId;
      }
      
      private function updateGrid(members:Object = null) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function updateGridOrder() : void {
         this._members.sortOn(["isMember","initiative","id"],[Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         this.gdParty.updateItems();
      }
      
      private function updateBackground() : void {
         if(this.gdParty.dataProvider == null)
         {
            return;
         }
         this.tx_background_grid.height = Math.min(this._members.length,8) * int(this.uiApi.me().getConstant("member_height")) + int(this.uiApi.me().getConstant("bonus_height"));
      }
      
      private function showMembersParty(value:Boolean) : void {
         this.gdParty.visible = value;
         this.btn_minimize.visible = value;
         this.tx_background_grid.visible = value;
         this.tx_partyType.visible = value;
         this.btn_info.visible = value;
         this.btn_switchParty.visible = value;
         this.btn_maximize.visible = !value;
         this._isMinimized = !value;
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip();
         this.modContextMenu.closeAllMenu();
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var contextMenu:Object = null;
         switch(target)
         {
            case this.gdParty:
               if(selectMethod == GridItemSelectMethodEnum.AUTO)
               {
                  return;
               }
               this._selectedMember = target.selectedItem;
               if(this._selectedMember is PartyCompanionWrapper)
               {
                  contextMenu = this.menuApi.create(this._selectedMember as PartyCompanionWrapper);
                  if(contextMenu.content.length > 0)
                  {
                     this.modContextMenu.createContextMenu(contextMenu);
                  }
               }
               else
               {
                  this.sysApi.sendAction(new PartyShowMenu(this._selectedMember.id,this.getCurrentGroupId()));
               }
               break;
         }
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btn_minimize:
               this.showMembersParty(false);
               break;
            case this.btn_maximize:
               this.showMembersParty(true);
               break;
            case this.btn_info:
               this.showOptionsMenu();
               break;
            case this.btn_switchParty:
               this.switchPartyType();
               break;
         }
      }
      
      private function switchPartyType() : void {
         this._isArenaParty = !this._isArenaParty;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         if(this._isArenaParty)
         {
            this.tx_partyType.gotoAndStop = 2;
         }
         else
         {
            this.tx_partyType.gotoAndStop = 1;
         }
         this.updateGrid();
      }
      
      private function showOptionsMenu() : void {
         var menu:Array = new Array();
         menu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.common.options")));
         var iamnoleader:Boolean = !(this.playerApi.id() == this._leaderId);
         if(!this._isArenaParty)
         {
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.rename"),this.nameParty,null,iamnoleader || this.sysApi.isFightContext(),null,false,false,this._isArenaParty?this._arenaPartyName:this._partyName,true));
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.lockFight"),this.optionLockFight,[!this._fightLocked],iamnoleader,null,this._fightLocked,false));
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.refuseOtherInvitations"),this.optionLockParty,[!this._partyLocked],false,null,this._partyLocked,false));
         }
         else
         {
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.refuseOtherInvitations"),this.optionLockParty,[!this._arenaPartyLocked],false,null,this._arenaPartyLocked,false));
         }
         this.modContextMenu.createContextMenu(menu);
      }
      
      private function optionLockFight(value:Boolean) : void {
         this.sysApi.sendAction(new ToggleLockParty());
      }
      
      private function optionLockParty(value:Boolean) : void {
         this.sysApi.sendAction(new PartyPledgeLoyaltyRequest(this.getCurrentGroupId(),value));
      }
      
      private function nameParty() : void {
         this.modCommon.openInputPopup(this.uiApi.getText("ui.party.rename"),this.uiApi.getText("ui.party.choseName"),this.onChangePartyName,null,this._isArenaParty?this._arenaPartyName:this._partyName,"A-Za-z0-9 ",ProtocolConstantsEnum.MAX_PARTY_NAME_LEN);
      }
      
      private function onChangePartyName(value:String) : void {
         if(value.length >= ProtocolConstantsEnum.MIN_PARTY_NAME_LEN)
         {
            this.sysApi.sendAction(new PartyNameSetRequest(this.getCurrentGroupId(),value));
         }
      }
      
      private function onFoldAll(fold:Boolean) : void {
         if(fold)
         {
            this._foldStatus = this.gdParty.visible;
            this.showMembersParty(false);
         }
         else
         {
            this.showMembersParty(this._foldStatus);
         }
      }
      
      public function onRollOver(target:Object) : void {
         var data:Object = null;
         var levelTotal:uint = 0;
         var prosTotal:uint = 0;
         var initTotal:uint = 0;
         var info:String = null;
         var pos:Object = null;
         var player:PartyMemberWrapper = null;
         switch(target)
         {
            case this.btn_info:
               levelTotal = 0;
               prosTotal = 0;
               initTotal = 0;
               for each(player in this.gdParty.dataProvider)
               {
                  levelTotal = levelTotal + player.level;
                  prosTotal = prosTotal + player.prospecting;
                  initTotal = initTotal + player.initiative;
               }
               info = this.uiApi.getText("ui.party.partyInformation",levelTotal,prosTotal,this.gdParty.dataProvider.length == 0?"":Math.round(initTotal / this.gdParty.dataProvider.length));
               pos = 
                  {
                     "point":2,
                     "relativePoint":0
                  };
               if(info)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
               }
               break;
            case this.btn_switchParty:
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.switchPartyType"));
               this.uiApi.showTooltip(data,target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case this.btn_minimize:
               if(this._isArenaParty)
               {
                  if(this._arenaPartyName != "")
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.koliseum") + this.uiApi.getText("ui.common.colon") + this._arenaPartyName);
                  }
                  else
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.koliseum"));
                  }
               }
               else if(this._partyName != "")
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.party") + this.uiApi.getText("ui.common.colon") + this._partyName);
               }
               else
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.party"));
               }
               
               this.uiApi.showTooltip(data,target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onPartyLeaderUpdate(id:int, partyLeaderId:uint) : void {
         var player:PartyMemberWrapper = null;
         if(id == this.getCurrentGroupId())
         {
            for each(player in this.gdParty.dataProvider)
            {
               if(player.id == partyLeaderId)
               {
                  this._leaderId = player.id;
               }
            }
            this.updateBackground();
         }
      }
      
      private function onPartyMemberUpdate(id:int, playerId:uint) : void {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid();
         }
      }
      
      private function onPartyMemberLifeUpdate(id:int, playerId:int, pLifePoints:int, pInitiative:int) : void {
         if(id == this.getCurrentGroupId())
         {
            this.updateGridOrder();
         }
      }
      
      private function onPartyNameUpdate(id:int, partyName:String) : void {
         if(id == this._arenaPartyId)
         {
            this._arenaPartyName = partyName;
         }
         else
         {
            this._partyName = partyName;
         }
      }
      
      private function onPartyMemberRemove(id:int, playerId:uint) : void {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid();
         }
      }
      
      private function onPartyLocateMembers(geopositions:Vector.<uint>) : void {
      }
      
      public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void {
         this.updateGrid(pMembers);
         this._fightLocked = restrict;
         this._isArenaParty = isArenaParty;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         if(this._isArenaParty)
         {
            this.tx_partyType.gotoAndStop = 2;
         }
         else
         {
            this.tx_partyType.gotoAndStop = 1;
         }
         this.btn_switchParty.softDisabled = false;
         if(this._isArenaParty)
         {
            this._arenaPartyId = id;
            this._arenaPartyName = name;
         }
         else
         {
            this._partyId = id;
            this._partyName = name;
         }
      }
      
      private function onPartyUpdate(id:int, pMembers:Object) : void {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid(pMembers);
         }
      }
      
      private function onPartyLeave(id:int, isArena:Boolean) : void {
         if(this._isArenaParty)
         {
            if(id == this._arenaPartyId)
            {
               if(this._partyId != 0)
               {
                  this.switchPartyType();
                  this.btn_switchParty.softDisabled = true;
                  this._arenaPartyId = 0;
               }
               else if((this.uiApi) && (this.uiApi.me()))
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               
            }
            else
            {
               this.btn_switchParty.softDisabled = true;
               this._partyId = 0;
            }
         }
         else if(id == this._partyId)
         {
            if(this._arenaPartyId != 0)
            {
               this.switchPartyType();
               this.btn_switchParty.softDisabled = true;
               this._partyId = 0;
            }
            else
            {
               this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
         else
         {
            this.btn_switchParty.softDisabled = true;
            this._arenaPartyId = 0;
         }
         
      }
      
      private function onOptionLockParty(restricted:Boolean) : void {
         this._fightLocked = restricted;
      }
      
      private function onPartyLoyaltyStatus(id:int, loyal:Boolean) : void {
         if(id == this._arenaPartyId)
         {
            this._arenaPartyLocked = loyal;
         }
         else if(id == this._partyId)
         {
            this._partyLocked = loyal;
         }
         
      }
   }
}
