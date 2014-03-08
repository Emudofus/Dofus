package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyAbdicateThroneMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyAbdicateThroneMessage() {
         super();
      }
      
      public static const protocolId:uint = 6080;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6080;
      }
      
      public function initPartyAbdicateThroneMessage(param1:uint=0, param2:uint=0) : PartyAbdicateThroneMessage {
         super.initAbstractPartyMessage(param1);
         this.playerId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerId = 0;
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
         this.serializeAs_PartyAbdicateThroneMessage(param1);
      }
      
      public function serializeAs_PartyAbdicateThroneMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(param1);
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         else
         {
            param1.writeInt(this.playerId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyAbdicateThroneMessage(param1);
      }
      
      public function deserializeAs_PartyAbdicateThroneMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerId = param1.readInt();
         if(this.playerId < 0)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of PartyAbdicateThroneMessage.playerId.");
         }
         else
         {
            return;
         }
      }
   }
}
