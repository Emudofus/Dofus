package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyCannotJoinErrorMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyCannotJoinErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5583;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 5583;
      }
      
      public function initPartyCannotJoinErrorMessage(param1:uint=0, param2:uint=0) : PartyCannotJoinErrorMessage {
         super.initAbstractPartyMessage(param1);
         this.reason = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.reason = 0;
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
         this.serializeAs_PartyCannotJoinErrorMessage(param1);
      }
      
      public function serializeAs_PartyCannotJoinErrorMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         param1.writeByte(this.reason);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyCannotJoinErrorMessage(param1);
      }
      
      public function deserializeAs_PartyCannotJoinErrorMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.reason = param1.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of PartyCannotJoinErrorMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
