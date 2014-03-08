package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseKickRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseKickRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5698;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:uint = 0;
      
      override public function getMessageId() : uint {
         return 5698;
      }
      
      public function initHouseKickRequestMessage(id:uint=0) : HouseKickRequestMessage {
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
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
         this.serializeAs_HouseKickRequestMessage(output);
      }
      
      public function serializeAs_HouseKickRequestMessage(output:IDataOutput) : void {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         else
         {
            output.writeInt(this.id);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseKickRequestMessage(input);
      }
      
      public function deserializeAs_HouseKickRequestMessage(input:IDataInput) : void {
         this.id = input.readInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of HouseKickRequestMessage.id.");
         }
         else
         {
            return;
         }
      }
   }
}
