package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CompassResetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CompassResetMessage() {
         super();
      }
      
      public static const protocolId:uint = 5584;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var type:uint = 0;
      
      override public function getMessageId() : uint {
         return 5584;
      }
      
      public function initCompassResetMessage(param1:uint=0) : CompassResetMessage {
         this.type = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
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
         this.serializeAs_CompassResetMessage(param1);
      }
      
      public function serializeAs_CompassResetMessage(param1:IDataOutput) : void {
         param1.writeByte(this.type);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CompassResetMessage(param1);
      }
      
      public function deserializeAs_CompassResetMessage(param1:IDataInput) : void {
         this.type = param1.readByte();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of CompassResetMessage.type.");
         }
         else
         {
            return;
         }
      }
   }
}
