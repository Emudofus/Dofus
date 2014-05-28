package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapRunningFightDetailsRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapRunningFightDetailsRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5750;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5750;
      }
      
      public function initMapRunningFightDetailsRequestMessage(fightId:uint = 0) : MapRunningFightDetailsRequestMessage {
         this.fightId = fightId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
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
         this.serializeAs_MapRunningFightDetailsRequestMessage(output);
      }
      
      public function serializeAs_MapRunningFightDetailsRequestMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeInt(this.fightId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapRunningFightDetailsRequestMessage(input);
      }
      
      public function deserializeAs_MapRunningFightDetailsRequestMessage(input:IDataInput) : void {
         this.fightId = input.readInt();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of MapRunningFightDetailsRequestMessage.fightId.");
         }
         else
         {
            return;
         }
      }
   }
}
