package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayDelayedActionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayDelayedActionMessage() {
         super();
      }
      
      public static const protocolId:uint = 6153;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var delayedCharacterId:int = 0;
      
      public var delayTypeId:uint = 0;
      
      public var delayEndTime:Number = 0;
      
      override public function getMessageId() : uint {
         return 6153;
      }
      
      public function initGameRolePlayDelayedActionMessage(delayedCharacterId:int=0, delayTypeId:uint=0, delayEndTime:Number=0) : GameRolePlayDelayedActionMessage {
         this.delayedCharacterId = delayedCharacterId;
         this.delayTypeId = delayTypeId;
         this.delayEndTime = delayEndTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.delayedCharacterId = 0;
         this.delayTypeId = 0;
         this.delayEndTime = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayDelayedActionMessage(output);
      }
      
      public function serializeAs_GameRolePlayDelayedActionMessage(output:IDataOutput) : void {
         output.writeInt(this.delayedCharacterId);
         output.writeByte(this.delayTypeId);
         if(this.delayEndTime < 0)
         {
            throw new Error("Forbidden value (" + this.delayEndTime + ") on element delayEndTime.");
         }
         else
         {
            output.writeDouble(this.delayEndTime);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayDelayedActionMessage(input);
      }
      
      public function deserializeAs_GameRolePlayDelayedActionMessage(input:IDataInput) : void {
         this.delayedCharacterId = input.readInt();
         this.delayTypeId = input.readByte();
         if(this.delayTypeId < 0)
         {
            throw new Error("Forbidden value (" + this.delayTypeId + ") on element of GameRolePlayDelayedActionMessage.delayTypeId.");
         }
         else
         {
            this.delayEndTime = input.readDouble();
            if(this.delayEndTime < 0)
            {
               throw new Error("Forbidden value (" + this.delayEndTime + ") on element of GameRolePlayDelayedActionMessage.delayEndTime.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
