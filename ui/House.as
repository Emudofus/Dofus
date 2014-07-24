package 
{
   import flash.display.Sprite;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import d2api.MapApi;
   import d2api.SocialApi;
   import d2api.UtilApi;
   import ui.HouseManager;
   import ui.HouseSale;
   import ui.HouseGuildManager;
   import d2hooks.*;
   import d2actions.*;
   import d2enums.LockableResultEnum;
   import d2data.PrismSubAreaWrapper;
   import d2data.SubArea;
   
   public class House extends Sprite
   {
      
      public function House() {
         super();
      }
      
      public static var currentHouse:Object;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var modCommon:Object;
      
      public var playerApi:PlayedCharacterApi;
      
      public var mapApi:MapApi;
      
      public var socialApi:SocialApi;
      
      public var utilApi:UtilApi;
      
      private var include_HouseManager:HouseManager = null;
      
      private var include_HouseSale:HouseSale = null;
      
      private var include_HouseGuildManager:HouseGuildManager = null;
      
      private var _subAreaAlliance:Boolean;
      
      private var _price:uint;
      
      public function main() : void {
         this._price = 0;
         this.sysApi.addHook(CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(HouseEntered,this.houseEntered);
         this.sysApi.addHook(HouseExit,this.houseExit);
         this.sysApi.addHook(HouseSold,this.houseSold);
         this.sysApi.addHook(PurchasableDialog,this.purchasableDialog);
         this.sysApi.addHook(HouseBuyResult,this.houseBuyResult);
         this.sysApi.addHook(LockableShowCode,this.lockableShowCode);
         this.sysApi.addHook(LockableCodeResult,this.lockableCodeResult);
         this.sysApi.addHook(LockableStateUpdateHouseDoor,this.lockableStateUpdateHouseDoor);
      }
      
      private function lockableShowCode(changeOrUse:Boolean, codeSize:uint) : void {
         this.modCommon.openPasswordMenu(codeSize,changeOrUse,this.selectCode,this.codeCancelChange);
      }
      
      private function selectCode(changeOrUse:Boolean, code:String) : void {
         if(changeOrUse)
         {
            this.sysApi.sendAction(new LockableChangeCode(code));
         }
         else
         {
            this.sysApi.sendAction(new LockableUseCode(code));
         }
      }
      
      private function codeCancelChange() : void {
         this.sysApi.sendAction(new LeaveDialog());
      }
      
      private function lockableCodeResult(result:uint) : void {
         if(result == LockableResultEnum.LOCKABLE_UNLOCKED)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.house.codeChanged"),[this.uiApi.getText("ui.common.ok")]);
         }
         else if(result == LockableResultEnum.LOCKABLE_CODE_ERROR)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.error.badCode"),[this.uiApi.getText("ui.common.ok")]);
         }
         else if(result == LockableResultEnum.LOCKABLE_UNLOCK_FORBIDDEN)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.code"),this.uiApi.getText("ui.error.forbiddenUnlock"),[this.uiApi.getText("ui.common.ok")]);
         }
         
         
      }
      
      private function lockableStateUpdateHouseDoor(houseId:int, locked:Boolean) : void {
         var uiHouseManager:Object = this.uiApi.getUi("houseManager");
         if(uiHouseManager != null)
         {
            uiHouseManager.uiClass.locked = locked;
            uiHouseManager.uiClass.updateIcon();
         }
      }
      
      private function purchasableDialog(buyOrSell:Boolean, price:uint, houseWrapper:Object) : void {
         currentHouse = houseWrapper;
         this._price = price;
         if(buyOrSell)
         {
            this.uiApi.loadUi("houseSale","houseSale",
               {
                  "buyMode":true,
                  "price":price
               });
         }
         else
         {
            this.uiApi.loadUi("houseSale","houseSale",
               {
                  "buyMode":false,
                  "inside":false,
                  "price":price
               });
         }
      }
      
      private function houseBuyResult(houseId:uint, bought:Boolean, realPrice:uint, ownerName:String) : void {
         if(bought)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.houseBuy",this.uiApi.getText("ui.common.houseOwnerName",ownerName),this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),this.uiApi.getText("ui.common.cantBuyHouse",this.utilApi.kamasToString(realPrice,"")),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function houseSold(houseId:uint, realPrice:uint, buyerName:String) : void {
         var textSell:String = null;
         var uiHouseManager:Object = this.uiApi.getUi("houseManager");
         if(uiHouseManager != null)
         {
            uiHouseManager.uiClass.updatePrice(realPrice);
         }
         var playerManager:Object = this.sysApi.getPlayerManager();
         if(playerManager.nickname == buyerName)
         {
            if(realPrice == 0)
            {
               textSell = this.uiApi.getText("ui.common.houseNosell",this.uiApi.getText("ui.common.houseOwnerName",buyerName));
            }
            else
            {
               textSell = this.uiApi.getText("ui.common.houseSell",this.uiApi.getText("ui.common.houseOwnerName",buyerName),this.utilApi.kamasToString(realPrice,""));
            }
            this.modCommon.openPopup(this.uiApi.getText("ui.login.news"),textSell,[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      private function houseEntered(playerHouse:Boolean, ownerId:int, ownerName:String, price:uint, isLocked:Boolean, worldX:int, worldY:int, houseWrapper:Object) : void {
         currentHouse = houseWrapper;
         if(playerHouse)
         {
            if(!this.uiApi.getUi("houseManager"))
            {
               this.uiApi.loadUi("houseManager","houseManager",
                  {
                     "ownerId":ownerId,
                     "ownerName":ownerName,
                     "price":price,
                     "isLocked":isLocked,
                     "subAreaAlliance":this._subAreaAlliance
                  },0);
            }
         }
         else if(this.uiApi.getUi("houseManager"))
         {
            this.uiApi.unloadUi("houseManager");
         }
         
      }
      
      private function houseExit() : void {
         if(this.uiApi.getUi("houseManager"))
         {
            this.uiApi.unloadUi("houseManager");
         }
      }
      
      private function onCurrentMap(pMapId:uint) : void {
         var prismInfo:PrismSubAreaWrapper = null;
         var subArea:SubArea = this.mapApi.getMapPositionById(pMapId).subArea;
         this._subAreaAlliance = false;
         if(subArea)
         {
            prismInfo = this.socialApi.getPrismSubAreaById(subArea.id);
            if((prismInfo) && (!(prismInfo.mapId == -1)))
            {
               this._subAreaAlliance = true;
            }
         }
      }
   }
}
