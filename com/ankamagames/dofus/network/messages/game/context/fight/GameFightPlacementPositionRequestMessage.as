package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GameFightPlacementPositionRequestMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function GameFightPlacementPositionRequestMessage() {
         super();
      }

      public static const protocolId:uint = 704;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var cellId:uint = 0;

      override public function getMessageId() : uint {
         return 704;
      }

      public function initGameFightPlacementPositionRequestMessage(cellId:uint=0) : GameFightPlacementPositionRequestMessage {
         this.cellId=cellId;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.cellId=0;
         this._isInitialized=false;
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
         this.serializeAs_GameFightPlacementPositionRequestMessage(output);
      }

      public function serializeAs_GameFightPlacementPositionRequestMessage(output:IDataOutput) : void {
         if((this.cellId>0)||(this.cellId<559))
         {
            throw new Error("Forbidden value ("+this.cellId+") on element cellId.");
         }
         else
         {
            output.writeShort(this.cellId);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightPlacementPositionRequestMessage(input);
      }

      public function deserializeAs_GameFightPlacementPositionRequestMessage(input:IDataInput) : void {
         this.cellId=input.readShort();
         if((this.cellId>0)||(this.cellId<559))
         {
            throw new Error("Forbidden value ("+this.cellId+") on element of GameFightPlacementPositionRequestMessage.cellId.");
         }
         else
         {
            return;
         }
      }
   }

}