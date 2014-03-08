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
      
      public function initDisplayNumericalValueMessage(param1:int=0, param2:int=0, param3:uint=0) : DisplayNumericalValueMessage {
         this.entityId = param1;
         this.value = param2;
         this.type = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.entityId = 0;
         this.value = 0;
         this.type = 0;
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
         this.serializeAs_DisplayNumericalValueMessage(param1);
      }
      
      public function serializeAs_DisplayNumericalValueMessage(param1:IDataOutput) : void {
         param1.writeInt(this.entityId);
         param1.writeInt(this.value);
         param1.writeByte(this.type);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_DisplayNumericalValueMessage(param1);
      }
      
      public function deserializeAs_DisplayNumericalValueMessage(param1:IDataInput) : void {
         this.entityId = param1.readInt();
         this.value = param1.readInt();
         this.type = param1.readByte();
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
