package com.ankamagames.dofus.network.messages.game.initialization
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SetCharacterRestrictionsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SetCharacterRestrictionsMessage() {
         this.restrictions = new ActorRestrictionsInformations();
         super();
      }
      
      public static const protocolId:uint = 170;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var restrictions:ActorRestrictionsInformations;
      
      override public function getMessageId() : uint {
         return 170;
      }
      
      public function initSetCharacterRestrictionsMessage(restrictions:ActorRestrictionsInformations = null) : SetCharacterRestrictionsMessage {
         this.restrictions = restrictions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.restrictions = new ActorRestrictionsInformations();
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
         this.serializeAs_SetCharacterRestrictionsMessage(output);
      }
      
      public function serializeAs_SetCharacterRestrictionsMessage(output:IDataOutput) : void {
         this.restrictions.serializeAs_ActorRestrictionsInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SetCharacterRestrictionsMessage(input);
      }
      
      public function deserializeAs_SetCharacterRestrictionsMessage(input:IDataInput) : void {
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(input);
      }
   }
}
