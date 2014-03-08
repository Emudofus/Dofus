package com.ankamagames.dofus.network.messages.game.character.replay
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterReplayWithRelookRequestMessage extends CharacterReplayRequestMessage implements INetworkMessage
   {
      
      public function CharacterReplayWithRelookRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6354;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cosmeticId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6354;
      }
      
      public function initCharacterReplayWithRelookRequestMessage(param1:uint=0, param2:uint=0) : CharacterReplayWithRelookRequestMessage {
         super.initCharacterReplayRequestMessage(param1);
         this.cosmeticId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cosmeticId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterReplayWithRelookRequestMessage(param1);
      }
      
      public function serializeAs_CharacterReplayWithRelookRequestMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterReplayRequestMessage(param1);
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         else
         {
            param1.writeInt(this.cosmeticId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterReplayWithRelookRequestMessage(param1);
      }
      
      public function deserializeAs_CharacterReplayWithRelookRequestMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.cosmeticId = param1.readInt();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterReplayWithRelookRequestMessage.cosmeticId.");
         }
         else
         {
            return;
         }
      }
   }
}
