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
      
      public function initLifePointsRegenBeginMessage(param1:uint=0) : LifePointsRegenBeginMessage {
         this.regenRate = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.regenRate = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_LifePointsRegenBeginMessage(param1);
      }
      
      public function serializeAs_LifePointsRegenBeginMessage(param1:IDataOutput) : void {
         if(this.regenRate < 0 || this.regenRate > 255)
         {
            throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
         }
         else
         {
            param1.writeByte(this.regenRate);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_LifePointsRegenBeginMessage(param1);
      }
      
      public function deserializeAs_LifePointsRegenBeginMessage(param1:IDataInput) : void {
         this.regenRate = param1.readUnsignedByte();
         if(this.regenRate < 0 || this.regenRate > 255)
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
