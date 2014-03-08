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
      
      public function initSetCharacterRestrictionsMessage(param1:ActorRestrictionsInformations=null) : SetCharacterRestrictionsMessage {
         this.restrictions = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.restrictions = new ActorRestrictionsInformations();
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
         this.serializeAs_SetCharacterRestrictionsMessage(param1);
      }
      
      public function serializeAs_SetCharacterRestrictionsMessage(param1:IDataOutput) : void {
         this.restrictions.serializeAs_ActorRestrictionsInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SetCharacterRestrictionsMessage(param1);
      }
      
      public function deserializeAs_SetCharacterRestrictionsMessage(param1:IDataInput) : void {
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(param1);
      }
   }
}
