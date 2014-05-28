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
      
      protected static const _log:Logger;
      
      private var _houseDialogFrame:HouseDialogFrame;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         this._houseDialogFrame = new HouseDialogFrame();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         var i:* = 0;
         var housesListSize:* = 0;
         var lda:LeaveDialogAction = null;
         var lsrmsg:LeaveDialogRequestMessage = null;
         var hba:HouseBuyAction = null;
         var hbrm:HouseBuyRequestMessage = null;
         var hsa:HouseSellAction = null;
         var hsrm:HouseSellRequestMessage = null;
         var hsfia:HouseSellFromInsideAction = null;
         var hsfirmag:HouseSellFromInsideRequestMessage = null;
         var pdmsg:PurchasableDialogMessage = null;
         var houseType:* = 0;
         var ownerName:String = null;
         var houseID:uint = 0;
         var houseWrapper:HouseWrapper = null;
         var hgrm:HouseGuildRightsMessage = null;
         var emblem:GuildEmblem = null;
         var upEmblem:EmblemWrapper = null;
         var backEmblem:EmblemWrapper = null;
         var guildEmblem:Object = null;
         var hsm:HouseSoldMessage = null;
         var nhbrm:HouseBuyResultMessage = null;
         var hgrva:HouseGuildRightsViewAction = null;
         var hgrvm:HouseGuildRightsViewMessage = null;
         var hsga:HouseGuildShareAction = null;
         var hgsrm:HouseGuildShareRequestMessage = null;
         var hka:HouseKickAction = null;
         var hkrm:HouseKickRequestMessage = null;
         var hkima:HouseKickIndoorMerchantAction = null;
         var hkimrm:HouseKickIndoorMerchantRequestMessage = null;
         var lsuhdmsg:LockableStateUpdateHouseDoorMessage = null;
         var lscdmsg:LockableShowCodeDialogMessage = null;
         var lcca:LockableChangeCodeAction = null;
         var lccmsg:LockableChangeCodeMessage = null;
         var hlfia:HouseLockFromInsideAction = null;
         var hlfimsg:HouseLockFromInsideRequestMessage = null;
         var lcrmsg:LockableCodeResultMessage = null;
         switch(true)
         {
            case msg is LeaveDialogAction:
               lda = msg as LeaveDialogAction;
               lsrmsg = new LeaveDialogRequestMessage();
               lsrmsg.initLeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(lsrmsg);
               return true;
            case msg is HouseBuyAction:
               hba = msg as HouseBuyAction;
               hbrm = new HouseBuyRequestMessage();
               hbrm.initHouseBuyRequestMessage(hba.proposedPrice);
               ConnectionsHandler.getConnection().send(hbrm);
               return true;
            case msg is HouseSellAction:
               hsa = msg as HouseSellAction;
               hsrm = new HouseSellRequestMessage();
               hsrm.initHouseSellRequestMessage(hsa.amount);
               ConnectionsHandler.getConnection().send(hsrm);
               return true;
            case msg is HouseSellFromInsideAction:
               hsfia = msg as HouseSellFromInsideAction;
               hsfirmag = new HouseSellFromInsideRequestMessage();
               hsfirmag.initHouseSellFromInsideRequestMessage(hsfia.amount);
               ConnectionsHandler.getConnection().send(hsfirmag);
               return true;
            case msg is PurchasableDialogMessage:
               pdmsg = msg as PurchasableDialogMessage;
               houseType = 0;
               ownerName = "";
               houseID = pdmsg.purchasableId;
               houseWrapper = this.getHouseInformations(pdmsg.purchasableId);
               if(houseWrapper)
               {
                  houseType = houseWrapper.houseId;
                  ownerName = houseWrapper.ownerName;
               }
               Kernel.getWorker().addFrame(this._houseDialogFrame);
               KernelEventsManager.getInstance().processCallback(HookList.PurchasableDialog,pdmsg.buyOrSell,pdmsg.price,houseWrapper);
               return true;
            case msg is HouseGuildNoneMessage:
               KernelEventsManager.getInstance().processCallback(HookList.HouseGuildNone);
               return true;
            case msg is HouseGuildRightsMessage:
               hgrm = msg as HouseGuildRightsMessage;
               emblem = hgrm.guildInfo.guildEmblem;
               upEmblem = EmblemWrapper.create(emblem.symbolShape,EmblemWrapper.UP,emblem.symbolColor);
               backEmblem = EmblemWrapper.create(emblem.backgroundShape,EmblemWrapper.BACK,emblem.backgroundColor);
               guildEmblem = 
                  {
                     "upEmblem":upEmblem,
                     "backEmblem":backEmblem
                  };
               KernelEventsManager.getInstance().processCallback(HookList.HouseGuildRights,hgrm.houseId,hgrm.guildInfo.guildName,guildEmblem,hgrm.rights);
               return true;
            case msg is HouseSoldMessage:
               hsm = msg as HouseSoldMessage;
               KernelEventsManager.getInstance().processCallback(HookList.HouseSold,hsm.houseId,hsm.realPrice,hsm.buyerName);
               return true;
            case msg is HouseBuyResultMessage:
               nhbrm = msg as HouseBuyResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.HouseBuyResult,nhbrm.houseId,nhbrm.bought,nhbrm.realPrice,this.getHouseInformations(nhbrm.houseId).ownerName);
               return true;
            case msg is HouseGuildRightsViewAction:
               hgrva = msg as HouseGuildRightsViewAction;
               hgrvm = new HouseGuildRightsViewMessage();
               ConnectionsHandler.getConnection().send(hgrvm);
               return true;
            case msg is HouseGuildShareAction:
               hsga = msg as HouseGuildShareAction;
               hgsrm = new HouseGuildShareRequestMessage();
               hgsrm.initHouseGuildShareRequestMessage(hsga.enabled,hsga.rights);
               ConnectionsHandler.getConnection().send(hgsrm);
               return true;
            case msg is HouseKickAction:
               hka = msg as HouseKickAction;
               hkrm = new HouseKickRequestMessage();
               hkrm.initHouseKickRequestMessage(hka.id);
               ConnectionsHandler.getConnection().send(hkrm);
               return true;
            case msg is HouseKickIndoorMerchantAction:
               hkima = msg as HouseKickIndoorMerchantAction;
               hkimrm = new HouseKickIndoorMerchantRequestMessage();
               hkimrm.initHouseKickIndoorMerchantRequestMessage(hkima.cellId);
               ConnectionsHandler.getConnection().send(hkimrm);
               return true;
            case msg is LockableStateUpdateHouseDoorMessage:
               lsuhdmsg = msg as LockableStateUpdateHouseDoorMessage;
               KernelEventsManager.getInstance().processCallback(HookList.LockableStateUpdateHouseDoor,lsuhdmsg.houseId,lsuhdmsg.locked);
               return true;
            case msg is LockableShowCodeDialogMessage:
               lscdmsg = msg as LockableShowCodeDialogMessage;
               Kernel.getWorker().addFrame(this._houseDialogFrame);
               KernelEventsManager.getInstance().processCallback(HookList.LockableShowCode,lscdmsg.changeOrUse,lscdmsg.codeSize);
               return true;
            case msg is LockableChangeCodeAction:
               lcca = msg as LockableChangeCodeAction;
               lccmsg = new LockableChangeCodeMessage();
               lccmsg.initLockableChangeCodeMessage(lcca.code);
               ConnectionsHandler.getConnection().send(lccmsg);
               return true;
            case msg is HouseLockFromInsideAction:
               hlfia = msg as HouseLockFromInsideAction;
               hlfimsg = new HouseLockFromInsideRequestMessage();
               hlfimsg.initHouseLockFromInsideRequestMessage(hlfia.code);
               ConnectionsHandler.getConnection().send(hlfimsg);
               return true;
            case msg is LockableCodeResultMessage:
               lcrmsg = msg as LockableCodeResultMessage;
               KernelEventsManager.getInstance().processCallback(HookList.LockableCodeResult,lcrmsg.result);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function getHouseInformations(houseID:uint) : HouseWrapper {
         var hi:HouseWrapper = null;
         var houseList:Dictionary = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).housesInformations;
         for each(hi in houseList)
         {
            if(hi.houseId == houseID)
            {
               return hi;
            }
         }
         return null;
      }
   }
}
