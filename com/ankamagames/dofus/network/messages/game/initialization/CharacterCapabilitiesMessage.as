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
      
      public function initCharacterCapabilitiesMessage(param1:uint=0) : CharacterCapabilitiesMessage {
         this.guildEmblemSymbolCategories = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildEmblemSymbolCategories = 0;
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
         this.serializeAs_CharacterCapabilitiesMessage(param1);
      }
      
      public function serializeAs_CharacterCapabilitiesMessage(param1:IDataOutput) : void {
         if(this.guildEmblemSymbolCategories < 0)
         {
            throw new Error("Forbidden value (" + this.guildEmblemSymbolCategories + ") on element guildEmblemSymbolCategories.");
         }
         else
         {
            param1.writeInt(this.guildEmblemSymbolCategories);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterCapabilitiesMessage(param1);
      }
      
      public function deserializeAs_CharacterCapabilitiesMessage(param1:IDataInput) : void {
         this.guildEmblemSymbolCategories = param1.readInt();
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
