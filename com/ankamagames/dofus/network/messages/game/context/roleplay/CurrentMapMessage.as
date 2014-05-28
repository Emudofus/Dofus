package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CurrentMapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CurrentMapMessage() {
         super();
      }
      
      public static const protocolId:uint = 220;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var mapId:uint = 0;
      
      public var mapKey:String = "";
      
      override public function getMessageId() : uint {
         return 220;
      }
      
      public function initCurrentMapMessage(mapId:uint = 0, mapKey:String = "") : CurrentMapMessage {
         this.mapId = mapId;
         this.mapKey = mapKey;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.mapId = 0;
         this.mapKey = "";
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
         this.serializeAs_CurrentMapMessage(output);
      }
      
      public function serializeAs_CurrentMapMessage(output:IDataOutput) : void {
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         else
         {
            output.writeInt(this.mapId);
            output.writeUTF(this.mapKey);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CurrentMapMessage(input);
      }
      
      public function deserializeAs_CurrentMapMessage(input:IDataInput) : void {
         this.mapId = input.readInt();
         if(this.mapId < 0)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of CurrentMapMessage.mapId.");
         }
         else
         {
            this.mapKey = input.readUTF();
            return;
         }
      }
   }
}
