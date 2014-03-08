package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseBuyAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseSellFromInsideAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSellFromInsideRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable.PurchasableDialogMessage;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsMessage;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseSoldMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseBuyResultMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildRightsViewAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildRightsViewMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseGuildShareAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildShareRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickRequestMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseKickIndoorMerchantAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseKickIndoorMerchantRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableStateUpdateHouseDoorMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableShowCodeDialogMessage;
   import com.ankamagames.dofus.logic.game.common.actions.LockableChangeCodeAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableChangeCodeMessage;
   import com.ankamagames.dofus.logic.game.common.actions.HouseLockFromInsideAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseLockFromInsideRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.lockable.LockableCodeResultMessage;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild.HouseGuildNoneMessage;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import flash.utils.Dictionary;
   
   public class HouseFrame extends Object implements Frame
   {
      
      public function HouseFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HouseFrame));
      
      private var _houseDialogFrame:HouseDialogFrame;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         this._houseDialogFrame = new HouseDialogFrame();
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:LeaveDialogAction = null;
         var _loc5_:LeaveDialogRequestMessage = null;
         var _loc6_:HouseBuyAction = null;
         var _loc7_:HouseBuyRequestMessage = null;
         var _loc8_:HouseSellAction = null;
         var _loc9_:HouseSellRequestMessage = null;
         var _loc10_:HouseSellFromInsideAction = null;
         var _loc11_:HouseSellFromInsideRequestMessage = null;
         var _loc12_:PurchasableDialogMessage = null;
         var _loc13_:* = 0;
         var _loc14_:String = null;
         var _loc15_:uint = 0;
         var _loc16_:HouseWrapper = null;
         var _loc17_:HouseGuildRightsMessage = null;
         var _loc18_:GuildEmblem = null;
         var _loc19_:EmblemWrapper = null;
         var _loc20_:EmblemWrapper = null;
         var _loc21_:Object = null;
         var _loc22_:HouseSoldMessage = null;
         var _loc23_:HouseBuyResultMessage = null;
         var _loc24_:HouseGuildRightsViewAction = null;
         var _loc25_:HouseGuildRightsViewMessage = null;
         var _loc26_:HouseGuildShareAction = null;
         var _loc27_:HouseGuildShareRequestMessage = null;
         var _loc28_:HouseKickAction = null;
         var _loc29_:HouseKickRequestMessage = null;
         var _loc30_:HouseKickIndoorMerchantAction = null;
         var _loc31_:HouseKickIndoorMerchantRequestMessage = null;
         var _loc32_:LockableStateUpdateHouseDoorMessage = null;
         var _loc33_:LockableShowCodeDialogMessage = null;
         var _loc34_:LockableChangeCodeAction = null;
         var _loc35_:LockableChangeCodeMessage = null;
         var _loc36_:HouseLockFromInsideAction = null;
         var _loc37_:HouseLockFromInsideRequestMessage = null;
         var _loc38_:LockableCodeResultMessage = null;
         switch(true)
         {
            case param1 is LeaveDialogAction:
               _loc4_ = param1 as LeaveDialogAction;
               _loc5_ = new LeaveDialogRequestMessage();
               _loc5_.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is HouseBuyAction:
               _loc6_ = param1 as HouseBuyAction;
               _loc7_ = new HouseBuyRequestMessage();
               _loc7_.initHouseBuyRequestMessage(_loc6_.proposedPrice);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is HouseSellAction:
               _loc8_ = param1 as HouseSellAction;
               _loc9_ = new HouseSellRequestMessage();
               _loc9_.initHouseSellRequestMessage(_loc8_.amount);
               ConnectionsHandler.getConnection().send(_loc9_);
               return true;
            case param1 is HouseSellFromInsideAction:
               _loc10_ = param1 as HouseSellFromInsideAction;
               _loc11_ = new HouseSellFromInsideRequestMessage();
               _loc11_.initHouseSellFromInsideRequestMessage(_loc10_.amount);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is PurchasableDialogMessage:
               _loc12_ = param1 as PurchasableDialogMessage;
               _loc13_ = 0;
               _loc14_ = "";
               _loc15_ = _loc12_.purchasableId;
               _loc16_ = this.getHouseInformations(_loc12_.purchasableId);
               if(_loc16_)
               {
                  _loc13_ = _loc16_.houseId;
                  _loc14_ = _loc16_.ownerName;
               }
               Kernel.getWorker().addFrame(this._houseDialogFrame);
               KernelEventsManager.getInstance().processCallback(HookList.PurchasableDialog,_loc12_.buyOrSell,_loc12_.price,_loc16_);
               return true;
            case param1 is HouseGuildNoneMessage:
               KernelEventsManager.getInstance().processCallback(HookList.HouseGuildNone);
               return true;
            case param1 is HouseGuildRightsMessage:
               _loc17_ = param1 as HouseGuildRightsMessage;
               _loc18_ = _loc17_.guildInfo.guildEmblem;
               _loc19_ = EmblemWrapper.create(_loc18_.symbolShape,EmblemWrapper.UP,_loc18_.symbolColor);
               _loc20_ = EmblemWrapper.create(_loc18_.backgroundShape,EmblemWrapper.BACK,_loc18_.backgroundColor);
               _loc21_ = 
                  {
                     "upEmblem":_loc19_,
                     "backEmblem":_loc20_
                  };
               KernelEventsManager.getInstance().processCallback(HookList.HouseGuildRights,_loc17_.houseId,_loc17_.guildInfo.guildName,_loc21_,_loc17_.rights);
               return true;
            case param1 is HouseSoldMessage:
               _loc22_ = param1 as HouseSoldMessage;
               KernelEventsManager.getInstance().processCallback(HookList.HouseSold,_loc22_.houseId,_loc22_.realPrice,_loc22_.buyerName);
               return true;
            case param1 is HouseBuyResultMessage:
               _loc23_ = param1 as HouseBuyResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.HouseBuyResult,_loc23_.houseId,_loc23_.bought,_loc23_.realPrice,this.getHouseInformations(_loc23_.houseId).ownerName);
               return true;
            case param1 is HouseGuildRightsViewAction:
               _loc24_ = param1 as HouseGuildRightsViewAction;
               _loc25_ = new HouseGuildRightsViewMessage();
               ConnectionsHandler.getConnection().send(_loc25_);
               return true;
            case param1 is HouseGuildShareAction:
               _loc26_ = param1 as HouseGuildShareAction;
               _loc27_ = new HouseGuildShareRequestMessage();
               _loc27_.initHouseGuildShareRequestMessage(_loc26_.enabled,_loc26_.rights);
               ConnectionsHandler.getConnection().send(_loc27_);
               return true;
            case param1 is HouseKickAction:
               _loc28_ = param1 as HouseKickAction;
               _loc29_ = new HouseKickRequestMessage();
               _loc29_.initHouseKickRequestMessage(_loc28_.id);
               ConnectionsHandler.getConnection().send(_loc29_);
               return true;
            case param1 is HouseKickIndoorMerchantAction:
               _loc30_ = param1 as HouseKickIndoorMerchantAction;
               _loc31_ = new HouseKickIndoorMerchantRequestMessage();
               _loc31_.initHouseKickIndoorMerchantRequestMessage(_loc30_.cellId);
               ConnectionsHandler.getConnection().send(_loc31_);
               return true;
            case param1 is LockableStateUpdateHouseDoorMessage:
               _loc32_ = param1 as LockableStateUpdateHouseDoorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.LockableStateUpdateHouseDoor,_loc32_.houseId,_loc32_.locked);
               return true;
            case param1 is LockableShowCodeDialogMessage:
               _loc33_ = param1 as LockableShowCodeDialogMessage;
               Kernel.getWorker().addFrame(this._houseDialogFrame);
               KernelEventsManager.getInstance().processCallback(HookList.LockableShowCode,_loc33_.changeOrUse,_loc33_.codeSize);
               return true;
            case param1 is LockableChangeCodeAction:
               _loc34_ = param1 as LockableChangeCodeAction;
               _loc35_ = new LockableChangeCodeMessage();
               _loc35_.initLockableChangeCodeMessage(_loc34_.code);
               ConnectionsHandler.getConnection().send(_loc35_);
               return true;
            case param1 is HouseLockFromInsideAction:
               _loc36_ = param1 as HouseLockFromInsideAction;
               _loc37_ = new HouseLockFromInsideRequestMessage();
               _loc37_.initHouseLockFromInsideRequestMessage(_loc36_.code);
               ConnectionsHandler.getConnection().send(_loc37_);
               return true;
            case param1 is LockableCodeResultMessage:
               _loc38_ = param1 as LockableCodeResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.LockableCodeResult,_loc38_.result);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function getHouseInformations(param1:uint) : HouseWrapper {
         var _loc3_:HouseWrapper = null;
         var _loc2_:Dictionary = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).housesInformations;
         for each (_loc3_ in _loc2_)
         {
            if(_loc3_.houseId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}
