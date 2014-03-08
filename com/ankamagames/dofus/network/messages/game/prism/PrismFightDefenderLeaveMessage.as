package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightDefenderLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightDefenderLeaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5892;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var fighterToRemoveId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5892;
      }
      
      public function initPrismFightDefenderLeaveMessage(param1:uint=0, param2:Number=0, param3:uint=0) : PrismFightDefenderLeaveMessage {
         this.subAreaId = param1;
         this.fightId = param2;
         this.fighterToRemoveId = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.fighterToRemoveId = 0;
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
         this.serializeAs_PrismFightDefenderLeaveMessage(param1);
      }
      
      public function serializeAs_PrismFightDefenderLeaveMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            param1.writeDouble(this.fightId);
            if(this.fighterToRemoveId < 0)
            {
               throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element fighterToRemoveId.");
            }
            else
            {
               param1.writeInt(this.fighterToRemoveId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightDefenderLeaveMessage(param1);
      }
      
      public function deserializeAs_PrismFightDefenderLeaveMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefenderLeaveMessage.subAreaId.");
         }
         else
         {
            this.fightId = param1.readDouble();
            this.fighterToRemoveId = param1.readInt();
            if(this.fighterToRemoveId < 0)
            {
               throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element of PrismFightDefenderLeaveMessage.fighterToRemoveId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
