package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterCapabilitiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterCapabilitiesMessage() {
         super();
      }
      
      public static const protocolId:uint = 6339;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildEmblemSymbolCategories:uint = 0;
      
      override public function getMessageId() : uint {
         return 6339;
      }
      
      public function initCharacterCapabilitiesMessage(guildEmblemSymbolCategories:uint = 0) : CharacterCapabilitiesMessage {
         this.guildEmblemSymbolCategories = guildEmblemSymbolCategories;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildEmblemSymbolCategories = 0;
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
         this.serializeAs_CharacterCapabilitiesMessage(output);
      }
      
      public function serializeAs_CharacterCapabilitiesMessage(output:IDataOutput) : void {
         if(this.guildEmblemSymbolCategories < 0)
         {
            throw new Error("Forbidden value (" + this.guildEmblemSymbolCategories + ") on element guildEmblemSymbolCategories.");
         }
         else
         {
            output.writeInt(this.guildEmblemSymbolCategories);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterCapabilitiesMessage(input);
      }
      
      public function deserializeAs_CharacterCapabilitiesMessage(input:IDataInput) : void {
         this.guildEmblemSymbolCategories = input.readInt();
         if(this.guildEmblemSymbolCategories < 0)
         {
            throw new Error("Forbidden value (" + this.guildEmblemSymbolCategories + ") on element of CharacterCapabilitiesMessage.guildEmblemSymbolCategories.");
         }
         else
         {
            return;
         }
      }
   }
}
