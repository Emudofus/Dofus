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
      
      public function initCharacterSelectedForceMessage(id:int = 0) : CharacterSelectedForceMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_CharacterSelectedForceMessage(output);
      }
      
      public function serializeAs_CharacterSelectedForceMessage(output:IDataOutput) : void {
         if((this.id < 1) || (this.id > 2147483647))
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectedForceMessage(input);
      }
      
      public function deserializeAs_CharacterSelectedForceMessage(input:IDataInput) : void {
         this.id = input.readInt();
         if((this.id < 1) || (this.id > 2147483647))
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
