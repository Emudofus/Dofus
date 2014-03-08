package com.ankamagames.dofus.network.types.game.character.status
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PlayerStatus extends Object implements INetworkType
   {
      
      public function PlayerStatus() {
         super();
      }
      
      public static const protocolId:uint = 415;
      
      public var statusId:uint = 1;
      
      public function getTypeId() : uint {
         return 415;
      }
      
      public function initPlayerStatus(param1:uint=1) : PlayerStatus {
         this.statusId = param1;
         return this;
      }
      
      public function reset() : void {
         this.statusId = 1;
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PlayerStatus(param1);
      }
      
      public function serializeAs_PlayerStatus(param1:IDataOutput) : void {
         param1.writeByte(this.statusId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PlayerStatus(param1);
      }
      
      public function deserializeAs_PlayerStatus(param1:IDataInput) : void {
         this.statusId = param1.readByte();
         if(this.statusId < 0)
         {
            throw new Error("Forbidden value (" + this.statusId + ") on element of PlayerStatus.statusId.");
         }
         else
         {
            return;
         }
      }
   }
}
