package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.UtilApi;
   import d2api.DataApi;
   import d2data.GuildWrapper;
   import d2components.ButtonContainer;
   import d2components.TextArea;
   import d2components.Label;
   import d2components.Texture;
   import d2components.GraphicContainer;
   import d2hooks.*;
   import d2actions.*;
   import d2data.EmblemSymbol;
   
   public class HouseGuildManager extends Object
   {
      
      public function HouseGuildManager() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var socialApi:SocialApi;
      
      public var utilApi:UtilApi;
      
      public var dataApi:DataApi;
      
      public var modCommon:Object;
      
      private var _myGuild:GuildWrapper;
      
      private var _guildEmblem:Object;
      
      private var _guildName:String;
      
      public var btnClose:ButtonContainer;
      
      public var btnValidate:ButtonContainer;
      
      public var lblGuildHouseNotice:TextArea;
      
      public var lbl_title:Label;
      
      public var cbGuildHouseEnabled:ButtonContainer;
      
      public var cbMemberEmblemOnDoor:ButtonContainer;
      
      public var cbOthersEmblemOnDoor:ButtonContainer;
      
      public var cbAccessGuildmatesHouse:ButtonContainer;
      
      public var cbAccessHouseDenyOthers:ButtonContainer;
      
      public var cbGuildmatesAccessSafes:ButtonContainer;
      
      public var cbForbiddenSafes:ButtonContainer;
      
      public var cbAllowRespawn:ButtonContainer;
      
      public var cbAllowTeleport:ButtonContainer;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_emblemBackOld:Texture;
      
      public var tx_emblemUpOld:Texture;
      
      public var tx_emblemBackNew:Texture;
      
      public var tx_emblemUpNew:Texture;
      
      public var ctr_rightsList:GraphicContainer;
      
      public var ctr_oneEmblem:GraphicContainer;
      
      public var ctr_twoEmblems:GraphicContainer;
      
      public function main(arg:*) : void {
         this.sysApi.addHook(HouseGuildNone,this.houseGuildNone);
         this.sysApi.addHook(HouseGuildRights,this.houseGuildRights);
         this.sysApi.sendAction(new HouseGuildRightsView());
         this.uiApi.addComponentHook(this.btnClose,"onRelease");
         this.uiApi.addComponentHook(this.btnValidate,"onRelease");
         this.uiApi.addComponentHook(this.cbGuildHouseEnabled,"onRelease");
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.tx_emblemBackOld.dispatchMessages = true;
         this.tx_emblemUpOld.dispatchMessages = true;
         this.tx_emblemBackNew.dispatchMessages = true;
         this.tx_emblemUpNew.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_emblemBack,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemUp,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemBackOld,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemUpOld,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemBackNew,"onTextureReady");
         this.uiApi.addComponentHook(this.tx_emblemUpNew,"onTextureReady");
         this.lblGuildHouseNotice.wordWrap = true;
         this.lblGuildHouseNotice.multiline = true;
         this._myGuild = this.socialApi.getGuild();
      }
      
      private function houseGuildNone() : void {
         this.ctr_rightsList.disabled = true;
         this.lbl_title.text = this.uiApi.getText("ui.common.guildHouse");
         this.showEmblem();
      }
      
      private function houseGuildRights(houseId:uint, guildName:String, guildEmblem:Object, rights:int) : void {
         this.ctr_rightsList.disabled = false;
         this._guildName = guildName;
         this.lbl_title.text = this.uiApi.getText("ui.common.houseOwnerName",this._guildName);
         this._guildEmblem = guildEmblem;
         this.showEmblem();
         this.updateRights(rights);
      }
      
      private function showEmblem() : void {
         if((this._guildEmblem == null) || (this._guildName == this._myGuild.guildName))
         {
            this.ctr_oneEmblem.visible = true;
            this.ctr_twoEmblems.visible = false;
            this.tx_emblemBack.uri = this.uiApi.createUri(this._myGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUp.uri = this.uiApi.createUri(this._myGuild.upEmblem.fullSizeIconUri.toString());
         }
         else
         {
            this.ctr_oneEmblem.visible = false;
            this.ctr_twoEmblems.visible = true;
            this.tx_emblemBackOld.uri = this.uiApi.createUri(this._guildEmblem.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUpOld.uri = this.uiApi.createUri(this._guildEmblem.upEmblem.fullSizeIconUri.toString());
            this.tx_emblemBackNew.uri = this.uiApi.createUri(this._myGuild.backEmblem.fullSizeIconUri.toString());
            this.tx_emblemUpNew.uri = this.uiApi.createUri(this._myGuild.upEmblem.fullSizeIconUri.toString());
         }
      }
      
      private function updateRights(rights:int) : void {
         this.cbGuildHouseEnabled.selected = (1 & rights >> 0) == 1;
         this.cbMemberEmblemOnDoor.selected = (1 & rights >> 1) == 1;
         this.cbOthersEmblemOnDoor.selected = (1 & rights >> 2) == 1;
         this.cbAccessGuildmatesHouse.selected = (1 & rights >> 3) == 1;
         this.cbAccessHouseDenyOthers.selected = (1 & rights >> 4) == 1;
         this.cbGuildmatesAccessSafes.selected = (1 & rights >> 5) == 1;
         this.cbForbiddenSafes.selected = (1 & rights >> 6) == 1;
         this.cbAllowTeleport.selected = (1 & rights >> 7) == 1;
         this.cbAllowRespawn.selected = (1 & rights >> 8) == 1;
      }
      
      private function rightsToInt() : int {
         var rights:int = 0;
         rights = this.setBoolean(this.cbGuildHouseEnabled.selected,rights,0);
         rights = this.setBoolean(this.cbMemberEmblemOnDoor.selected,rights,1);
         rights = this.setBoolean(this.cbOthersEmblemOnDoor.selected,rights,2);
         rights = this.setBoolean(this.cbAccessGuildmatesHouse.selected,rights,3);
         rights = this.setBoolean(this.cbAccessHouseDenyOthers.selected,rights,4);
         rights = this.setBoolean(this.cbGuildmatesAccessSafes.selected,rights,5);
         rights = this.setBoolean(this.cbForbiddenSafes.selected,rights,6);
         rights = this.setBoolean(this.cbAllowTeleport.selected,rights,7);
         rights = this.setBoolean(this.cbAllowRespawn.selected,rights,8);
         return rights;
      }
      
      private function setBoolean(b:Boolean, integer:int, index:int) : int {
         if(b)
         {
            integer = integer | 1 << index;
         }
         else
         {
            integer = integer & ~(1 << index);
         }
         return integer;
      }
      
      public function onRelease(target:Object) : void {
         switch(target)
         {
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return;
            case this.btnValidate:
               if((this._guildName == this._myGuild.guildName) || (!this._guildName))
               {
                  this.onPopupValid();
               }
               else
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.house.takeAnotherGuildHouse",this._guildName),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.onPopupValid,this.onPopupClose],this.onPopupValid,this.onPopupClose);
               }
               return;
            case this.cbGuildHouseEnabled:
               this.ctr_rightsList.disabled = !this.cbGuildHouseEnabled.selected;
               return;
            default:
               return;
         }
      }
      
      public function onTextureReady(target:Object) : void {
         var icon:EmblemSymbol = null;
         var icono:EmblemSymbol = null;
         var iconn:EmblemSymbol = null;
         switch(target)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),this._myGuild.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(this._myGuild.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._myGuild.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._myGuild.upEmblem.color,0,true);
               }
               break;
            case this.tx_emblemBackOld:
               this.utilApi.changeColor(this.tx_emblemBackOld.getChildByName("back"),this._guildEmblem.backEmblem.color,1);
               break;
            case this.tx_emblemUpOld:
               icono = this.dataApi.getEmblemSymbol(this._guildEmblem.upEmblem.idEmblem);
               if(icono.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUpOld.getChildByName("up"),this._guildEmblem.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUpOld.getChildByName("up"),this._guildEmblem.upEmblem.color,0,true);
               }
               break;
            case this.tx_emblemBackNew:
               this.utilApi.changeColor(this.tx_emblemBackNew.getChildByName("back"),this._myGuild.backEmblem.color,1);
               break;
            case this.tx_emblemUpNew:
               iconn = this.dataApi.getEmblemSymbol(this._myGuild.upEmblem.idEmblem);
               if(iconn.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUpNew.getChildByName("up"),this._myGuild.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUpNew.getChildByName("up"),this._myGuild.upEmblem.color,0,true);
               }
               break;
         }
      }
      
      public function unload() : void {
      }
      
      public function onPopupClose() : void {
      }
      
      public function onPopupValid() : void {
         this.sysApi.sendAction(new HouseGuildShare(this.cbGuildHouseEnabled.selected,this.rightsToInt()));
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
