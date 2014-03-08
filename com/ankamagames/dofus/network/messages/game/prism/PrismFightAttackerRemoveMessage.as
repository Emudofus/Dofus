package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightAttackerRemoveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightAttackerRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5897;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var fighterToRemoveId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5897;
      }
      
      public function initPrismFightAttackerRemoveMessage(subAreaId:uint=0, fightId:Number=0, fighterToRemoveId:uint=0) : PrismFightAttackerRemoveMessage {
         this.subAreaId = subAreaId;
         this.fightId = fightId;
         this.fighterToRemoveId = fighterToRemoveId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.fighterToRemoveId = 0;
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
         this.serializeAs_PrismFightAttackerRemoveMessage(output);
      }
      
      public function serializeAs_PrismFightAttackerRemoveMessage(output:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            output.writeDouble(this.fightId);
            if(this.fighterToRemoveId < 0)
            {
               throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element fighterToRemoveId.");
            }
            else
            {
               output.writeInt(this.fighterToRemoveId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightAttackerRemoveMessage(input);
      }
      
      public function deserializeAs_PrismFightAttackerRemoveMessage(input:IDataInput) : void {
         this.subAreaId = input.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightAttackerRemoveMessage.subAreaId.");
         }
         else
         {
            this.fightId = input.readDouble();
            this.fighterToRemoveId = input.readInt();
            if(this.fighterToRemoveId < 0)
            {
               throw new Error("Forbidden value (" + this.fighterToRemoveId + ") on element of PrismFightAttackerRemoveMessage.fighterToRemoveId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
