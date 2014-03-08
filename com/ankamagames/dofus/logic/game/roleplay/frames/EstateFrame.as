package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellFilterMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellFilterMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.houses.HouseToSellListRequestMessage;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.paddock.PaddockToSellListRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
   import com.ankamagames.dofus.logic.game.roleplay.types.Estate;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class EstateFrame extends Object implements Frame
   {
      
      public function EstateFrame() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EstateFrame));
      
      private var _estateList:Array;
      
      public function get priority() : int {
         return Priority.NORMAL;
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         var _loc2_:HouseToSellListMessage = null;
         var _loc3_:PaddockToSellListMessage = null;
         var _loc4_:HouseToSellFilterAction = null;
         var _loc5_:HouseToSellFilterMessage = null;
         var _loc6_:PaddockToSellFilterAction = null;
         var _loc7_:PaddockToSellFilterMessage = null;
         var _loc8_:HouseToSellListRequestAction = null;
         var _loc9_:HouseToSellListRequestMessage = null;
         var _loc10_:PaddockToSellListRequestAction = null;
         var _loc11_:PaddockToSellListRequestMessage = null;
         var _loc12_:LeaveDialogRequestMessage = null;
         var _loc13_:HouseInformationsForSell = null;
         var _loc14_:Estate = null;
         var _loc15_:PaddockInformationsForSell = null;
         var _loc16_:Estate = null;
         switch(true)
         {
            case param1 is HouseToSellListMessage:
               _loc2_ = param1 as HouseToSellListMessage;
               this._estateList = new Array();
               for each (_loc13_ in _loc2_.houseList)
               {
                  _loc14_ = new Estate(_loc13_);
                  this._estateList.push(_loc14_);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList,this._estateList,_loc2_.pageIndex,_loc2_.totalPage,0);
               return true;
            case param1 is PaddockToSellListMessage:
               _loc3_ = param1 as PaddockToSellListMessage;
               this._estateList = new Array();
               for each (_loc15_ in _loc3_.paddockList)
               {
                  _loc16_ = new Estate(_loc15_);
                  this._estateList.push(_loc16_);
               }
               KernelEventsManager.getInstance().processCallback(RoleplayHookList.EstateToSellList,this._estateList,_loc3_.pageIndex,_loc3_.totalPage,1);
               return true;
            case param1 is HouseToSellFilterAction:
               _loc4_ = param1 as HouseToSellFilterAction;
               _loc5_ = new HouseToSellFilterMessage();
               _loc5_.initHouseToSellFilterMessage(_loc4_.areaId,_loc4_.atLeastNbRoom,_loc4_.atLeastNbChest,_loc4_.skillRequested,_loc4_.maxPrice);
               ConnectionsHandler.getConnection().send(_loc5_);
               return true;
            case param1 is PaddockToSellFilterAction:
               _loc6_ = param1 as PaddockToSellFilterAction;
               _loc7_ = new PaddockToSellFilterMessage();
               _loc7_.initPaddockToSellFilterMessage(_loc6_.areaId,_loc6_.atLeastNbMount,_loc6_.atLeastNbMachine,_loc6_.maxPrice);
               ConnectionsHandler.getConnection().send(_loc7_);
               return true;
            case param1 is HouseToSellListRequestAction:
               _loc8_ = param1 as HouseToSellListRequestAction;
               _loc9_ = new HouseToSellListRequestMessage();
               _loc9_.initHouseToSellListRequestMessage(_loc8_.pageIndex);
               ConnectionsHandler.getConnection().send(_loc9_);
               return true;
            case param1 is PaddockToSellListRequestAction:
               _loc10_ = param1 as PaddockToSellListRequestAction;
               _loc11_ = new PaddockToSellListRequestMessage();
               _loc11_.initPaddockToSellListRequestMessage(_loc10_.pageIndex);
               ConnectionsHandler.getConnection().send(_loc11_);
               return true;
            case param1 is LeaveDialogRequestAction:
               _loc12_ = new LeaveDialogRequestMessage();
               ConnectionsHandler.getConnection().send(_loc12_);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean {
         KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
         return true;
      }
   }
}
