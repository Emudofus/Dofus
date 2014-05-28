package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharactersListMessage extends BasicCharactersListMessage implements INetworkMessage
   {
      
      public function CharactersListMessage() {
         super();
      }
      
      public static const protocolId:uint = 151;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var hasStartupActions:Boolean = false;
      
      override public function getMessageId() : uint {
         return 151;
      }
      
      public function initCharactersListMessage(characters:Vector.<CharacterBaseInformations> = null, hasStartupActions:Boolean = false) : CharactersListMessage {
         super.initBasicCharactersListMessage(characters);
         this.hasStartupActions = hasStartupActions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.hasStartupActions = false;
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
         this.serializeAs_CharactersListMessage(output);
      }
      
      public function serializeAs_CharactersListMessage(output:IDataOutput) : void {
         super.serializeAs_BasicCharactersListMessage(output);
         output.writeBoolean(this.hasStartupActions);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharactersListMessage(input);
      }
      
      public function deserializeAs_CharactersListMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.hasStartupActions = input.readBoolean();
      }
   }
}
