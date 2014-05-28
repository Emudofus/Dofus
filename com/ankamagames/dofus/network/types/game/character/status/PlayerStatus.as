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
      
      public function initPlayerStatus(statusId:uint = 1) : PlayerStatus {
         this.statusId = statusId;
         return this;
      }
      
      public function reset() : void {
         this.statusId = 1;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_PlayerStatus(output);
      }
      
      public function serializeAs_PlayerStatus(output:IDataOutput) : void {
         output.writeByte(this.statusId);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PlayerStatus(input);
      }
      
      public function deserializeAs_PlayerStatus(input:IDataInput) : void {
         this.statusId = input.readByte();
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
