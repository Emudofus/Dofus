package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class LifePointsRegenBeginMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function LifePointsRegenBeginMessage() {
         super();
      }
      
      public static const protocolId:uint = 5684;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var regenRate:uint = 0;
      
      override public function getMessageId() : uint {
         return 5684;
      }
      
      public function initLifePointsRegenBeginMessage(regenRate:uint=0) : LifePointsRegenBeginMessage {
         this.regenRate = regenRate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.regenRate = 0;
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
         this.serializeAs_LifePointsRegenBeginMessage(output);
      }
      
      public function serializeAs_LifePointsRegenBeginMessage(output:IDataOutput) : void {
         if((this.regenRate < 0) || (this.regenRate > 255))
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
         }
         else
         {
            output.writeByte(this.regenRate);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_LifePointsRegenBeginMessage(input);
      }
      
      public function deserializeAs_LifePointsRegenBeginMessage(input:IDataInput) : void {
         this.regenRate = input.readUnsignedByte();
         if((this.regenRate < 0) || (this.regenRate > 255))
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element of LifePointsRegenBeginMessage.regenRate.");
         }
         else
         {
            return;
         }
      }
   }
}
