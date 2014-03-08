package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class PartyApi extends Object implements IApi
   {
      
      public function PartyApi() {
         this._log = Log.getLogger(getQualifiedClassName(PartyApi));
         super();
      }
      
      private var _module:UiModule;
      
      protected var _log:Logger;
      
      private function get partyManagementFrame() : PartyManagementFrame {
         return Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
      }
      
      public function set module(param1:UiModule) : void {
         this._module = param1;
      }
      
      public function destroy() : void {
         this._module = null;
      }
      
      public function getPartyMembers(param1:int=0) : Object {
         if(param1 == 1)
         {
            return this.partyManagementFrame.arenaPartyMembers;
         }
         return this.partyManagementFrame.partyMembers;
      }
      
      public function getPartyLeaderId(param1:int) : int {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function isInParty(param1:uint) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function getPartyId() : int {
         return this.partyManagementFrame.partyId;
      }
      
      public function isArenaRegistered() : Boolean {
         return this.partyManagementFrame.isArenaRegistered;
      }
      
      public function getArenaCurrentStatus() : int {
         return this.partyManagementFrame.arenaCurrentStatus;
      }
      
      public function getArenaPartyId() : int {
         return this.partyManagementFrame.arenaPartyId;
      }
      
      public function getArenaLeader() : Object {
         return this.partyManagementFrame.arenaLeader;
      }
      
      public function getArenaReadyPartyMemberIds() : Object {
         return this.partyManagementFrame.arenaReadyPartyMemberIds;
      }
      
      public function getArenaAlliesIds() : Object {
         return this.partyManagementFrame.arenaAlliesIds;
      }
      
      public function getArenaRanks() : Object {
         return this.partyManagementFrame.arenaRanks;
      }
      
      public function getTodaysArenaFights() : int {
         return this.partyManagementFrame.todaysArenaFights;
      }
      
      public function getTodaysWonArenaFights() : int {
         return this.partyManagementFrame.todaysWonArenaFights;
      }
      
      public function getAllMemberFollowPlayerId(param1:int) : uint {
         return this.partyManagementFrame.allMemberFollowPlayerId;
      }
      
      public function getPartyLoyalty(param1:int) : Boolean {
         return this.partyManagementFrame.partyLoyalty;
      }
      
      public function getAllSubscribedDungeons() : Vector.<uint> {
         return this.partyManagementFrame.subscribedDungeons;
      }
   }
}
