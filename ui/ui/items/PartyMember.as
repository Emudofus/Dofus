package ui.items
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.DataApi;
   import d2api.MountApi;
   import d2api.PlayedCharacterApi;
   import d2components.EntityDisplayer;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2hooks.*;
   import d2data.PartyCompanionWrapper;
   import d2enums.PlayerStatusEnum;
   
   public class PartyMember extends Object
   {
      
      public function PartyMember() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var mountApi:MountApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _grid:Object;
      
      private var _data;
      
      private var _selected:Boolean;
      
      public var playerEntityLook:EntityDisplayer;
      
      public var txPlayerLife:Texture;
      
      public var mainCtr:GraphicContainer;
      
      public var txPlayerContainer:Texture;
      
      public var mask:Object;
      
      public var txLeaderCrown:Texture;
      
      public var txFollowArrow:Texture;
      
      private var _compteur:uint = 0;
      
      private var _previousSkin:Vector.<uint>;
      
      private var _playerStatus:String = "";
      
      public function main(oParam:Object = null) : void {
         this.sysApi.addHook(PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(PartyMemberLifeUpdate,this.onPartyMemberLifeUpdate);
         this.sysApi.addHook(PartyCompanionMemberUpdate,this.onPartyCompanionMemberUpdate);
         this.sysApi.addHook(PartyMemberFollowUpdate,this.onPartyMemberFollowUpdate);
         this.sysApi.addHook(PlayerStatusUpdate,this.onPartyMemberStatusUpdate);
         this.uiApi.addComponentHook(this.txFollowArrow,"onRollOut");
         this.uiApi.addComponentHook(this.txFollowArrow,"onRollOver");
         this._grid = oParam.grid;
         this._data = oParam.data;
         this._selected = oParam.selected;
         this._previousSkin = new Vector.<uint>();
         this.playerEntityLook.setAnimationAndDirection("AnimArtwork",3);
         this.playerEntityLook.view = "timeline";
         this.txFollowArrow.visible = false;
         this.txLeaderCrown.visible = false;
         this.update(this._data,this._selected);
      }
      
      public function get data() : * {
         return this._data;
      }
      
      public function get selected() : Boolean {
         return this._selected;
      }
      
      public function update(pData:*, selected:Boolean) : void {
         this._data = pData;
         if(this._data)
         {
            this.playerEntityLook.look = this.mountApi.getRiderEntityLook(this._data.entityLook);
            if(!this._data.isMember)
            {
               if(this._data is PartyCompanionWrapper)
               {
                  this.txPlayerContainer.gotoAndStop = "companionguest";
               }
               else
               {
                  this.txPlayerContainer.gotoAndStop = "guest";
               }
               this.txLeaderCrown.visible = false;
               this.txPlayerLife.visible = false;
            }
            else
            {
               if(this._data.isLeader)
               {
                  this.txPlayerContainer.gotoAndStop = "leader";
                  this.txLeaderCrown.visible = true;
                  this.txLeaderCrown.finalize();
               }
               else
               {
                  if(this._data is PartyCompanionWrapper)
                  {
                     this.txPlayerContainer.gotoAndStop = "companion";
                  }
                  else
                  {
                     this.txPlayerContainer.gotoAndStop = "normal";
                  }
                  this.txLeaderCrown.visible = false;
               }
               this.txPlayerLife.scaleY = -this._data.lifePoints / this._data.maxLifePoints;
               this.txPlayerLife.visible = true;
            }
            this.txPlayerContainer.visible = true;
            if((!Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA) && (this._data.id == this.playerApi.getFollowingPlayerId()) && (!(this._data is PartyCompanionWrapper)))
            {
               if(this._data.isLeader)
               {
                  this.txFollowArrow.gotoAndStop = "leader";
               }
               else
               {
                  this.txFollowArrow.gotoAndStop = "normal";
               }
               this.txFollowArrow.visible = true;
            }
            else
            {
               this.txFollowArrow.visible = false;
            }
            switch(this.data.status)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this._playerStatus = "";
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.idle");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.solo");
                  break;
            }
         }
         else
         {
            this.playerEntityLook.look = null;
            this.txPlayerLife.visible = false;
            this.txPlayerContainer.visible = false;
            this.txLeaderCrown.visible = false;
         }
      }
      
      public function select(b:Boolean) : void {
      }
      
      public function onRollOver(target:Object) : void {
         var info:String = null;
         var pos:Object = 
            {
               "point":2,
               "relativePoint":0
            };
         switch(target)
         {
            case this.mainCtr:
               if(this._data == null)
               {
                  break;
               }
               if(!this._data.isMember)
               {
                  if((this._data.hostName) && (!(this._data.hostName == "")))
                  {
                     info = this._data.name + "\n" + this.uiApi.getText("ui.party.invitedBy") + "\n" + this._data.hostName;
                  }
                  else
                  {
                     info = this._data.name;
                  }
               }
               else
               {
                  if(this._data.isLeader)
                  {
                     info = this.uiApi.getText("ui.party.leader") + "\n";
                  }
                  else
                  {
                     info = "";
                  }
                  if(this._playerStatus != "")
                  {
                     info = "(" + this._playerStatus + ") ";
                  }
                  if(!Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA)
                  {
                     info = info + this.uiApi.getText("ui.party.rollOverPlayerInformations",this._data.name,this._data.level == 0?"--":this._data.level,this._data.prospecting,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative);
                  }
                  else
                  {
                     info = info + this.uiApi.getText("ui.party.rollOverArenaPlayerInformations",this._data.name,this._data.level == 0?"--":this._data.level,this._data.rank,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative);
                  }
               }
               if(info)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
               }
               break;
            case this.txFollowArrow:
               info = this.uiApi.getText("ui.party.following",this._data.name);
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      private function onPartyMemberUpdate(id:int, pId:int) : void {
      }
      
      private function onPartyMemberLifeUpdate(id:int, pId:int, pLifePoints:int, pInitiative:int) : void {
         if((!(this._data == null)) && (pId == this._data.id) && (!(this._data is PartyCompanionWrapper)))
         {
            this.txPlayerLife.scaleY = -pLifePoints / this._data.maxLifePoints;
         }
      }
      
      private function onPartyCompanionMemberUpdate(partyId:int, playerId:int, index:int, companion:Object) : void {
         if((!(this._data == null)) && (playerId == this._data.id) && (this._data is PartyCompanionWrapper) && (index == (this._data as PartyCompanionWrapper).index))
         {
            this.txPlayerLife.scaleY = -companion.lifePoints / this._data.maxLifePoints;
         }
      }
      
      private function onPartyMemberFollowUpdate(partyId:int, memberId:int, followed:Boolean) : void {
         if((this._data == null) || (Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA) || (!(memberId == this._data.id)) || (this._data is PartyCompanionWrapper))
         {
            return;
         }
         if(followed)
         {
            if(this._data.isLeader)
            {
               this.txFollowArrow.gotoAndStop = "leader";
            }
            else
            {
               this.txFollowArrow.gotoAndStop = "normal";
            }
            this.txFollowArrow.visible = true;
         }
         else
         {
            this.txFollowArrow.visible = false;
         }
      }
      
      private function onPartyMemberStatusUpdate(accountId:uint, playerId:uint, status:uint) : void {
         if((this._data) && (playerId == this._data.id))
         {
            switch(status)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this._playerStatus = "";
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.idle");
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.solo");
                  break;
            }
         }
      }
   }
}
