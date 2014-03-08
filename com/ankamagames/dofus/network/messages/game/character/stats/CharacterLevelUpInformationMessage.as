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
      
      public function initCharacterLevelUpInformationMessage(param1:uint=0, param2:String="", param3:uint=0) : CharacterLevelUpInformationMessage {
         super.initCharacterLevelUpMessage(param1);
         this.name = param2;
         this.id = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.name = "";
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterLevelUpInformationMessage(param1);
      }
      
      public function serializeAs_CharacterLevelUpInformationMessage(param1:IDataOutput) : void {
         super.serializeAs_CharacterLevelUpMessage(param1);
         param1.writeUTF(this.name);
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            param1.writeInt(this.id);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterLevelUpInformationMessage(param1);
      }
      
      public function deserializeAs_CharacterLevelUpInformationMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.name = param1.readUTF();
         this.id = param1.readInt();
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
