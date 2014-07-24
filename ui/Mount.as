package 
{
   import flash.display.Sprite;
   import ui.MountInfo;
   import ui.MountAncestors;
   import ui.MountPaddock;
   import ui.items.BarnItem;
   import ui.items.InventoryItem;
   import ui.PaddockSellBuy;
   import d2api.UiApi;
   import d2api.SystemApi;
   import d2api.PlayedCharacterApi;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import d2hooks.*;
   import d2enums.StrataEnum;
   
   public class Mount extends Sprite
   {
      
      public function Mount() {
         super();
      }
      
      private var include_mountInfo:MountInfo;
      
      private var include_mountAncestors:MountAncestors;
      
      private var include_mountPaddock:MountPaddock;
      
      private var include_barnItem:BarnItem;
      
      private var include_inventoryItem:InventoryItem;
      
      private var include_paddockSellBuy:PaddockSellBuy;
      
      public var uiApi:UiApi;
      
      public var sysApi:SystemApi;
      
      public var modCommon:Object;
      
      public var playerApi:PlayedCharacterApi;
      
      public function main() : void {
         this.sysApi.addHook(OpenMount,this.onOpenMount);
         this.sysApi.addHook(ExchangeStartOkMount,this.onExchangeStartOkMount);
         this.sysApi.addHook(CertificateMountData,this.onCertificateMountData);
         this.sysApi.addHook(PaddockedMountData,this.onCertificateMountData);
         this.sysApi.addHook(CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(PaddockSellBuyDialog,this.onPaddockSellBuyDialog);
      }
      
      private function onExchangeStartOkMount(stabledList:Object, paddockedList:Object) : void {
         this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         var paddockUi:Object = this.uiApi.getUi("mountPaddock");
         if(paddockUi)
         {
            paddockUi.uiClass.showUi(stabledList,paddockedList);
         }
         else
         {
            this.uiApi.loadUi("mountPaddock","mountPaddock",
               {
                  "stabledList":stabledList,
                  "paddockedList":paddockedList
               },StrataEnum.STRATA_HIGH);
         }
      }
      
      private function onCurrentMap(mapId:int) : void {
         this.uiApi.unloadUi("mountPaddock");
      }
      
      private function onGameFightStarting(fightType:uint) : void {
         this.uiApi.unloadUi("mountPaddock");
      }
      
      private function onOpenMount() : void {
         var mountPaddock:Object = null;
         var mountInfo:Object = this.uiApi.getUi(UIEnum.MOUNT_INFO);
         if(mountInfo)
         {
            mountPaddock = this.uiApi.getUi("mountPaddock");
            if((!mountPaddock) || (mountPaddock.uiClass.visible == false))
            {
               if(mountInfo.visible == false)
               {
                  mountInfo.visible = true;
               }
               else
               {
                  this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
               }
               this.uiApi.unloadUi(UIEnum.MOUNT_ANCESTORS);
            }
            else if(mountInfo.visible == false)
            {
               mountPaddock.uiClass.showCurrentMountInfo();
               mountInfo.visible = true;
            }
            
         }
         else
         {
            if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
            {
               this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            }
            if(this.playerApi.getMount())
            {
               this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,
                  {
                     "paddockMode":false,
                     "posX":890,
                     "posY":249,
                     "mountData":this.playerApi.getMount()
                  });
            }
         }
      }
      
      private function onPaddockSellBuyDialog(sellMode:Boolean, ownerId:uint, price:uint, ... args) : void {
         this.uiApi.loadUi("paddockSellBuy","paddockSellBuy",
            {
               "sellMode":sellMode,
               "id":ownerId,
               "price":price
            });
      }
      
      private function onCertificateMountData(mount:Object) : void {
         var mountPaddockUi:Object = this.uiApi.getUi("mountPaddock");
         if((!mountPaddockUi) || (!mountPaddockUi.uiClass.visible))
         {
            if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
            {
               this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
            }
            this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,
               {
                  "centeredMode":true,
                  "posX":550,
                  "posY":150,
                  "mountData":mount
               });
         }
      }
      
      private function onPaddockedMountData(mount:Object) : void {
         if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
         {
            this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         }
         this.uiApi.loadUi(UIEnum.MOUNT_INFO,UIEnum.MOUNT_INFO,
            {
               "centeredMode":true,
               "posX":452,
               "posY":152,
               "mountData":mount
            });
      }
   }
}
