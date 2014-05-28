package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ErrorMapNotFoundMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ErrorMapNotFoundMessage() {
         super();
      }
      
      public static const protocolId:uint = 6197;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mapId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6197;
      }
      
      public function initErrorMapNotFoundMessage(mapId:uint = 0) : ErrorMapNotFoundMessage {
         this.mapId = mapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mapId = 0;
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
         this.serializeAs_ErrorMapNotFoundMessage(output);
      }
      
      public function serializeAs_ErrorMapNotFoundMessage(output:IDataOutput) : void {
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         else
         {
            output.writeInt(this.mapId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ErrorMapNotFoundMessage(input);
      }
      
      public function deserializeAs_ErrorMapNotFoundMessage(input:IDataInput) : void {
         this.mapId = input.readInt();
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of ErrorMapNotFoundMessage.mapId.");
         }
         else
         {
            return;
         }
      }
   }
}
