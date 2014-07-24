package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.MountApi;
   import d2components.Texture;
   import d2components.Label;
   import d2components.ButtonContainer;
   import d2components.Grid;
   import d2data.PartyMemberWrapper;
   import d2data.PartyCompanionWrapper;
   import d2enums.PartyTypeEnum;
   import d2hooks.PartyMemberUpdateDetails;
   import d2hooks.PartyMemberRemove;
   import d2actions.PartyRefuseInvitation;
   import d2actions.PartyAcceptInvitation;
   import d2actions.AddIgnored;
   
   public class JoinParty extends Object
   {
      
      public function JoinParty() {
         super();
      }
      
      public var modCommon:Object;
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var mountApi:MountApi;
      
      private var _partyId:uint;
      
      private var _members:Array;
      
      private var _fromName:String;
      
      private var _partyName:String;
      
      private var _leaderId:uint;
      
      private var _typeId:uint = 0;
      
      private var _dungeonId:uint = 0;
      
      private var _acceptMembersDungeon:Array;
      
      public var ctr_main:Object;
      
      public var tx_background:Texture;
      
      public var lbl_fromName:Label;
      
      public var lbl_dungeon:Label;
      
      public var btnClose:Object;
      
      public var btnValidate:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public var btnIgnore:ButtonContainer;
      
      public var grid_members:Grid;
      
      public var tx_slotPlayer:Object;
      
      public function main(params:Array) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip();
      }
      
      private function updateGrid() : void {
         this.grid_members.dataProvider = this._members;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btnCancel:
               this.sysApi.sendAction(new PartyRefuseInvitation(this._partyId));
               break;
            case this.btnValidate:
               this.sysApi.sendAction(new PartyAcceptInvitation(this._partyId));
               break;
            case this.btnIgnore:
               this.sysApi.sendAction(new AddIgnored(this._fromName));
               this.sysApi.sendAction(new PartyRefuseInvitation(this._partyId));
               break;
         }
      }
      
      public function updateEntry(data:*, componentsRef:*, selected:Boolean) : void {
         if(data)
         {
            componentsRef.ed_Player.look = this.mountApi.getRiderEntityLook(data.entityLook);
            componentsRef.ed_Player.visible = true;
            if(!data.isMember)
            {
               componentsRef.tx_slotPlayerLine.gotoAndStop = 1;
               componentsRef.tx_slotPlayerLine.visible = true;
            }
            else
            {
               componentsRef.tx_slotPlayerLine.gotoAndStop = 2;
               componentsRef.tx_slotPlayerLine.visible = this.isReady(data.id);
            }
            componentsRef.lbl_name.text = "{player," + data.name + "," + data.id + "::" + data.name + "}";
            if(data.breedId)
            {
               componentsRef.lbl_breed.text = this.dataApi.getBreed(data.breedId).shortName;
            }
            else
            {
               componentsRef.lbl_breed.text = "";
            }
            if((data.level == 0) || (data is PartyCompanionWrapper))
            {
               componentsRef.lbl_level.text = "";
            }
            else
            {
               componentsRef.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + data.level;
            }
            componentsRef.tx_leaderCrown.gotoAndStop = 2;
            componentsRef.tx_leaderCrown.visible = data.id == this._leaderId && !(data is PartyCompanionWrapper);
         }
         else
         {
            componentsRef.tx_slotPlayerLine.visible = false;
            componentsRef.tx_leaderCrown.visible = false;
            componentsRef.ed_Player.visible = false;
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_breed.text = "";
            componentsRef.lbl_level.text = "";
         }
      }
      
      private function isReady(playerId:uint) : Boolean {
         var m:* = 0;
         if((this._acceptMembersDungeon == null) || (this._acceptMembersDungeon.length <= 0))
         {
            return false;
         }
         for each(m in this._acceptMembersDungeon)
         {
            if(m == playerId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function onItemRollOver(target:Object, item:Object) : void {
         var txt:String = null;
         if(item.data)
         {
            if(item.data.subAreaId)
            {
               txt = this.uiApi.getText("ui.common.invitationLocation") + " " + this.dataApi.getSubArea(item.data.subAreaId).name + " (" + item.data.worldX + "," + item.data.worldY + ")";
            }
            if(txt != "")
            {
               this.uiApi.showTooltip(txt,item.container,false,"standard",2,0,0,null,null,null,null);
            }
         }
      }
      
      public function onItemRollOut(target:Object, item:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onPartyMemberUpdate(pPartyId:uint, pGuest:PartyMemberWrapper, pIsInGroup:Boolean) : void {
         var c:PartyCompanionWrapper = null;
         var newMembers:Array = null;
         var m:PartyMemberWrapper = null;
         var i:* = 0;
         var c2:PartyCompanionWrapper = null;
         if(this._partyId != pPartyId)
         {
            return;
         }
         var index:int = this.getMemberIndex(pGuest.id);
         if(index == -1)
         {
            this._members.push(pGuest);
            for each(c in pGuest.companions)
            {
               this._members.push(c);
            }
         }
         else
         {
            newMembers = new Array();
            for each(m in this._members)
            {
               if(m.id != pGuest.id)
               {
                  newMembers.push(m);
               }
            }
            this._members = newMembers;
            this._members.splice(index,0,pGuest);
            i = 0;
            for each(c2 in pGuest.companions)
            {
               i++;
               this._members.splice(index + i,0,c2);
            }
         }
         this.updateGrid();
      }
      
      private function onPartyMemberRemove(pPartyId:uint, pMemberId:uint) : void {
         var m:PartyMemberWrapper = null;
         if(this._partyId != pPartyId)
         {
            return;
         }
         var newMembers:Array = new Array();
         for each(m in this._members)
         {
            if(m.id != pMemberId)
            {
               newMembers.push(m);
            }
         }
         this._members = newMembers;
         this.updateGrid();
      }
      
      private function getMemberIndex(guestId:int) : int {
         var m:PartyMemberWrapper = null;
         for each(m in this._members)
         {
            if(m.id == guestId)
            {
               return this._members.indexOf(m);
            }
         }
         return -1;
      }
   }
}
