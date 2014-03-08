package com.ankamagames.dofus.network.messages.game.context.display
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DisplayNumericalValueMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DisplayNumericalValueMessage() {
         super();
      }
      
      public static const protocolId:uint = 5808;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var entityId:int = 0;
      
      public var value:int = 0;
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint {
         return 5808;
      }
      
      public function initDisplayNumericalValueMessage(entityId:int=0, value:int=0, type:uint=0) : DisplayNumericalValueMessage {
         this.entityId = entityId;
         this.value = value;
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.value = 0;
         this.type = 0;
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
         this.serializeAs_DisplayNumericalValueMessage(output);
      }
      
      public function serializeAs_DisplayNumericalValueMessage(output:IDataOutput) : void {
         output.writeInt(this.entityId);
         output.writeInt(this.value);
         output.writeByte(this.type);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DisplayNumericalValueMessage(input);
      }
      
      public function deserializeAs_DisplayNumericalValueMessage(input:IDataInput) : void {
         this.entityId = input.readInt();
         this.value = input.readInt();
         this.type = input.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of DisplayNumericalValueMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
