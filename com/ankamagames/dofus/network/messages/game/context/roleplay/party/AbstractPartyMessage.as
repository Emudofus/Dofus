package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AbstractPartyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AbstractPartyMessage() {
         super();
      }
      
      public static const protocolId:uint = 6274;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var partyId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6274;
      }
      
      public function initAbstractPartyMessage(param1:uint=0) : AbstractPartyMessage {
         this.partyId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.partyId = 0;
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
         this.serializeAs_AbstractPartyMessage(param1);
      }
      
      public function serializeAs_AbstractPartyMessage(param1:IDataOutput) : void {
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element partyId.");
         }
         else
         {
            param1.writeInt(this.partyId);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AbstractPartyMessage(param1);
      }
      
      public function deserializeAs_AbstractPartyMessage(param1:IDataInput) : void {
         this.partyId = param1.readInt();
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element of AbstractPartyMessage.partyId.");
         }
         else
         {
            return;
         }
      }
   }
}
