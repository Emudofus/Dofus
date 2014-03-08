package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyKickedByMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyKickedByMessage() {
         super();
      }
      
      public static const protocolId:uint = 5590;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var kickerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5590;
      }
      
      public function initPartyKickedByMessage(param1:uint=0, param2:uint=0) : PartyKickedByMessage {
         super.initAbstractPartyMessage(param1);
         this.kickerId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.kickerId = 0;
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
         this.serializeAs_PartyKickedByMessage(param1);
      }
      
      public function serializeAs_PartyKickedByMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         if(this.kickerId < 0)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element kickerId.");
         }
         else
         {
            param1.writeInt(this.kickerId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyKickedByMessage(param1);
      }
      
      public function deserializeAs_PartyKickedByMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.kickerId = param1.readInt();
         if(this.kickerId < 0)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element of PartyKickedByMessage.kickerId.");
         }
         else
         {
            return;
         }
      }
   }
}
