package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectedForceMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterSelectedForceMessage() {
         super();
      }
      
      public static const protocolId:uint = 6068;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      override public function getMessageId() : uint {
         return 6068;
      }
      
      public function initCharacterSelectedForceMessage(param1:int=0) : CharacterSelectedForceMessage {
         this.id = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_CharacterSelectedForceMessage(param1);
      }
      
      public function serializeAs_CharacterSelectedForceMessage(param1:IDataOutput) : void {
         if(this.id < 1 || this.id > 2147483647)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterSelectedForceMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectedForceMessage(param1:IDataInput) : void {
         this.id = param1.readInt();
         if(this.id < 1 || this.id > 2147483647)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterSelectedForceMessage.id.");
         }
         else
         {
            return;
         }
      }
   }
}
