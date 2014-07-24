package ui
{
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.SocialApi;
   import d2components.GraphicContainer;
   import d2components.ButtonContainer;
   import d2components.Texture;
   import d2hooks.*;
   import d2actions.*;
   
   public class HouseManager extends Object
   {
      
      public function HouseManager() {
         super();
      }
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var locked:Boolean;
      
      private var _price:uint;
      
      private var _ownerId:int;
      
      private var _ownerName:String;
      
      private var _playerAsGuild:Boolean;
      
      private var _houseWithNoOwner:Boolean;
      
      public var mainCtr:GraphicContainer;
      
      public var btnHouse:ButtonContainer;
      
      public var txHouse:Texture;
      
      public var txHouseSell:Texture;
      
      public var txHouseLock:Texture;
      
      public function main(param:Object) : void {
         this._ownerId = param.ownerId;
         this._ownerName = param.ownerName;
         this._price = param.price;
         this.locked = param.isLocked;
         this.txHouse.mouseEnabled = false;
         this.txHouse.mouseChildren = false;
         this.txHouseSell.mouseEnabled = false;
         this.txHouseSell.mouseChildren = false;
         this.txHouseLock.mouseEnabled = false;
         this.txHouseLock.mouseChildren = false;
         this._houseWithNoOwner = this._ownerId == -1;
         this.updateIcon();
         this._playerAsGuild = this.socialApi.hasGuild();
         this.uiApi.addComponentHook(this.mainCtr,"onRelease");
         if(param.subAreaAlliance)
         {
            this.mainCtr.y = this.mainCtr.y + 50;
         }
      }
      
      public function unload() : void {
         this.modCommon.closeAllMenu();
      }
      
      public function updatePrice(price:uint) : void {
         this._price = price;
         this.updateIcon();
      }
      
      public function updateIcon() : void {
         if(this._price == 0)
         {
            if(this.locked)
            {
               this.txHouseLock.visible = true;
               this.txHouse.visible = false;
            }
            else
            {
               this.txHouse.visible = true;
               this.txHouseLock.visible = false;
            }
            this.txHouseSell.visible = false;
         }
         else
         {
            this.txHouse.visible = false;
            this.txHouseSell.visible = true;
            this.txHouseLock.visible = false;
         }
      }
      
      private function displayHousePrice() : void {
         this.uiApi.loadUi("houseSale","houseSale",
            {
               "inside":true,
               "ownerName":this._ownerName,
               "price":this._price
            },3);
      }
      
      private function displayUiHouseGuildManager() : void {
         this.uiApi.loadUi("houseGuildManager","houseGuildManager",null,3);
      }
      
      private function displayPasswordMenu() : void {
         this.modCommon.openPasswordMenu(8,true,this.codeUpdate);
      }
      
      private function codeUpdate(change:Boolean, code:String) : void {
         this.sysApi.sendAction(new HouseLockFromInside(code));
      }
      
      public function onRelease(target:Object) : void {
         var list:Array = null;
         var sellDisabled:* = false;
         if((!this.uiApi.getUi("houseGuildManager")) && (!this.uiApi.getUi("houseSale")))
         {
            list = new Array();
            sellDisabled = false;
            if(this._houseWithNoOwner)
            {
               list.push(this.modCommon.createContextMenuTitleObject(this.uiApi.getText("ui.common.houseWithNoOwner")));
            }
            else
            {
               list.push(this.modCommon.createContextMenuTitleObject(this.uiApi.getText("ui.common.houseOwnerName",this._ownerName)));
            }
            if(this._price == 0)
            {
               list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.sell"),this.displayHousePrice,null,sellDisabled,null));
            }
            else
            {
               list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.changeHousePrice"),this.displayHousePrice,null,sellDisabled));
            }
            if(this.locked)
            {
               list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.unlock"),this.displayPasswordMenu,null,false,null));
            }
            else
            {
               list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.lock"),this.displayPasswordMenu,null,false,null));
            }
            if(this._playerAsGuild)
            {
               list.push(this.modCommon.createContextMenuItemObject(this.uiApi.getText("ui.common.guildHouseConfiguration"),this.displayUiHouseGuildManager,null,false,null));
            }
            this.modCommon.createContextMenu(list);
         }
      }
   }
}
