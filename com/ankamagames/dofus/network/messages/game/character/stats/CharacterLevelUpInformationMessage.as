package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterLevelUpInformationMessage extends CharacterLevelUpMessage implements INetworkMessage
   {
      
      public function CharacterLevelUpInformationMessage() {
         super();
      }
      
      public static const protocolId:uint = 6076;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var name:String = "";
      
      public var id:uint = 0;
      
      override public function getMessageId() : uint {
         return 6076;
      }
      
      public function initCharacterLevelUpInformationMessage(newLevel:uint=0, name:String="", id:uint=0) : CharacterLevelUpInformationMessage {
         super.initCharacterLevelUpMessage(newLevel);
         this.name = name;
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterLevelUpInformationMessage(output);
      }
      
      public function serializeAs_CharacterLevelUpInformationMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterLevelUpMessage(output);
         output.writeUTF(this.name);
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterLevelUpInformationMessage(input);
      }
      
      public function deserializeAs_CharacterLevelUpInformationMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.name = input.readUTF();
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of CharacterLevelUpInformationMessage.id.");
         }
         else
         {
            return;
         }
      }
   }
}
